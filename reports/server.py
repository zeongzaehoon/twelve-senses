#!/usr/bin/env python3
"""Twelve Senses 리포트 뷰어 서버

- reports/ 하위 주차 폴더를 스캔해 manifest.json 생성
- /heartbeat 엔드포인트로 브라우저 생존 확인
- 브라우저 탭이 닫히면 15초 후 자동 종료
"""
import os, sys, json, re, time, threading
from http.server import HTTPServer, SimpleHTTPRequestHandler
from pathlib import Path

PORT       = 8765
ROOT       = Path(__file__).parent.parent   # ~/sense/
REPORTS    = Path(__file__).parent          # ~/sense/reports/
TIMEOUT    = 15   # 브라우저 무응답 후 종료까지 대기 (초)
BEAT_EVERY = 3    # 브라우저가 heartbeat를 보내는 간격 (초)

last_beat = time.time()


# ── manifest.json 생성 ────────────────────────────────
def generate_manifest():
    weeks = sorted(
        [d.name for d in REPORTS.iterdir()
         if d.is_dir() and re.match(r'^\d{4}-W\d+$', d.name)],
        reverse=True,
    )
    manifest = {
        week: sorted(f.stem for f in (REPORTS / week).iterdir() if f.suffix == '.md')
        for week in weeks
    }
    (REPORTS / 'manifest.json').write_text(
        json.dumps(manifest, ensure_ascii=False, indent=2), encoding='utf-8'
    )
    print(f'[manifest] {len(weeks)}개 주차 로드됨')
    for w, files in manifest.items():
        print(f'  {w}: {len(files)}개 파일')


# ── HTTP 핸들러 ───────────────────────────────────────
class Handler(SimpleHTTPRequestHandler):
    def do_GET(self):
        global last_beat
        if self.path == '/heartbeat':
            last_beat = time.time()
            self.send_response(200)
            self.send_header('Content-Type', 'application/json')
            self.send_header('Cache-Control', 'no-store')
            self.end_headers()
            self.wfile.write(b'{"ok":true}')
            return
        super().do_GET()

    def log_message(self, *_):
        pass  # 접근 로그 억제


# ── 브라우저 감시 스레드 ───────────────────────────────
def watch_heartbeat():
    time.sleep(TIMEOUT)   # 첫 탭 열릴 시간 충분히 대기
    while True:
        time.sleep(BEAT_EVERY)
        if time.time() - last_beat > TIMEOUT:
            print('\n[서버] 브라우저 종료 감지 → 자동 종료')
            os._exit(0)


# ── 실행 ─────────────────────────────────────────────
os.chdir(ROOT)
generate_manifest()

server = HTTPServer(('127.0.0.1', PORT), Handler)
threading.Thread(target=watch_heartbeat, daemon=True).start()

print(f'\n[서버] http://localhost:{PORT}/reports/index.html')
print('[서버] 브라우저 탭을 닫으면 자동 종료됩니다. (강제 종료: Ctrl+C)\n')

try:
    server.serve_forever()
except KeyboardInterrupt:
    print('\n[서버] 종료')
    sys.exit(0)
