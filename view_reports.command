#!/bin/bash
# Twelve Senses 리포트 뷰어 — Magazine + Dark Mode Edition

DIR="$(cd "$(dirname "$0")" && pwd)"
VIEWER="/tmp/ts-viewer-$$.html"

cat > "$VIEWER" << 'HTML_START'
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>Twelve Senses | Weekly Report</title>
<link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300;400;500;600;700;900&family=Inter:wght@300;400;500;600;700&family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
<style>
/* ── Theme Variables ── */
:root {
  --bg:          #F9F9F9;
  --bg-top:      rgba(249,249,249,0.92);
  --bg-sidebar:  #EEEEEE;
  --bg-masthead: #111111;
  --bg-surface:  #E8E8E8;
  --bg-hover:    #F0F0F0;
  --bg-stripe:   #F7F7F7;
  --border:      #E0E0E0;
  --border-sub:  #F0F0F0;
  --accent:      #000000;
  --t1:          #1a1a1a;
  --t2:          #444444;
  --t3:          #888888;
  --t4:          #bbbbbb;
  --t5:          #cccccc;
  --t-inv:       #ffffff;
  --t-inv2:      rgba(255,255,255,0.65);
  --t-inv3:      rgba(255,255,255,0.28);
  --nav-act-bg:  #000000;
  --nav-act-txt: #ffffff;
  --ri-act-bg:   #ffffff;
  --badge-ok-bg: #000;    --badge-ok-txt: #fff;
  --badge-ms-bg: #EBEBEB; --badge-ms-txt: #bbbbbb;
  --th-bg: #000; --th-txt: #fff;
  --bq-bg: #F2F2F2; --bq-border: #000;
  --code-bg: #EBEBEB; --pre-bg: #111; --pre-txt: #E2E2E2;
  --ann-border: #000;
  --reading-bar: #000; --reading-glow: none;
  --flow-canvas: #EFEFEF;
  --flow-node: #fff; --flow-node-brd: #000;
  --flow-miss: #E8E8E8; --flow-miss-brd: #D4D4D4;
  --flow-sel-bg: #000; --flow-sel-ic: #fff; --flow-sel-lb: rgba(255,255,255,0.88);
  --flow-sel-shadow: 0 0 0 2px #000,0 6px 20px rgba(0,0,0,0.14);
  --flow-legend: #E4E4E4;
  --flow-panel: #F9F9F9;
  --flow-card: #fff; --flow-card-brd: #E4E4E4;
  --flow-edge: #999; --flow-edge-hl: #000; --flow-edge-off: #DDD;
  --fnode-ic: #000; --fnode-lb: #333;
  --r0: 0px; --r1: 0px; --r2: 0px; --rfull: 0px;
  --fh: 'Space Grotesk',sans-serif;
  --fb: 'Inter',sans-serif;
}
html.dark {
  --bg:          #060e20;
  --bg-top:      rgba(6,14,32,0.8);
  --bg-sidebar:  rgba(6,14,32,0.9);
  --bg-masthead: #091328;
  --bg-surface:  #0f1930;
  --bg-hover:    rgba(131,174,255,0.07);
  --bg-stripe:   rgba(15,25,48,0.5);
  --border:      rgba(64,72,93,0.45);
  --border-sub:  rgba(64,72,93,0.2);
  --accent:      #83aeff;
  --t1:          #dee5ff;
  --t2:          #a3aac4;
  --t3:          #6d758c;
  --t4:          #40485d;
  --t5:          #2d3a52;
  --t-inv:       #dee5ff;
  --t-inv2:      rgba(222,229,255,0.7);
  --t-inv3:      rgba(222,229,255,0.3);
  --nav-act-bg:  rgba(131,174,255,0.15);
  --nav-act-txt: #83aeff;
  --ri-act-bg:   rgba(131,174,255,0.1);
  --badge-ok-bg: rgba(131,174,255,0.15); --badge-ok-txt: #83aeff;
  --badge-ms-bg: rgba(64,72,93,0.3);     --badge-ms-txt: #40485d;
  --th-bg: #192540; --th-txt: #83aeff;
  --bq-bg: rgba(131,174,255,0.08); --bq-border: #83aeff;
  --code-bg: rgba(15,25,48,0.8); --pre-bg: #040b19; --pre-txt: #a3aac4;
  --ann-border: #83aeff;
  --reading-bar: #83aeff; --reading-glow: 0 0 14px rgba(131,174,255,0.5);
  --flow-canvas: #040b19;
  --flow-node: #0f1930; --flow-node-brd: rgba(131,174,255,0.35);
  --flow-miss: #091328; --flow-miss-brd: rgba(64,72,93,0.3);
  --flow-sel-bg: #192540; --flow-sel-ic: #83aeff; --flow-sel-lb: #dee5ff;
  --flow-sel-shadow: 0 0 0 2px #83aeff,0 6px 24px rgba(131,174,255,0.25);
  --flow-legend: rgba(9,19,40,0.9);
  --flow-panel: #060e20;
  --flow-card: #0f1930; --flow-card-brd: rgba(64,72,93,0.35);
  --flow-edge: rgba(131,174,255,0.3); --flow-edge-hl: #83aeff; --flow-edge-off: rgba(64,72,93,0.25);
  --fnode-ic: #83aeff; --fnode-lb: #a3aac4;
  --r0: 10px; --r1: 16px; --r2: 24px; --rfull: 9999px;
  --fh: 'Plus Jakarta Sans',sans-serif;
  --fb: 'Plus Jakarta Sans',sans-serif;
}

