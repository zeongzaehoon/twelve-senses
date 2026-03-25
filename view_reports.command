#!/bin/bash
# Twelve Senses 리포트 뷰어
# 더블클릭하면 브라우저에서 리포트가 열립니다.
# 브라우저 탭을 닫으면 서버가 자동 종료됩니다.

PORT=8765
DIR="$(cd "$(dirname "$0")" && pwd)"

# 기존 서버가 실행 중이면 종료
lsof -ti:$PORT | xargs kill -9 2>/dev/null
sleep 0.2

# 서버 시작 (manifest 생성 + heartbeat 감시 포함)
python3 "$DIR/reports/server.py" &
SERVER_PID=$!
sleep 0.8

# 브라우저 열기
open "http://localhost:$PORT/reports/index.html"

trap "kill $SERVER_PID 2>/dev/null; exit" SIGTERM SIGINT EXIT
wait $SERVER_PID
