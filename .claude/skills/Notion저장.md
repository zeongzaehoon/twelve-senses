# Notion 보고서 저장 스킬

분석 보고서를 Notion 📊 주간 분석 보고서 데이터베이스에 저장하는 방법.
블록 타입 전체 레퍼런스 → [Notion-블록레퍼런스.md](references/Notion-블록레퍼런스.md)

## Notion 연결 정보

| 항목 | 값 |
|------|-----|
| 페이지명 | [개인] TwelveSense |
| 페이지 ID | `3299f52b-c636-801c-bc4f-d656074382d4` |
| 데이터베이스명 | 📊 주간 분석 보고서 |
| **데이터베이스 ID** | **`33f9f52b-c636-8183-8a2a-f8bf9146b778`** |
| 접근 방법 | Notion MCP `mcp__notion__*` 도구 사용 |

---

## 전체 저장 플로우

```
로컬 reports/{주차}/{보고서유형}.md 저장 완료
        ↓
[Step 1] DB에 동일 보고서명 존재 확인 (notion_query_database)
        ↓
  ┌─ 없음 ──→ [Step 2] 신규 항목 생성 (notion_create_database_item)
  └─ 있음 ──→ [Step 2b] 속성 업데이트 (notion_update_page_properties)
                            ↓ page_id 획득
        ↓
[Step 3] 리치 포맷으로 상세 내용 블록 추가 (notion_append_block_children)
        ↓
완료 보고
```

---

## Step 1 — 중복 확인

```python
mcp__notion__notion_query_database(
    database_id = "33f9f52b-c636-8183-8a2a-f8bf9146b778",
    filter = {
        "property": "보고서명",
        "title": { "equals": "시장조사 — 2026-W15" }
    }
)
```

---

## Step 2 — 데이터베이스 항목 생성

```python
mcp__notion__notion_create_database_item(
    database_id = "33f9f52b-c636-8183-8a2a-f8bf9146b778",
    properties = {
        "보고서명":   { "title":     [{ "text": { "content": "{보고서유형} — {주차}" } }] },
        "주차":       { "select":    { "name": "2026-W{NN}" } },
        "보고서 유형":{ "select":    { "name": "{보고서유형}" } },
        "분석 단계":  { "select":    { "name": "STEP {N}" } },
        "상태":       { "status":    { "name": "완료" } },
        "작성일":     { "date":      { "start": "YYYY-MM-DD" } },
        "Executive Summary": { "rich_text": [{ "text": { "content": "요약 3줄" } }] },
        "핵심 인사이트":     { "rich_text": [{ "text": { "content": "• 인사이트1\n• 인사이트2\n• 인사이트3\n• 인사이트4\n• 인사이트5" } }] },
        "실행 과제 Top 3":   { "rich_text": [{ "text": { "content": "1. 과제1\n2. 과제2\n3. 과제3" } }] }
    }
)
# → 응답에서 page_id 추출
```

---

## Step 3 — 리치 포맷 블록 추가

### 공통 페이지 헤더 (모든 보고서)

```python
mcp__notion__notion_append_block_children(
    block_id = "{page_id}",
    children = [
        # 목차
        { "object": "block", "type": "table_of_contents", "table_of_contents": { "color": "default" } },
        { "object": "block", "type": "divider", "divider": {} },

        # Executive Summary 콜아웃
        {
            "object": "block", "type": "callout",
            "callout": {
                "icon": { "type": "emoji", "emoji": "💡" },
                "color": "yellow_background",
                "rich_text": [{ "type": "text", "text": { "content": "Executive Summary\n{3줄 요약}" }, "annotations": { "bold": True } }]
            }
        },
        { "object": "block", "type": "divider", "divider": {} },

        # 이하 보고서별 섹션 블록들 추가 →
    ]
)
```

---

## 보고서별 리치 포맷 템플릿

### 📊 시장조사

```
heading_1 "1. TAM/SAM/SOM 분석"
image → QuickChart 막대 차트 (TAM/SAM/SOM 수치)
table(5열) → 구분 | Top-Down | Bottom-Up | 채택값 | 근거
divider
heading_1 "2. 이번 주 시장 신호 Top 5"
callout(blue, 🚀) × 5개 (각 시장 신호 별도 callout)
divider
heading_1 "3. 크라우드펀딩 유사 제품 비교"
table → 제품명 | 플랫폼 | 목표액 | 달성률 | 특이사항
divider
callout(orange, 🎯) "이번 주 실행 과제 Top 3"
  numbered_list_item × 3
```