/* ── Global ── */
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
html,body{height:100%;overflow:hidden}
body{font-family:var(--fb);background:var(--bg);color:var(--t1);-webkit-font-smoothing:antialiased;transition:background .3s,color .3s}
html:not(.dark) ::selection{background:#000;color:#fff}
html.dark ::selection{background:rgba(131,174,255,0.3);color:#dee5ff}
.mi{font-family:'Material Symbols Outlined';font-variation-settings:'FILL' 0,'wght' 400,'GRAD' 0,'opsz' 24;font-style:normal;vertical-align:middle;display:inline-block;line-height:1}
.mif{font-variation-settings:'FILL' 1,'wght' 400,'GRAD' 0,'opsz' 24}
::-webkit-scrollbar{width:4px}
::-webkit-scrollbar-track{background:transparent}
::-webkit-scrollbar-thumb{background:var(--border)}

/* ── Sidebar ── */
#sidebar{width:236px;flex-shrink:0;height:100vh;overflow-y:auto;background:var(--bg-sidebar);border-right:1px solid var(--border);display:flex;flex-direction:column;transition:background .3s,border-color .3s}
html.dark #sidebar{backdrop-filter:blur(24px)}
.brand{height:50px;padding:0 22px;display:flex;flex-direction:column;justify-content:center;gap:3px;border-bottom:1px solid var(--border);flex-shrink:0}
.brand-title{font-family:var(--fh);font-weight:900;font-size:12px;letter-spacing:0.18em;text-transform:uppercase;color:var(--t1)}
.brand-sub{font-size:9px;letter-spacing:0.2em;text-transform:uppercase;color:var(--t4);margin-top:4px}
.nav-btn{display:flex;align-items:center;gap:10px;padding:11px 22px;font-size:10px;font-weight:700;text-transform:uppercase;letter-spacing:0.1em;cursor:pointer;border:none;background:transparent;color:var(--t3);width:100%;font-family:var(--fh);transition:all .15s;text-align:left;border-radius:var(--r0)}
.nav-btn:hover{color:var(--t1);background:var(--bg-hover)}
.nav-btn.active{background:var(--nav-act-bg);color:var(--nav-act-txt)}
#weekSelect{background:transparent;border:none;color:var(--t1);font-family:var(--fh);font-size:10px;font-weight:700;text-transform:uppercase;letter-spacing:0.1em;cursor:pointer;outline:none;padding:0;-webkit-appearance:auto;appearance:auto}
.sec-label{font-size:9px;font-weight:700;text-transform:uppercase;letter-spacing:0.12em;color:var(--t4);padding:14px 22px 5px}
.ri{display:flex;align-items:center;gap:9px;padding:7px 22px;cursor:pointer;transition:background .1s;border-left:2px solid transparent}
.ri:hover{background:var(--bg-hover)}
.ri.active{background:var(--ri-act-bg);border-left-color:var(--accent)}
.ri.missing{opacity:0.3;pointer-events:none}
.ri-icon{width:20px;height:20px;display:flex;align-items:center;justify-content:center;flex-shrink:0}
.rn{font-size:11px;font-weight:600;color:var(--t2);line-height:1.2}

/* ── Topbar ── */
#topbar{height:50px;display:flex;align-items:center;justify-content:space-between;padding:0 28px 0 40px;border-bottom:1px solid var(--border);flex-shrink:0;background:var(--bg-top);backdrop-filter:blur(20px);position:relative;z-index:10;transition:background .3s,border-color .3s}
.bc{display:flex;align-items:center;gap:8px;font-family:var(--fh);font-size:10px;font-weight:700;text-transform:uppercase;letter-spacing:0.1em}
.bc-dim{color:var(--t5)} .bc-week{color:var(--t1)} .bc-sep{color:var(--t5)} .bc-rep{color:var(--t3)}
.reading-bar{position:absolute;bottom:0;left:0;height:2px;background:var(--reading-bar);box-shadow:var(--reading-glow);transition:width .15s,background .3s,box-shadow .3s;width:0%}
#theme-toggle{width:30px;height:30px;border-radius:var(--rfull);border:1px solid var(--border);background:var(--bg-surface);cursor:pointer;display:flex;align-items:center;justify-content:center;color:var(--t3);transition:all .2s;flex-shrink:0}
#theme-toggle:hover{color:var(--t1);border-color:var(--accent)}

/* ── Content area ── */
#content-area{flex:1;position:relative;overflow:hidden}
#v-dash{position:absolute;top:0;left:0;right:0;bottom:0;overflow-y:auto;display:none;flex-direction:column}
#v-dash.show{display:flex}
#v-read{position:absolute;top:0;left:0;right:0;bottom:0;overflow-y:auto;display:none}
#v-read.show{display:block}
#v-flow{position:absolute;top:0;left:0;right:0;bottom:0;overflow:hidden;display:none;flex-direction:row}
#v-flow.show{display:flex}

/* ── Dashboard ── */
.dash-masthead{background:var(--bg-masthead);padding:44px 48px 38px;display:grid;grid-template-columns:1fr 256px;gap:32px;align-items:start;flex-shrink:0;transition:background .3s}
.dash-issue{font-family:var(--fh);font-size:9px;font-weight:700;letter-spacing:0.28em;text-transform:uppercase;color:var(--t-inv3);margin-bottom:14px}
.dash-headline{font-family:var(--fh);font-weight:900;font-size:clamp(2.2rem,4.5vw,3.8rem);line-height:0.92;letter-spacing:-0.04em;text-transform:uppercase;color:var(--t-inv)}
.dash-sub{color:var(--t-inv3);font-size:12px;margin-top:14px;line-height:1.6;max-width:420px}
.kpi-grid{display:grid;grid-template-columns:1fr 1fr;gap:1px}
.kpi-card{padding:18px 20px;background:rgba(255,255,255,0.04);display:flex;flex-direction:column;gap:3px}
html.dark .kpi-card{background:rgba(131,174,255,0.04)}
.kpi-card.wide{grid-column:span 2}
.kpi-label{font-size:8px;font-weight:700;text-transform:uppercase;letter-spacing:0.18em;color:var(--t-inv3)}
.kpi-value{font-family:var(--fh);font-size:2rem;font-weight:900;line-height:1;color:var(--t-inv)}
.kpi-desc{font-size:9px;color:var(--t-inv3);line-height:1.4;margin-top:2px}
.pipe-chip{display:inline-flex;align-items:center;gap:4px;padding:3px 9px;font-size:9px;font-weight:700;text-transform:uppercase;letter-spacing:0.05em;margin:2px 2px 2px 0;border-radius:var(--rfull)}
.pipe-chip.done{background:rgba(255,255,255,0.14);color:rgba(255,255,255,0.9)}
html.dark .pipe-chip.done{background:rgba(131,174,255,0.2);color:#83aeff}
.pipe-chip.partial{background:rgba(255,255,255,0.06);color:rgba(255,255,255,0.35)}
html.dark .pipe-chip.partial{background:rgba(131,174,255,0.07);color:rgba(131,174,255,0.5)}
.pipe-chip.empty{background:rgba(255,255,255,0.02);color:rgba(255,255,255,0.15)}
.rg-wrap{padding:36px 48px;flex:1}
.rg-header{margin-bottom:18px;display:flex;justify-content:space-between;align-items:baseline}
.rg-title{font-family:var(--fh);font-weight:900;font-size:9px;letter-spacing:0.22em;text-transform:uppercase;color:var(--t1)}
.rg-count{font-size:11px;color:var(--t4)}
.rg-table{width:100%;border-top:2px solid var(--accent)}
.rg-th{display:grid;grid-template-columns:32px 1fr 110px 80px 36px;gap:14px;padding:8px 0;border-bottom:1px solid var(--border)}
.rg-th-cell{font-size:8px;font-weight:700;text-transform:uppercase;letter-spacing:0.12em;color:var(--t4)}
.rg-row{display:grid;grid-template-columns:32px 1fr 110px 80px 36px;gap:14px;padding:13px 0;border-bottom:1px solid var(--border-sub);align-items:center;cursor:pointer;transition:background .12s;border-radius:var(--r0)}
.rg-row:hover{background:var(--bg-hover)}
.rg-row.unavail{opacity:0.3;cursor:default;pointer-events:none}
.rg-num{font-family:var(--fh);font-size:10px;font-weight:700;color:var(--t5)}
.rg-icon{width:30px;height:30px;background:var(--bg-surface);display:flex;align-items:center;justify-content:center;flex-shrink:0;border-radius:var(--r0)}
.rg-name{font-size:13px;font-weight:600;color:var(--t1)}
.rg-desc{font-size:10px;color:var(--t4);margin-top:2px}
.badge-ok{display:inline-block;padding:3px 9px;background:var(--badge-ok-bg);color:var(--badge-ok-txt);font-size:8px;font-weight:700;letter-spacing:0.1em;text-transform:uppercase;border-radius:var(--rfull)}
.badge-miss{display:inline-block;padding:3px 9px;background:var(--badge-ms-bg);color:var(--badge-ms-txt);font-size:8px;font-weight:700;letter-spacing:0.1em;text-transform:uppercase;border-radius:var(--rfull)}
.rg-sec{font-size:10px;font-weight:600;text-transform:uppercase;letter-spacing:0.05em;color:var(--t4)}

/* ── Reader ── */
.read-masthead{background:var(--bg-masthead);padding:68px 48px 52px;transition:background .3s}
.read-issue-label{font-family:var(--fh);font-size:9px;font-weight:700;letter-spacing:0.3em;text-transform:uppercase;color:var(--t-inv3);margin-bottom:18px}
.read-headline{font-family:var(--fh);font-weight:900;font-size:clamp(2rem,4.5vw,3.8rem);line-height:0.92;letter-spacing:-0.04em;text-transform:uppercase;max-width:680px;color:var(--t-inv)}
.read-meta-row{display:flex;gap:32px;margin-top:28px;padding-top:20px;border-top:1px solid rgba(255,255,255,0.1);flex-wrap:wrap}
.read-meta-item{display:flex;flex-direction:column;gap:3px}
.read-meta-label{font-size:8px;font-weight:700;text-transform:uppercase;letter-spacing:0.18em;color:var(--t-inv3)}
.read-meta-val{font-size:11px;font-weight:600;color:var(--t-inv2)}
.article-wrap{max-width:1100px;margin:0 auto;padding:52px 48px 20px;display:grid;grid-template-columns:220px 1fr;gap:56px;align-items:start}
.annotation{position:sticky;top:20px}
.annotation-block{border-left:3px solid var(--ann-border);padding-left:15px;margin-bottom:28px;transition:border-color .3s}
.annotation-label{font-family:var(--fh);font-size:8px;font-weight:700;text-transform:uppercase;letter-spacing:0.18em;color:var(--t4);margin-bottom:7px}
.annotation-text{font-size:12px;line-height:1.75;color:var(--t3);font-style:italic}
.annotation-link{display:flex;align-items:center;gap:7px;padding:7px 0;border-bottom:1px solid var(--border-sub);font-size:11px;font-weight:600;color:var(--t4);cursor:pointer;transition:color .15s;background:none;border-top:none;border-left:none;border-right:none;width:100%;text-align:left;font-family:var(--fb)}
.annotation-link:hover{color:var(--accent)}
.annotation-back{display:flex;align-items:center;gap:6px;font-size:9px;font-weight:700;text-transform:uppercase;letter-spacing:0.12em;color:var(--t4);background:none;border:none;cursor:pointer;font-family:var(--fh);padding:0;margin-top:20px;transition:color .15s}
.annotation-back:hover{color:var(--accent)}

/* ── Prose ── */
.prose{color:var(--t2);line-height:1.88;font-size:15px}
.prose h1{font-family:var(--fh);font-weight:900;font-size:2rem;line-height:1;letter-spacing:-0.04em;text-transform:uppercase;color:var(--t1);margin:0 0 1.5rem;border-bottom:3px solid var(--accent);padding-bottom:11px}
.prose h2{font-family:var(--fh);font-weight:900;font-size:1.3rem;text-transform:uppercase;color:var(--t1);margin:2.75rem 0 0.9rem;padding-bottom:7px;border-bottom:2px solid var(--accent)}
.prose h3{font-family:var(--fh);font-weight:700;font-size:0.95rem;text-transform:uppercase;letter-spacing:0.05em;color:var(--t1);margin:2rem 0 0.7rem}
.prose h4{font-size:0.875rem;font-weight:700;color:var(--t3);margin:1.5rem 0 0.5rem;text-transform:uppercase;letter-spacing:0.06em}
.prose p{margin:0 0 1.2rem}
.prose ul{list-style:none;margin:0 0 1.2rem;padding:0}
.prose ul li{padding:.2rem 0 .2rem 1.2rem;position:relative}
.prose ul li::before{content:'';position:absolute;left:.2rem;top:.74rem;width:4px;height:4px;background:var(--accent);border-radius:var(--rfull)}
.prose ol{list-style:decimal;margin:0 0 1.2rem 1.5rem}
.prose ol li{padding:.2rem 0}
.prose strong{color:var(--t1);font-weight:700}
.prose em{font-style:italic;color:var(--t3)}
.prose code{background:var(--code-bg);color:var(--t1);padding:2px 6px;font-size:.84em;font-family:'SF Mono','Fira Code',monospace;border-radius:var(--r0)}
.prose pre{background:var(--pre-bg);color:var(--pre-txt);padding:22px;overflow-x:auto;margin:1.5rem 0;border-radius:var(--r1)}
.prose pre code{background:none;color:inherit;padding:0}
.prose blockquote{margin:2.25rem 0;padding:18px 22px;background:var(--bq-bg);border-left:4px solid var(--bq-border);border-radius:var(--r0);transition:background .3s,border-color .3s}
.prose blockquote p{font-family:var(--fh);font-weight:700;font-size:1.1rem;line-height:1.45;color:var(--t1);margin:0}
.prose table{width:100%;border-collapse:collapse;margin:1.5rem 0;font-size:13px}
.prose th{font-family:var(--fh);font-weight:700;font-size:9px;text-transform:uppercase;letter-spacing:0.12em;color:var(--th-txt);background:var(--th-bg);padding:9px 13px;text-align:left}
.prose td{padding:9px 13px;border-bottom:1px solid var(--border-sub);color:var(--t2)}
.prose tr:nth-child(even) td{background:var(--bg-stripe)}
.prose tr:last-child td{border-bottom:none}
.prose hr{border:none;border-top:2px solid var(--accent);margin:2.75rem 0;opacity:0.4}
.prose a{color:var(--accent)}
.prose img{width:100%;height:auto;display:block;filter:grayscale(100%) brightness(.88);transition:filter .5s;margin:1.5rem 0;border-radius:var(--r1)}
.prose img:hover{filter:none}
html.dark .prose img{filter:grayscale(30%) brightness(.65)}
html.dark .prose img:hover{filter:none}
.nav-footer{display:grid;grid-template-columns:1fr 1fr;border-top:2px solid var(--accent);margin-top:56px}
.nf-btn{padding:26px 0;display:flex;flex-direction:column;gap:5px;cursor:pointer;background:none;border:none;text-align:left;transition:background .15s;font-family:var(--fb);width:100%}
.nf-btn:first-child{border-right:1px solid var(--border);padding-right:28px}
.nf-btn:last-child{text-align:right;align-items:flex-end;padding-left:28px}
.nf-btn:hover{background:var(--bg-hover)}
.nf-label{font-family:var(--fh);font-size:8px;font-weight:700;text-transform:uppercase;letter-spacing:0.18em;color:var(--t4);display:flex;align-items:center;gap:5px}
.nf-name{font-family:var(--fh);font-weight:900;font-size:1rem;letter-spacing:-0.02em;text-transform:uppercase;color:var(--t1);margin-top:3px}

/* ── Flow Map ── */
#flow-canvas-wrap{flex:1;overflow:auto;padding:36px;background:var(--flow-canvas);transition:background .3s}
#flow-canvas{position:relative;width:1160px;height:430px}
#flow-svg{position:absolute;top:0;left:0;pointer-events:none;z-index:0}
.fnode{position:absolute;display:flex;flex-direction:column;align-items:center;justify-content:center;gap:5px;transition:all .2s;user-select:none;z-index:1}
.fnode-label{font-size:8px;font-weight:700;text-transform:uppercase;letter-spacing:.04em;text-align:center;line-height:1.3;padding:0 4px;max-width:72px}
.flow-legend{display:flex;align-items:center;gap:14px;margin-top:18px;padding:9px 15px;background:var(--flow-legend);width:fit-content;border-radius:var(--r0)}
.flow-legend-dot{width:8px;height:8px;border-radius:var(--rfull)}
.flow-legend-label{font-size:9px;font-weight:700;text-transform:uppercase;letter-spacing:.1em;color:var(--t4)}
#flow-panel{width:268px;border-left:1px solid var(--border);overflow-y:auto;padding:22px;background:var(--flow-panel);flex-shrink:0;display:flex;flex-direction:column;gap:10px;transition:background .3s,border-color .3s}
.flow-panel-title{font-family:var(--fh);font-weight:900;font-size:9px;text-transform:uppercase;letter-spacing:.18em;color:var(--t1);margin-bottom:2px}
.flow-conn-row{font-size:11px;color:var(--t4);padding:3px 0;display:flex;align-items:center;gap:6px}
.flow-conn-heading{font-size:8px;color:var(--t4);text-transform:uppercase;font-weight:700;letter-spacing:.1em;margin-bottom:4px}
.flow-open-btn{width:100%;padding:12px;background:var(--accent);border:none;color:var(--bg);font-size:10px;font-weight:700;cursor:pointer;font-family:var(--fh);text-transform:uppercase;letter-spacing:.12em;display:flex;align-items:center;justify-content:center;gap:8px;transition:opacity .15s;border-radius:var(--rfull)}
html.dark .flow-open-btn{color:#002d63}
.flow-open-btn:hover{opacity:.8}
.flow-node-card{background:var(--flow-card);border:1px solid var(--flow-card-brd);padding:16px;margin-bottom:8px;border-radius:var(--r1)}
</style>
</head>
<body>
<div style="display:flex;height:100vh;overflow:hidden">

<aside id="sidebar">
  <div class="brand">
    <div class="brand-title">Twelve Senses</div>
    <div class="brand-sub">Weekly Intelligence</div>
  </div>
  <div style="margin-top:6px">
    <button id="nav-db" class="nav-btn active" onclick="showDashboard()">
      <span class="mi" style="font-size:15px">dashboard</span>Dashboard
    </button>
    <button id="nav-flow" class="nav-btn" onclick="showFlowMap()">
      <span class="mi" style="font-size:15px">account_tree</span>Flow Map
    </button>
  </div>
  <div style="padding:18px 22px 6px">
    <div style="font-size:8px;font-weight:700;text-transform:uppercase;letter-spacing:0.18em;color:var(--t4);margin-bottom:8px">Intelligence</div>
    <div style="height:1px;background:var(--border)"></div>
  </div>
  <div style="flex:1;overflow-y:auto" id="side-list"></div>
</aside>

<div style="flex:1;display:flex;flex-direction:column;overflow:hidden;min-width:0">
  <header id="topbar">
    <div class="bc">
      <span class="bc-dim">TWELVE SENSES</span>
      <span class="bc-sep"> / </span>
      <select id="weekSelect" class="bc-week" onchange="onWeekChange()"></select>
      <span class="bc-sep" id="bc-sep" style="display:none"> / </span>
      <span class="bc-rep" id="bc-rep"></span>
    </div>
    <div style="display:flex;align-items:center;gap:10px">
      <button id="theme-toggle" onclick="toggleTheme()" title="다크/라이트 모드 전환">
        <span class="mi" id="theme-icon" style="font-size:16px">dark_mode</span>
      </button>
    </div>
    <div class="reading-bar" id="reading-bar"></div>
  </header>

  <div id="content-area">

    <!-- Dashboard -->
    <div id="v-dash">
      <div class="dash-masthead">
        <div>
          <div class="dash-issue" id="dash-issue">WEEKLY REPORT · TWELVE SENSES</div>
          <h1 class="dash-headline">Weekly<br>Digest</h1>
          <p class="dash-sub">주간 분석 리포트. 아래 인덱스에서 리포트를 선택하세요.</p>
        </div>
        <div class="kpi-grid">
          <div class="kpi-card">
            <div class="kpi-label">완료</div>
            <div class="kpi-value" id="kpi-done">0</div>
            <div class="kpi-desc">리포트 완료</div>
          </div>
          <div class="kpi-card">
            <div class="kpi-label">완료율</div>
            <div class="kpi-value" id="kpi-pct">0%</div>
            <div class="kpi-desc">전체 대비</div>
          </div>
          <div class="kpi-card wide">
            <div class="kpi-label" style="margin-bottom:6px">Pipeline</div>
            <div id="kpi-pipeline" style="display:flex;gap:2px;flex-wrap:wrap"></div>
          </div>
        </div>
      </div>
      <div class="rg-wrap">
        <div class="rg-header">
          <span class="rg-title">Report Index</span>
          <span class="rg-count" id="cnt"></span>
        </div>
        <div class="rg-table">
          <div class="rg-th">
            <div class="rg-th-cell">#</div>
            <div class="rg-th-cell">Report</div>
            <div class="rg-th-cell">Section</div>
            <div class="rg-th-cell">Status</div>
            <div class="rg-th-cell"></div>
          </div>
          <div id="rg"></div>
        </div>
      </div>
    </div>

    <!-- Reader -->
    <div id="v-read">
      <div class="read-masthead">
        <div class="read-issue-label" id="read-issue-label">TWELVE SENSES · WEEKLY REPORT</div>
        <h1 class="read-headline" id="read-headline">리포트</h1>
        <div class="read-meta-row" id="read-meta-row"></div>
      </div>
      <div class="article-wrap">
        <div class="annotation">
          <div class="annotation-block">
            <div class="annotation-label">핵심 요약</div>
            <div class="annotation-text" id="annotation-text">—</div>
          </div>
          <div style="margin-top:22px">
            <div class="annotation-label" style="margin-bottom:6px">관련 리포트</div>
            <div id="related-links"></div>
          </div>
          <button class="annotation-back" onclick="showDashboard()">
            <span class="mi" style="font-size:13px">arrow_back</span>목록으로
          </button>
        </div>
        <div>
          <div class="prose" id="ab"></div>
          <div class="nav-footer">
            <button class="nf-btn" id="bp" onclick="navR(-1)">
              <span class="nf-label"><span class="mi" style="font-size:13px">arrow_back</span>이전 리포트</span>
              <span class="nf-name" id="pl"></span>
            </button>
            <button class="nf-btn" id="bn" onclick="navR(1)">
              <span class="nf-label">다음 리포트<span class="mi" style="font-size:13px">arrow_forward</span></span>
              <span class="nf-name" id="nl"></span>
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Flow Map -->
    <div id="v-flow">
      <div id="flow-canvas-wrap">
        <div id="flow-canvas">
          <svg id="flow-svg" width="1160" height="430"></svg>
        </div>
        <div class="flow-legend">
          <div style="display:flex;align-items:center;gap:7px">
            <div class="flow-legend-dot" id="leg-avail"></div>
            <span class="flow-legend-label">Available</span>
          </div>
          <div style="display:flex;align-items:center;gap:7px">
            <div class="flow-legend-dot" id="leg-miss" style="border:1px solid var(--t5)"></div>
            <span class="flow-legend-label">Missing</span>
          </div>
          <div style="width:1px;height:12px;background:var(--border);margin:0 2px"></div>
          <button onclick="showDashboard()" style="background:none;border:none;color:var(--t4);font-size:9px;font-weight:700;cursor:pointer;font-family:var(--fh);display:flex;align-items:center;gap:4px;text-transform:uppercase;letter-spacing:.1em;transition:color .15s" onmouseover="this.style.color=getComputedStyle(document.documentElement).getPropertyValue('--accent').trim()" onmouseout="this.style.color=getComputedStyle(document.documentElement).getPropertyValue('--t4').trim()">
            <span class="mi" style="font-size:13px">arrow_back</span>Dashboard
          </button>
        </div>
      </div>
      <aside id="flow-panel">
        <div class="flow-panel-title">Active Node</div>
        <div id="flow-detail" style="display:flex;flex-direction:column;align-items:center;justify-content:center;flex:1;gap:12px;text-align:center">
          <span class="mi" style="font-size:38px;color:var(--t5)">account_tree</span>
          <p style="font-size:12px;color:var(--t4);line-height:1.7">노드를 클릭하면<br>리포트 정보가 표시됩니다</p>
        </div>
      </aside>
    </div>

  </div>
</div>
</div>
<script>
HTML_START

cat "$DIR/reports/marked.min.js" >> "$VIEWER"
printf '\n' >> "$VIEWER"

cat >> "$VIEWER" << 'JS_META'

const REPORTS = [
  { id: '_리서치',        name: '공용 리서치',      icon: 'search',         desc: '시장·경쟁사·트렌드 원천 데이터',  section: '기반 데이터', tags: ['Research','Data'],     color:'#83aeff', colorBg:'rgba(131,174,255,0.13)' },
  { id: '시장조사',       name: '시장조사',          icon: 'bar_chart',      desc: 'TAM/SAM/SOM 시장 규모',         section: '환경 분석',   tags: ['Market','TAM'],        color:'#34d399', colorBg:'rgba(52,211,153,0.12)'  },
  { id: 'PEST분석',       name: 'PEST 분석',         icon: 'public',         desc: '거시환경 기회·위협',              section: '환경 분석',   tags: ['PESTLE','Macro'],      color:'#fb923c', colorBg:'rgba(251,146,60,0.12)'  },
  { id: '고객경쟁사분석',  name: '고객·경쟁사',       icon: 'group',          desc: "JTBD + Porter's Five Forces",   section: '환경 분석',   tags: ['3C','JTBD'],           color:'#c084fc', colorBg:'rgba(192,132,252,0.12)' },
  { id: 'SWOT분석',       name: 'SWOT 분석',         icon: 'compare_arrows', desc: 'Weighted SWOT + TOWS',          section: '통합 전략',   tags: ['SWOT','Strategy'],     color:'#fbbf24', colorBg:'rgba(251,191,36,0.12)'  },
  { id: '전략기획',       name: '전략 기획',          icon: 'ads_click',      desc: 'OKR + BSC + Blue Ocean',        section: '기획',        tags: ['OKR','BSC'],           color:'#38bdf8', colorBg:'rgba(56,189,248,0.12)'  },
  { id: '제품기획',       name: '제품 기획',          icon: 'smartphone',     desc: 'RICE + MoSCoW',                 section: '기획',        tags: ['Product','RICE'],      color:'#22d3ee', colorBg:'rgba(34,211,238,0.12)'  },
  { id: 'UI기획',         name: 'UI 기획',            icon: 'draw',           desc: 'Design Thinking + Story Map',   section: '기획',        tags: ['UX','UI'],             color:'#f472b6', colorBg:'rgba(244,114,182,0.12)' },
  { id: '디자인',         name: '디자인',             icon: 'palette',        desc: 'Design Sprint + Atomic Design', section: '브랜드',      tags: ['Design','Atomic'],     color:'#a78bfa', colorBg:'rgba(167,139,250,0.12)' },
  { id: '브랜딩전략',     name: '브랜딩 전략',        icon: 'diamond',        desc: 'Golden Circle + Archetype',     section: '브랜드',      tags: ['Brand','Identity'],    color:'#fb7185', colorBg:'rgba(251,113,133,0.12)' },
  { id: '마케팅전략',     name: '마케팅 전략',        icon: 'campaign',       desc: 'STP + AARRR + Growth Loop',     section: '실행',        tags: ['Marketing','Growth'],  color:'#4ade80', colorBg:'rgba(74,222,128,0.12)'  },
];
const PIPELINE = [
  { label: 'Research',  ids: ['_리서치'],                              icon: 'search'          },
  { label: 'Analysis',  ids: ['시장조사','PEST분석','고객경쟁사분석'],   icon: 'analytics'       },
  { label: 'Strategy',  ids: ['SWOT분석','전략기획'],                   icon: 'compare_arrows'  },
  { label: 'Planning',  ids: ['제품기획','UI기획'],                     icon: 'draw'            },
  { label: 'Brand',     ids: ['디자인','브랜딩전략','마케팅전략'],       icon: 'palette'         },
];
const FLOW_NODES = [
  { id: '_리서치',        cx:  80, cy: 215, name: '공용 리서치',   icon: 'search'          },
  { id: '시장조사',       cx: 280, cy:  80, name: '시장조사',       icon: 'bar_chart'       },
  { id: 'PEST분석',       cx: 280, cy: 215, name: 'PEST 분석',      icon: 'public'          },
  { id: '고객경쟁사분석',  cx: 280, cy: 350, name: '고객·경쟁사',    icon: 'group'           },
  { id: 'SWOT분석',       cx: 480, cy: 215, name: 'SWOT 분석',      icon: 'compare_arrows'  },
  { id: '전략기획',       cx: 675, cy: 110, name: '전략 기획',       icon: 'ads_click'       },
  { id: '제품기획',       cx: 675, cy: 320, name: '제품 기획',       icon: 'smartphone'      },
  { id: 'UI기획',         cx: 870, cy:  80, name: 'UI 기획',         icon: 'draw'            },
  { id: '디자인',         cx: 870, cy: 215, name: '디자인',          icon: 'palette'         },
  { id: '브랜딩전략',     cx: 870, cy: 350, name: '브랜딩 전략',     icon: 'diamond'         },
  { id: '마케팅전략',     cx:1070, cy: 215, name: '마케팅 전략',     icon: 'campaign'        },
];
const FLOW_EDGES = [
  { f: '_리서치',       t: '시장조사'        },
  { f: '_리서치',       t: 'PEST분석'        },
  { f: '_리서치',       t: '고객경쟁사분석'   },
  { f: '시장조사',      t: 'SWOT분석'        },
  { f: 'PEST분석',      t: 'SWOT분석'        },
  { f: '고객경쟁사분석', t: 'SWOT분석'        },
  { f: 'SWOT분석',      t: '전략기획'        },
  { f: 'SWOT분석',      t: '제품기획'        },
  { f: '전략기획',      t: 'UI기획'          },
  { f: '전략기획',      t: '디자인'          },
  { f: '전략기획',      t: '브랜딩전략'       },
  { f: '제품기획',      t: 'UI기획'          },
  { f: '제품기획',      t: '디자인'          },
  { f: '제품기획',      t: '브랜딩전략'       },
  { f: 'UI기획',        t: '마케팅전략'       },
  { f: '디자인',        t: '마케팅전략'       },
  { f: '브랜딩전략',    t: '마케팅전략'       },
];
JS_META

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

cat >> "$VIEWER" << 'JS_APP'

function decode(b64) {
  const bin = atob(b64.replace(/\s/g,''));
  const bytes = new Uint8Array(bin.length);
  for (let i=0;i<bin.length;i++) bytes[i]=bin.charCodeAt(i);
  return new TextDecoder('utf-8').decode(bytes);
}
function esc(s){ return s.replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;'); }
function cv(name){ return getComputedStyle(document.documentElement).getPropertyValue(name).trim(); }
function isDark(){ return document.documentElement.classList.contains('dark'); }

let currentWeek=null, currentId=null, flowSelected=null;

// ── Theme ──────────────────────────────────────────────
function applyTheme(dark) {
  document.documentElement.classList.toggle('dark', dark);
  document.getElementById('theme-icon').textContent = dark ? 'light_mode' : 'dark_mode';
  const la = document.getElementById('leg-avail');
  const lm = document.getElementById('leg-miss');
  if (la) la.style.background = dark ? '#83aeff' : '#000';
  if (lm) lm.style.background = dark ? '#0f1930' : '#E8E8E8';
  try { localStorage.setItem('ts-theme', dark ? 'dark' : 'light'); } catch(e){}
  // 테마 전환 시 인라인 색상 재렌더링
  if (currentWeek) {
    renderSidebar(currentWeek);
    renderDashboard(currentWeek);
    if (document.getElementById('v-flow').classList.contains('show')) {
      renderFlowMap(currentWeek);
    }
  }
}
function toggleTheme() { applyTheme(!isDark()); }

// ── Init ──────────────────────────────────────────────
function init() {
  // restore saved theme
  try {
    const saved = localStorage.getItem('ts-theme');
    if (saved === 'dark') applyTheme(true);
    else if (!saved && window.matchMedia('(prefers-color-scheme: dark)').matches) applyTheme(true);
  } catch(e){}

  const weeks = Object.keys(EMBEDDED).sort().reverse();
  if (!weeks.length) {
    document.getElementById('weekSelect').innerHTML = '<option>리포트 없음</option>';
    return;
  }
  document.getElementById('weekSelect').innerHTML =
    weeks.map(w=>`<option value="${w}">${w}  (${Object.keys(EMBEDDED[w]).length}개)</option>`).join('');
  currentWeek = weeks[0];
  updateBcWeek(currentWeek);
  renderSidebar(currentWeek);
  renderDashboard(currentWeek);
  showDashboard();
}

function onWeekChange() {
  currentWeek = document.getElementById('weekSelect').value;
  currentId = null;
  updateBcWeek(currentWeek);
  renderSidebar(currentWeek);
  renderDashboard(currentWeek);
  showDashboard();
}
function updateBcWeek(w){ const s=document.getElementById('weekSelect'); if(s) s.value=w; }

function renderSidebar(week) {
  const avail = new Set(Object.keys(EMBEDDED[week]||{}));
  const sections = [...new Set(REPORTS.map(r=>r.section))];
  let html='';
  for (const sec of sections) {
    html += `<div class="sec-label">${esc(sec)}</div>`;
    for (const r of REPORTS.filter(r=>r.section===sec)) {
      const ok = avail.has(r.id);
      const ic = ok && isDark() ? r.color : 'var(--t4)';
      html += `<div class="ri${ok?'':' missing'}${currentId===r.id?' active':''}" onclick="selectReport('${esc(r.id)}')" data-id="${esc(r.id)}">
        <div class="ri-icon"><span class="mi" style="font-size:13px;color:${ic}">${esc(r.icon)}</span></div>
        <div style="flex:1;min-width:0"><div class="rn">${esc(r.name)}</div></div>
      </div>`;
    }
  }
  document.getElementById('side-list').innerHTML = html;
}

function renderDashboard(week) {
  const avail = new Set(Object.keys(EMBEDDED[week]||{}));
  const total=REPORTS.length, done=REPORTS.filter(r=>avail.has(r.id)).length;
  const pct=Math.round((done/total)*100);
  document.getElementById('dash-issue').textContent = `${week} · TWELVE SENSES`;
  document.getElementById('kpi-done').textContent = done;
  document.getElementById('kpi-pct').textContent = pct+'%';
  document.getElementById('cnt').textContent = `${done} / ${total} 리포트 완료`;

  let phtml='';
  PIPELINE.forEach(s=>{
    const done=s.ids.every(id=>avail.has(id)), any=s.ids.some(id=>avail.has(id));
    const cls=done?'done':any?'partial':'empty';
    phtml+=`<span class="pipe-chip ${cls}"><span class="mi" style="font-size:11px">${esc(s.icon)}</span>${esc(s.label)}</span>`;
  });
  document.getElementById('kpi-pipeline').innerHTML=phtml;

  let rhtml='';
  REPORTS.forEach((r,i)=>{
    const ok=avail.has(r.id);
    rhtml+=`<div class="rg-row${ok?'':' unavail'}" onclick="selectReport('${esc(r.id)}')">
      <div class="rg-num">${String(i+1).padStart(2,'0')}</div>
      <div style="display:flex;align-items:center;gap:11px">
        <div class="rg-icon" style="${ok&&isDark()?`background:${r.colorBg};`:''}"><span class="mi" style="font-size:14px;color:${ok&&isDark()?r.color:'var(--t4)'}">${esc(r.icon)}</span></div>
        <div><div class="rg-name">${esc(r.name)}</div><div class="rg-desc">${esc(r.desc)}</div></div>
      </div>
      <div class="rg-sec">${esc(r.section)}</div>
      <div><span class="${ok?'badge-ok':'badge-miss'}">${ok?'READY':'MISSING'}</span></div>
      <div style="display:flex;justify-content:flex-end"><span class="mi" style="font-size:17px;color:var(--t5)">arrow_forward</span></div>
    </div>`;
  });
  document.getElementById('rg').innerHTML=rhtml;
}

function setNav(activeId) {
  ['nav-db','nav-flow','nav-reports'].forEach(id=>{
    const el=document.getElementById(id);
    if(el) el.classList.toggle('active',el.id===activeId);
  });
}
function hideAllViews(){ ['v-dash','v-read','v-flow'].forEach(id=>document.getElementById(id).classList.remove('show')); }

function showDashboard() {
  currentId=null; flowSelected=null;
  hideAllViews();
  document.getElementById('v-dash').classList.add('show');
  document.getElementById('bc-sep').style.display='none';
  document.getElementById('bc-rep').textContent='';
  document.getElementById('reading-bar').style.width='0%';
  setNav('nav-db');
  document.querySelectorAll('.ri').forEach(el=>el.classList.remove('active'));
}

function showFlowMap() {
  currentId=null; flowSelected=null;
  hideAllViews();
  document.getElementById('v-flow').classList.add('show');
  document.getElementById('bc-sep').style.display='none';
  document.getElementById('bc-rep').textContent='';
  document.getElementById('reading-bar').style.width='0%';
  setNav('nav-flow');
  document.querySelectorAll('.ri').forEach(el=>el.classList.remove('active'));
  renderFlowMap(currentWeek);
}

function renderFlowMap(week) {
  const NW=80,NH=80;
  const avail=new Set(Object.keys(EMBEDDED[week]||{}));
  const canvas=document.getElementById('flow-canvas');
  canvas.querySelectorAll('.fnode').forEach(n=>n.remove());
  drawEdges(avail,null);
  FLOW_NODES.forEach(node=>{
    const ok=avail.has(node.id);
    const div=document.createElement('div');
    div.className='fnode';
    div.dataset.id=node.id;
    const rdata = REPORTS.find(r=>r.id===node.id);
    const nodeBg = ok && isDark() && rdata ? rdata.colorBg : (ok ? cv('--flow-node') : cv('--flow-miss'));
    const nodeBrd = ok && isDark() && rdata ? rdata.color+'44' : (ok ? cv('--flow-node-brd') : cv('--flow-miss-brd'));
    const nodeIc = ok && isDark() && rdata ? rdata.color : (ok ? cv('--fnode-ic') : cv('--t5'));
    div.style.cssText=`left:${node.cx-NW/2}px;top:${node.cy-NH/2}px;width:${NW}px;height:${NH}px;`+
      `background:${nodeBg};`+
      `border:${ok?`2px solid ${nodeBrd}`:`1px solid ${cv('--flow-miss-brd')}`};`+
      `border-radius:${cv('--r0')};cursor:${ok?'pointer':'default'}`;
    div.innerHTML=`<span class="mi" style="font-size:20px;color:${nodeIc}">${node.icon}</span>`+
      `<span class="fnode-label" style="color:${ok?cv('--fnode-lb'):cv('--t5')};font-family:${cv('--fh')}">${node.name}</span>`;
    if (ok) {
      div.addEventListener('click',()=>selectFlowNode(node.id));
      div.addEventListener('mouseover',()=>{
        if(node.id!==flowSelected){
          div.style.background=isDark()&&rdata ? rdata.colorBg.replace('0.12','0.22').replace('0.13','0.23') : cv('--bg-hover');
          div.style.transform='scale(1.05)';
          div.style.boxShadow=isDark()&&rdata ? `0 4px 20px ${rdata.color}22` : '0 4px 14px rgba(0,0,0,0.1)';
        }
      });
      div.addEventListener('mouseout',()=>{
        if(node.id!==flowSelected){
          div.style.background=nodeBg;
          div.style.transform='scale(1)';
          div.style.boxShadow='none';
        }
      });
    }
    canvas.appendChild(div);
  });
  document.getElementById('flow-detail').innerHTML=`
    <div style="display:flex;flex-direction:column;align-items:center;gap:12px;text-align:center">
      <span class="mi" style="font-size:38px;color:var(--t5)">account_tree</span>
      <p style="font-size:12px;color:var(--t4);line-height:1.7">노드를 클릭하면<br>리포트 정보가 표시됩니다</p>
    </div>`;
}

function drawEdges(avail,selectedId) {
  const NW=80;
  let paths='';
  FLOW_EDGES.forEach(e=>{
    const fn=FLOW_NODES.find(n=>n.id===e.f), tn=FLOW_NODES.find(n=>n.id===e.t);
    if(!fn||!tn) return;
    const active=avail.has(fn.id)&&avail.has(tn.id);
    const hl=selectedId&&(e.f===selectedId||e.t===selectedId);
    const x1=fn.cx+NW/2,y1=fn.cy,x2=tn.cx-NW/2,y2=tn.cy,mx=(x1+x2)/2;
    const stroke=hl?cv('--flow-edge-hl'):active?cv('--flow-edge'):cv('--flow-edge-off');
    const sw=hl?2:active?1.5:1;
    paths+=`<path d="M ${x1} ${y1} C ${mx} ${y1} ${mx} ${y2} ${x2} ${y2}" fill="none" stroke="${stroke}" stroke-width="${sw}"/>`;
  });
  document.getElementById('flow-svg').innerHTML=paths;
}

function selectFlowNode(id) {
  flowSelected=id;
  const avail=new Set(Object.keys(EMBEDDED[currentWeek]||{}));
  drawEdges(avail,id);
  document.querySelectorAll('.fnode').forEach(el=>{
    const nid=el.dataset.id;
    if(!avail.has(nid)) return;
    const sel=nid===id;
    const rdata=REPORTS.find(r=>r.id===nid);
    el.style.background   = sel?cv('--flow-sel-bg'):(isDark()&&rdata?rdata.colorBg:cv('--flow-node'));
    el.style.borderColor  = sel?cv('--flow-edge-hl'):(isDark()&&rdata?rdata.color+'44':cv('--flow-node-brd'));
    el.style.borderWidth  = sel?'2px':'2px';
    el.style.boxShadow    = sel?cv('--flow-sel-shadow'):'none';
    el.style.transform    = sel?'scale(1.08)':'scale(1)';
    const ic=el.querySelector('.mi'), lb=el.querySelector('.fnode-label');
    if(ic) ic.style.color=sel?cv('--flow-sel-ic'):(isDark()&&rdata?rdata.color:cv('--fnode-ic'));
    if(lb) lb.style.color=sel?cv('--flow-sel-lb'):cv('--fnode-lb');
  });
  const r=REPORTS.find(r=>r.id===id); if(!r) return;
  const incoming=FLOW_EDGES.filter(e=>e.t===id).map(e=>{const n=FLOW_NODES.find(n=>n.id===e.f);return n?`<div class="flow-conn-row"><span class="mi" style="font-size:12px">arrow_back</span>${n.name}</div>`:''}).join('');
  const outgoing=FLOW_EDGES.filter(e=>e.f===id).map(e=>{const n=FLOW_NODES.find(n=>n.id===e.t);return n?`<div class="flow-conn-row"><span class="mi" style="font-size:12px">arrow_forward</span>${n.name}</div>`:''}).join('');
  document.getElementById('flow-detail').innerHTML=`
    <div class="flow-node-card">
      <div style="display:flex;align-items:center;gap:10px;margin-bottom:11px">
        <div style="width:34px;height:34px;background:${isDark()?r.colorBg:'var(--accent)'};display:flex;align-items:center;justify-content:center;flex-shrink:0;border-radius:var(--r0)">
          <span class="mi" style="color:${isDark()?r.color:'var(--bg)'};font-size:16px">${r.icon}</span>
        </div>
        <div>
          <div style="font-family:var(--fh);font-weight:700;color:var(--t1);font-size:13px;line-height:1.2">${r.name}</div>
          <div style="font-size:9px;color:var(--t4);text-transform:uppercase;letter-spacing:.08em;margin-top:2px">${r.section}</div>
        </div>
      </div>
      <p style="font-size:11px;color:var(--t3);line-height:1.6;margin-bottom:${incoming||outgoing?'11px':'0'}">${r.desc}</p>
      ${incoming?`<div style="margin-bottom:8px"><div class="flow-conn-heading">Reads From</div>${incoming}</div>`:''}
      ${outgoing?`<div><div class="flow-conn-heading">Feeds Into</div>${outgoing}</div>`:''}
    </div>
    <button class="flow-open-btn" onclick="selectReport('${id}')">
      <span class="mi" style="font-size:14px">open_in_new</span>리포트 열기
    </button>`;
}

function selectReport(id) {
  const b64=(EMBEDDED[currentWeek]||{})[id];
  const r=REPORTS.find(r=>r.id===id);
  if(!r||!b64) return;
  currentId=id;
  document.querySelectorAll('.ri').forEach(el=>el.classList.toggle('active',el.dataset.id===id));
  setNav('nav-reports');
  document.getElementById('bc-sep').style.display='inline';
  document.getElementById('bc-rep').textContent=r.name;

  const md=decode(b64), html=marked.parse(md);
  document.getElementById('ab').innerHTML=html;

  const bq=document.querySelector('#ab blockquote p'), fp=document.querySelector('#ab > p');
  const annotText=bq?bq.textContent.slice(0,200):(fp?fp.textContent.slice(0,140)+(fp.textContent.length>140?'…':''):r.desc);
  document.getElementById('annotation-text').textContent=annotText;

  const ilEl=document.getElementById('read-issue-label');
  ilEl.textContent=`${currentWeek} · ${r.section}`;
  ilEl.style.color=isDark()?r.color:'';

  document.getElementById('read-headline').textContent=r.name;
  document.getElementById('read-meta-row').innerHTML=[
    {label:'섹션',val:r.section},{label:'방법론',val:r.desc},{label:'주차',val:currentWeek},{label:'태그',val:r.tags.join(' · ')},
  ].map(m=>`<div class="read-meta-item"><div class="read-meta-label">${esc(m.label)}</div><div class="read-meta-val">${esc(m.val)}</div></div>`).join('');

  const avail=new Set(Object.keys(EMBEDDED[currentWeek]||{}));
  const connected=[...FLOW_EDGES.filter(e=>e.f===id).map(e=>e.t),...FLOW_EDGES.filter(e=>e.t===id).map(e=>e.f)]
    .filter((rid,i,arr)=>arr.indexOf(rid)===i&&avail.has(rid));
  document.getElementById('related-links').innerHTML=connected.map(rid=>{
    const rr=REPORTS.find(x=>x.id===rid);
    return rr?`<button class="annotation-link" onclick="selectReport('${esc(rid)}')"><span class="mi" style="font-size:12px">link</span>${esc(rr.name)}</button>`:'';
  }).join('');

  const idx=REPORTS.indexOf(r);
  const prevR=REPORTS.slice(0,idx).reverse().find(x=>avail.has(x.id));
  const nextR=REPORTS.slice(idx+1).find(x=>avail.has(x.id));
  document.getElementById('pl').textContent=prevR?prevR.name:'';
  document.getElementById('nl').textContent=nextR?nextR.name:'';
  document.getElementById('bp').style.visibility=prevR?'visible':'hidden';
  document.getElementById('bn').style.visibility=nextR?'visible':'hidden';
  document.getElementById('reading-bar').style.width='0%';

  hideAllViews();
  document.getElementById('v-read').classList.add('show');
  document.getElementById('v-read').scrollTop=0;
  setNav('');
}

function navR(dir) {
  if(!currentId) return;
  const avail=new Set(Object.keys(EMBEDDED[currentWeek]||{}));
  const idx=REPORTS.findIndex(r=>r.id===currentId); if(idx<0) return;
  const cands=dir<0?REPORTS.slice(0,idx).reverse():REPORTS.slice(idx+1);
  const t=cands.find(r=>avail.has(r.id)); if(t) selectReport(t.id);
}

document.getElementById('v-read').addEventListener('scroll',function(){
  const el=this, pct=el.scrollHeight>el.clientHeight?(el.scrollTop/(el.scrollHeight-el.clientHeight))*100:0;
  document.getElementById('reading-bar').style.width=pct+'%';
});

init();
</script>
</body>
</html>
JS_APP

open "$VIEWER"
echo "✅ 뷰어 열림: $VIEWER"
