#!/bin/bash
# Twelve Senses 리포트 뷰어
# 더블클릭 → 브라우저 자동 열림. 설치 필요 없음.

DIR="$(cd "$(dirname "$0")" && pwd)"
VIEWER=$(mktemp /tmp/ts-viewer-XXXX.html)

# ── Part 1: HTML 헤더 + CSS + 구조 ──────────────────────
cat > "$VIEWER" << 'HTML_START'
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Twelve Senses — 리포트 뷰어</title>
<style>
  *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
  :root {
    --sidebar-w: 260px; --bg: #0f0f0f; --sidebar-bg: #141414;
    --border: #222; --accent: #c9a96e; --accent-dim: rgba(201,169,110,0.15);
    --text: #e8e8e8; --text-dim: #888; --text-muted: #555;
  }
  body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
    background: var(--bg); color: var(--text); height: 100vh;
    display: flex; flex-direction: column; overflow: hidden; }
  header { display: flex; align-items: center; justify-content: space-between;
    padding: 0 24px; height: 52px; background: var(--sidebar-bg);
    border-bottom: 1px solid var(--border); flex-shrink: 0; }
  .logo { font-size: 14px; font-weight: 600; letter-spacing: .08em;
    color: var(--accent); text-transform: uppercase; }
  .week-selector { display: flex; align-items: center; gap: 8px;
    font-size: 13px; color: var(--text-dim); }
  .week-selector select { background: var(--bg); color: var(--text);
    border: 1px solid var(--border); border-radius: 6px;
    padding: 4px 10px; font-size: 13px; cursor: pointer; outline: none; }
  .week-selector select:focus { border-color: var(--accent); }
  .layout { display: flex; flex: 1; overflow: hidden; }
  aside { width: var(--sidebar-w); background: var(--sidebar-bg);
    border-right: 1px solid var(--border); overflow-y: auto; flex-shrink: 0; }
  aside::-webkit-scrollbar { width: 4px; }
  aside::-webkit-scrollbar-thumb { background: var(--border); border-radius: 2px; }
  .sidebar-section { padding: 16px 12px 8px; }
  .sidebar-section-label { font-size: 10px; font-weight: 600; letter-spacing: .1em;
    text-transform: uppercase; color: var(--text-muted); padding: 0 8px; margin-bottom: 4px; }
  .report-item { display: flex; align-items: center; gap: 10px; padding: 8px 10px;
    border-radius: 6px; cursor: pointer; transition: background .15s; user-select: none; }
  .report-item:hover { background: rgba(255,255,255,.04); }
  .report-item.active { background: var(--accent-dim); }
  .report-item.active .report-name { color: var(--accent); }
  .report-item.missing { opacity: .3; cursor: default; pointer-events: none; }
  .report-icon { font-size: 16px; flex-shrink: 0; width: 20px; text-align: center; }
  .report-info { flex: 1; min-width: 0; }
  .report-name { font-size: 13px; font-weight: 500; color: var(--text);
    white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
  .report-desc { font-size: 11px; color: var(--text-muted); margin-top: 1px;
    white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
  .report-badge { font-size: 10px; color: var(--text-muted); background: var(--border);
    border-radius: 3px; padding: 1px 5px; flex-shrink: 0; }
  .divider { height: 1px; background: var(--border); margin: 8px 12px; }
  main { flex: 1; overflow: hidden; display: flex; flex-direction: column; background: #fff; }
  .content-header { display: flex; align-items: center; gap: 12px; padding: 16px 32px;
    border-bottom: 1px solid #e5e5e5; flex-shrink: 0; }
  .content-header-icon { font-size: 22px; }
  .content-header-title { font-size: 18px; font-weight: 700; color: #1a1a1a; }
  .content-header-desc { font-size: 13px; color: #888; margin-top: 2px; }
  .content-body { flex: 1; overflow-y: auto; padding: 32px 48px 64px; }
  .content-body::-webkit-scrollbar { width: 6px; }
  .content-body::-webkit-scrollbar-thumb { background: #ddd; border-radius: 3px; }
  .markdown-body { max-width: 800px; color: #1a1a1a; font-size: 15px; line-height: 1.75; }
  .markdown-body h1 { font-size: 26px; font-weight: 700; margin: 0 0 20px;
    padding-bottom: 12px; border-bottom: 2px solid #f0f0f0; }
  .markdown-body h2 { font-size: 20px; font-weight: 700; margin: 36px 0 12px; color: #111; }
  .markdown-body h2::before { content: ''; display: inline-block; width: 4px; height: 18px;
    background: #c9a96e; border-radius: 2px; margin-right: 10px;
    vertical-align: middle; margin-top: -2px; }
  .markdown-body h3 { font-size: 16px; font-weight: 600; margin: 24px 0 8px; color: #333; }
  .markdown-body h4 { font-size: 14px; font-weight: 600; margin: 16px 0 6px; color: #555; }
  .markdown-body p { margin: 0 0 14px; }
  .markdown-body ul, .markdown-body ol { margin: 0 0 14px 20px; }
  .markdown-body li { margin-bottom: 4px; }
  .markdown-body strong { font-weight: 700; color: #111; }
  .markdown-body code { font-family: 'SF Mono', monospace; font-size: 13px;
    background: #f5f5f5; border: 1px solid #e8e8e8; border-radius: 4px;
    padding: 1px 6px; color: #c0392b; }
  .markdown-body pre { background: #f8f8f8; border: 1px solid #e8e8e8; border-radius: 8px;
    padding: 16px 20px; overflow-x: auto; margin: 16px 0; }
  .markdown-body pre code { background: none; border: none; padding: 0; color: #333; }
  .markdown-body blockquote { border-left: 3px solid #c9a96e; padding: 8px 16px;
    background: #fdf9f3; border-radius: 0 6px 6px 0; margin: 16px 0; color: #666; font-size: 14px; }
  .markdown-body table { width: 100%; border-collapse: collapse; margin: 16px 0; font-size: 14px; }
  .markdown-body th { background: #f5f5f5; font-weight: 600; padding: 10px 12px;
    text-align: left; border: 1px solid #e0e0e0; color: #333; }
  .markdown-body td { padding: 9px 12px; border: 1px solid #e8e8e8; vertical-align: top; }
  .markdown-body tr:nth-child(even) td { background: #fafafa; }
  .markdown-body hr { border: none; border-top: 1px solid #eee; margin: 28px 0; }
  .markdown-body a { color: #c9a96e; text-decoration: none; }
  .markdown-body a:hover { text-decoration: underline; }
  .state-placeholder { display: flex; flex-direction: column; align-items: center;
    justify-content: center; height: 100%; color: #bbb; gap: 12px; }
  .state-icon { font-size: 48px; opacity: .4; }
  .state-text { font-size: 15px; }
  .state-sub { font-size: 13px; color: #ccc; }
</style>
</head>
<body>
<header>
  <div class="logo">Twelve Senses</div>
  <div class="week-selector">
    <span>주차</span>
    <select id="weekSelect" onchange="onWeekChange()"></select>
  </div>
</header>
<div class="layout">
  <aside id="sidebar"></aside>
  <main id="main">
    <div class="state-placeholder">
      <div class="state-icon">📋</div>
      <div class="state-text">왼쪽에서 리포트를 선택하세요</div>
    </div>
  </main>
</div>
<script>
HTML_START

# ── Part 2: marked.js 인라인 ─────────────────────────
cat "$DIR/reports/marked.min.js" >> "$VIEWER"
printf '\n' >> "$VIEWER"

# ── Part 3: 리포트 메타 + 마크다운 내용 embed ──────────
cat >> "$VIEWER" << 'JS_META'
const REPORTS = [
  { id: '_리서치',        name: '공용 리서치',      icon: '🔍', desc: '시장·경쟁사·트렌드 원천 데이터',  section: '기반 데이터'   },
  { id: '시장조사',       name: '시장조사',          icon: '📊', desc: 'TAM/SAM/SOM 시장 규모',         section: '환경 분석'    },
  { id: 'PEST분석',       name: 'PEST 분석',         icon: '🌐', desc: '거시환경 기회·위협',              section: '환경 분석'    },
  { id: '고객경쟁사분석',  name: '고객·경쟁사 분석',  icon: '👥', desc: "JTBD + Porter's Five Forces",   section: '환경 분석'    },
  { id: 'SWOT분석',       name: 'SWOT 분석',         icon: '⚔️', desc: 'Weighted SWOT + TOWS',         section: '통합 전략'    },
  { id: '전략기획',       name: '전략 기획',          icon: '🎯', desc: 'OKR + BSC + Blue Ocean',        section: '기획'        },
  { id: '제품기획',       name: '제품 기획',          icon: '📱', desc: 'RICE + MoSCoW',                 section: '기획'        },
  { id: 'UI기획',         name: 'UI 기획',            icon: '🖥️', desc: 'Design Thinking + Story Map',  section: '기획'        },
  { id: '디자인',         name: '디자인',             icon: '🎨', desc: 'Design Sprint + Atomic Design', section: '브랜드·디자인' },
  { id: '브랜딩전략',     name: '브랜딩 전략',        icon: '💎', desc: 'Golden Circle + Archetype',      section: '브랜드·디자인' },
  { id: '마케팅전략',     name: '마케팅 전략',        icon: '📣', desc: 'STP + AARRR + Growth Loop',     section: '실행'        },
];
JS_META

# 마크다운 파일들을 base64로 embed
printf 'const EMBEDDED = {\n' >> "$VIEWER"

first_week=true
for week_dir in $(ls -d "$DIR/reports"/[0-9][0-9][0-9][0-9]-W* 2>/dev/null | sort -r); do
  week=$(basename "$week_dir")
  [[ "$first_week" == false ]] && printf ',\n' >> "$VIEWER"
  first_week=false
  printf '  "%s": {\n' "$week" >> "$VIEWER"

  first_file=true
  for md_file in "$week_dir"/*.md; do
    [ -f "$md_file" ] || continue
    name=$(basename "$md_file" .md)
    b64=$(base64 -i "$md_file" | tr -d '\n')
    [[ "$first_file" == false ]] && printf ',\n' >> "$VIEWER"
    first_file=false
    printf '    "%s": "%s"' "$name" "$b64" >> "$VIEWER"
  done
  printf '\n  }' >> "$VIEWER"
done
printf '\n};\n' >> "$VIEWER"

# ── Part 4: 앱 로직 + HTML 닫기 ────────────────────────
cat >> "$VIEWER" << 'JS_APP'

// base64(UTF-8) → 문자열 디코딩
function decode(b64) {
  const bin = atob(b64.replace(/\s/g, ''));
  const bytes = new Uint8Array(bin.length);
  for (let i = 0; i < bin.length; i++) bytes[i] = bin.charCodeAt(i);
  return new TextDecoder('utf-8').decode(bytes);
}

let currentWeek = null;

function init() {
  const weeks = Object.keys(EMBEDDED);
  if (!weeks.length) {
    document.getElementById('weekSelect').innerHTML = '<option>리포트 없음</option>';
    return;
  }
  document.getElementById('weekSelect').innerHTML =
    weeks.map(w => `<option value="${w}">${w} (${Object.keys(EMBEDDED[w]).length}개)</option>`).join('');
  currentWeek = weeks[0];
  renderSidebar(currentWeek);
}

function onWeekChange() {
  currentWeek = document.getElementById('weekSelect').value;
  renderSidebar(currentWeek);
  document.getElementById('main').innerHTML =
    '<div class="state-placeholder"><div class="state-icon">📋</div><div class="state-text">왼쪽에서 리포트를 선택하세요</div></div>';
}

function renderSidebar(week) {
  const available = new Set(Object.keys(EMBEDDED[week] || {}));
  const sections = [...new Set(REPORTS.map(r => r.section))];
  let html = '';
  for (const section of sections) {
    html += `<div class="sidebar-section"><div class="sidebar-section-label">${section}</div>`;
    for (const r of REPORTS.filter(r => r.section === section)) {
      const idx = REPORTS.indexOf(r);
      const exists = available.has(r.id);
      html += `<div class="report-item${exists ? '' : ' missing'}" data-id="${r.id}" onclick="selectReport('${r.id}')">
        <div class="report-icon">${r.icon}</div>
        <div class="report-info">
          <div class="report-name">${r.name}</div>
          <div class="report-desc">${r.desc}</div>
        </div>
        <div class="report-badge">${String(idx).padStart(2,'0')}</div>
      </div>`;
    }
    html += '</div><div class="divider"></div>';
  }
  document.getElementById('sidebar').innerHTML = html;
}

function selectReport(id) {
  document.querySelectorAll('.report-item').forEach(el =>
    el.classList.toggle('active', el.dataset.id === id));
  const r = REPORTS.find(r => r.id === id);
  const b64 = (EMBEDDED[currentWeek] || {})[id];
  if (!b64) {
    document.getElementById('main').innerHTML =
      `<div class="state-placeholder"><div class="state-icon">📭</div>
       <div class="state-text">${r.name} 리포트가 없습니다</div>
       <div class="state-sub">${currentWeek}/${id}.md</div></div>`;
    return;
  }
  const html = marked.parse(decode(b64));
  document.getElementById('main').innerHTML = `
    <div class="content-header">
      <div class="content-header-icon">${r.icon}</div>
      <div>
        <div class="content-header-title">${r.name} — ${currentWeek}</div>
        <div class="content-header-desc">${r.desc}</div>
      </div>
    </div>
    <div class="content-body"><div class="markdown-body">${html}</div></div>`;
}

init();
</script>
</body>
</html>
JS_APP

# 브라우저로 열기
open "$VIEWER"
echo "✅ 뷰어 열림: $VIEWER"