**QuickChart TAM/SAM/SOM 예시:**
```
https://quickchart.io/chart?w=600&h=300&c={"type":"bar","data":{"labels":["TAM","SAM","SOM"],"datasets":[{"label":"시장규모(억달러)","data":[76,3.4,0.05],"backgroundColor":["rgba(99,102,241,0.8)","rgba(99,102,241,0.5)","rgba(99,102,241,0.2)"]}]},"options":{"plugins":{"title":{"display":true,"text":"홈프래그런스 TAM/SAM/SOM 2024"}}}}
```

---

### 🌐 PEST분석

```
heading_1 "1. PESTLE 6요소 분석"
table(5열) → 요소 | 핵심 이슈 | Twelve Senses 영향 | 영향도(1-5) | 시급도
divider
heading_1 "2. Top 3 주요 시사점"
callout(yellow, 💡) × 3개
divider
heading_1 "3. 시나리오 플래닝 매트릭스"
column_list(2단)
  └─ column: 시나리오 A (유리/유리)
  └─ column: 시나리오 B (유리/불리)
column_list(2단)
  └─ column: 시나리오 C (불리/유리)
  └─ column: 시나리오 D (불리/불리)
divider
callout(red, ⚠️) "즉각 대응 필요 항목"
  bulleted_list_item × N
```

---

### 👥 고객경쟁사분석

```
heading_1 "1. JTBD 분석"
table(4열) → Job 유형 | 고객의 Job | 현재 대안 | 전환 비용
divider
heading_1 "2. 경쟁사 포지셔닝 맵"
image → QuickChart 레이더 차트 (경쟁사 비교)
table → 경쟁사별 기능/가격/포지셔닝 비교
divider
heading_1 "3. Porter's Five Forces"
table(3열) → 요인 | 강도(1-5) | 근거
  (5개 행: 신규진입 | 공급자 | 구매자 | 대체재 | 경쟁강도)
```

**QuickChart 경쟁사 레이더 예시:**
```
https://quickchart.io/chart?w=500&h=400&c={"type":"radar","data":{"labels":["AI개인화","디자인","가격경쟁력","B2B역량","생태계"],"datasets":[{"label":"Twelve Senses","data":[9,8,5,7,6],"borderColor":"#6366f1"},{"label":"Dyson Aura","data":[4,9,4,6,7],"borderColor":"#f43f5e"}]}}
```

---

### 🔷 SWOT분석

```
heading_1 "1. Weighted SWOT"
column_list(2단)
  ├── column:
  │     callout(green, ✅) "Strengths"
  │     bulleted_list_item × N (점수 포함)
  └── column:
        callout(red, ❌) "Weaknesses"
        bulleted_list_item × N
column_list(2단)
  ├── column:
  │     callout(blue, 🚀) "Opportunities"
  │     bulleted_list_item × N
  └── column:
        callout(orange, ⚠️) "Threats"
        bulleted_list_item × N
divider
heading_1 "2. TOWS 매트릭스"
table(3열, 3행) →
  헤더: (빈칸) | Opportunities | Threats
  행1:  Strengths | S-O 전략 내용 | S-T 전략 내용
  행2:  Weaknesses | W-O 전략 내용 | W-T 전략 내용
divider
callout(orange, 🎯) "이번 주 최우선 전략 과제 3가지"
  numbered_list_item × 3
```

---

### 📋 전략기획 (OKR + BSC + Blue Ocean)

```
heading_1 "1. OKR 현황"
toggle(blue, bold) "🎯 O1: {목표}"
  to_do "KR1: ... (달성률 X%)"
  to_do "KR2: ... (달성률 X%)"
toggle(purple, bold) "🎯 O2: {목표}"
  to_do ...
divider
heading_1 "2. BSC 4관점 점검"
table(4열) → 관점 | KPI | 현재값 | 목표 | 상태(🟢🟡🔴)
divider
heading_1 "3. Blue Ocean ERRC"
table(3열) → 액션 | 항목 | 내용
  행: 제거(Eliminate) | 감소(Reduce) | 증가(Raise) | 창조(Create)
divider
callout(orange, 🎯) "이번 주 최우선 실행 과제 3가지"
```

---

### 🎨 브랜딩전략 (Golden Circle + Brand Pyramid + Archetype)

```
heading_1 "1. Golden Circle"
column_list(3단)
  ├── column: callout(purple) "WHY" + 내용
  ├── column: callout(blue)   "HOW" + 내용
  └── column: callout(gray)   "WHAT" + 내용
quote(purple, italic) "핵심 마케팅 메시지 재작성 제안"
divider
heading_1 "2. Brand Pyramid"
toggle(purple) "👑 Brand Essence — {1단어/구문}"
toggle(blue)   "🔭 Brand Vision — {미래상}"
toggle(green)  "💎 Brand Values — {가치 3가지}"
toggle(orange) "🤝 Brand Promise — {고객과의 약속}"
toggle(gray)   "⚙️ Features & Benefits — {제품 기능}"
divider
heading_1 "3. Brand Archetype: Creator"
callout(purple, 🎭) "선정 아케타입 + 선정 이유"
table(3열) → 항목 | Creator 기준 | Twelve Senses 적용
  행: 톤 오브 보이스 | 비주얼 스타일 | 콘텐츠 방향
```

---

### 📣 마케팅전략 (STP + AARRR + Growth Loop)

```
heading_1 "1. STP 분석"
table(5열) → 세그먼트 | 인구통계 | 심리통계 | 행동특성 | 시장규모
callout(purple, 👑) "포지셔닝 스테이트먼트"
  quote(italic) "{타겟}을 위한 Twelve Senses는..."
divider
heading_1 "2. AARRR 퍼널"
image → QuickChart 수평 막대 차트 (단계별 수치)
table(5열) → 단계 | 핵심지표 | 현재값 | 목표 | 병목여부
callout(red, ⚠️) "병목 구간: {구간명} — 개선안"
divider
heading_1 "3. Growth Loop"
code(plain text) → ASCII 플로우 다이어그램
callout(green, 🔗) "가장 약한 연결고리 + 이번 주 강화 액션"
```

**QuickChart AARRR 예시:**
```
https://quickchart.io/chart?w=600&h=250&c={"type":"horizontalBar","data":{"labels":["Revenue","Referral","Retention","Activation","Acquisition"],"datasets":[{"label":"사용자수","data":[30,50,200,400,1000],"backgroundColor":["#818cf8","#a78bfa","#c4b5fd","#ddd6fe","#ede9fe"]}]}}
```

---

## 페이지 마무리 블록 (공통)

모든 보고서 마지막에 추가:
```python
[
    { "object": "block", "type": "divider", "divider": {} },
    {
        "object": "block", "type": "callout",
        "callout": {
            "icon": { "type": "emoji", "emoji": "🎯" },
            "color": "orange_background",
            "rich_text": [{ "type": "text", "text": { "content": "이번 주 실행 과제 Top 3" }, "annotations": { "bold": True } }]
        }
    },
    { "object": "block", "type": "numbered_list_item",
      "numbered_list_item": { "rich_text": [{ "type": "text", "text": { "content": "과제 1 — 담당: {담당} | 기한: {날짜}" } }] } },
    { "object": "block", "type": "numbered_list_item",
      "numbered_list_item": { "rich_text": [{ "type": "text", "text": { "content": "과제 2" } }] } },
    { "object": "block", "type": "numbered_list_item",
      "numbered_list_item": { "rich_text": [{ "type": "text", "text": { "content": "과제 3" } }] } },
    { "object": "block", "type": "divider", "divider": {} },
    {
        "object": "block", "type": "callout",
        "callout": {
            "icon": { "type": "emoji", "emoji": "📌" },
            "color": "gray_background",
            "rich_text": [{ "type": "text", "text": { "content": "다음 주 핵심 마일스톤: {내용}" } }]
        }
    }
]
```

---

## 오류 처리

| 오류 유형 | 대응 |
|---------|-----|
| API 오류 (5xx) | 1회 재시도 후 실패 보고 |
| 토큰 만료 | `.mcp.json` NOTION_API_KEY 확인 요청 |
| 블록 한도 초과 (100개/호출) | 섹션 나눠 여러 번 `notion_append_block_children` |
| table 블록 미지원 시 | `code` 블록으로 ASCII 표 대체 |
| QuickChart URL 너무 긴 경우 | URL 단축 또는 `embed` 블록으로 대체 |
| Select 옵션 없음 | 새 옵션명으로 생성 (Notion 자동 추가) |

> 로컬 `reports/` 저장이 항상 우선이며, Notion 저장 실패가 전체 작업 실패를 의미하지 않는다.
