# Notion 블록 레퍼런스

`notion_append_block_children` MCP 도구로 생성 가능한 모든 블록 타입과 JSON 형식.

---

## 지원 블록 전체 목록

| 블록 타입 | 설명 | API 생성 가능 |
|----------|------|:-----------:|
| `paragraph` | 기본 텍스트 | ✅ |
| `heading_1/2/3` | 제목 (접기 가능) | ✅ |
| `bulleted_list_item` | 불릿 리스트 | ✅ |
| `numbered_list_item` | 번호 리스트 | ✅ |
| `to_do` | 체크박스 | ✅ |
| `toggle` | 접기/펼치기 | ✅ |
| `callout` | 콜아웃 (강조 박스) | ✅ |
| `quote` | 인용구 | ✅ |
| `code` | 코드 블록 | ✅ |
| `divider` | 구분선 | ✅ |
| `table` | 표 | ✅ |
| `table_row` | 표 행 (table 내부) | ✅ |
| `column_list` | 다단 레이아웃 컨테이너 | ✅ |
| `column` | 단 (column_list 내부) | ✅ |
| `image` | 이미지 (외부 URL) | ✅ |
| `bookmark` | 북마크 (URL 프리뷰) | ✅ |
| `equation` | 수식 (LaTeX) | ✅ |
| `table_of_contents` | 목차 자동 생성 | ✅ |
| `embed` | 외부 콘텐츠 임베드 | ✅ |
| `video` | 동영상 (YouTube 등) | ✅ |
| `link_preview` | 링크 프리뷰 | ✅ |
| Native charts/graphs | 원형·막대 차트 | ❌ → QuickChart.io 이미지로 대체 |

---

## 1. 텍스트 서식 (rich_text annotations)

모든 텍스트 블록에서 사용 가능한 `annotations` 옵션:

```json
{
  "type": "text",
  "text": { "content": "텍스트 내용" },
  "annotations": {
    "bold": true,
    "italic": true,
    "code": true,
    "underline": true,
    "strikethrough": true,
    "color": "red"
  }
}
```

### 사용 가능한 color 값
```
default | blue | brown | gray | green | orange | pink | purple | red | yellow
(배경색) blue_background | brown_background | gray_background | green_background
         orange_background | pink_background | purple_background | red_background | yellow_background
```

---

## 2. 기본 블록

### Paragraph
```json
{
  "object": "block",
  "type": "paragraph",
  "paragraph": {
    "rich_text": [{ "type": "text", "text": { "content": "내용" } }],
    "color": "default"
  }
}
```

### Heading (h2 예시, is_toggleable 가능)
```json
{
  "object": "block",
  "type": "heading_2",
  "heading_2": {
    "rich_text": [{ "type": "text", "text": { "content": "섹션 제목" } }],
    "color": "blue_background",
    "is_toggleable": true
  }
}
```

### Divider
```json
{ "object": "block", "type": "divider", "divider": {} }
```

### Callout (강조 박스) ← 핵심 인사이트에 적극 활용
```json
{
  "object": "block",
  "type": "callout",
  "callout": {
    "icon": { "type": "emoji", "emoji": "💡" },
    "color": "yellow_background",
    "rich_text": [{ "type": "text", "text": { "content": "핵심 메시지" } }]
  }
}
```

| 용도 | emoji | color |
|-----|-------|-------|
| 핵심 인사이트 | 💡 | yellow_background |
| 경고·위협 | ⚠️ | red_background |
| 기회 | 🚀 | green_background |
| 정보 | ℹ️ | blue_background |
| 강점 | ✅ | green_background |
| 약점 | ❌ | red_background |
| 액션 아이템 | 🎯 | orange_background |
| 포지셔닝 | 👑 | purple_background |

### Quote (포지셔닝 스테이트먼트 등)
```json
{
  "object": "block",
  "type": "quote",
  "quote": {
    "color": "purple_background",
    "rich_text": [{
      "type": "text",
      "text": { "content": "포지셔닝 스테이트먼트 전문" },
      "annotations": { "italic": true }
    }]
  }
}
```

### Toggle (접기/펼치기) ← OKR·상세 분석에 활용
```json
{
  "object": "block",
  "type": "toggle",
  "toggle": {
    "rich_text": [{
      "type": "text",
      "text": { "content": "▶ Objective 1: 크라우드펀딩 성공" },
      "annotations": { "bold": true }
    }],
    "color": "blue_background",
    "children": [
      {
        "object": "block",
        "type": "to_do",
        "to_do": {
          "rich_text": [{ "type": "text", "text": { "content": "KR1: 펀딩 목표액 1,000만 원 달성" } }],
          "checked": false
        }
      }
    ]
  }
}
```

### To-do (체크박스)
```json
{
  "object": "block",
  "type": "to_do",
  "to_do": {
    "rich_text": [{ "type": "text", "text": { "content": "실행 과제" } }],
    "checked": false,
    "color": "default"
  }
}
```

---

## 3. 표 (Table)

```json
{
  "object": "block",
  "type": "table",
  "table": {
    "table_width": 4,
    "has_column_header": true,
    "has_row_header": false,
    "children": [
      {
        "object": "block",
        "type": "table_row",
        "table_row": {
          "cells": [
            [{ "type": "text", "text": { "content": "헤더1" }, "annotations": { "bold": true } }],
            [{ "type": "text", "text": { "content": "헤더2" }, "annotations": { "bold": true } }],
            [{ "type": "text", "text": { "content": "헤더3" }, "annotations": { "bold": true } }],
            [{ "type": "text", "text": { "content": "헤더4" }, "annotations": { "bold": true } }]
          ]
        }
      },
      {
        "object": "block",
        "type": "table_row",
        "table_row": {
          "cells": [
            [{ "type": "text", "text": { "content": "값1" } }],
            [{ "type": "text", "text": { "content": "값2" } }],
            [{ "type": "text", "text": { "content": "값3" } }],
            [{ "type": "text", "text": { "content": "값4" } }]
          ]
        }
      }
    ]
  }
}
```

> **주의**: `table` 블록은 반드시 `children`에 `table_row` 블록을 포함해서 한 번에 생성해야 한다. 나중에 행 추가는 별도 `notion_append_block_children`으로 가능.

---

## 4. 다단 레이아웃 (Column List)

```json
{
  "object": "block",
  "type": "column_list",
  "column_list": {
    "children": [
      {
        "object": "block",
        "type": "column",
        "column": {
          "children": [
            {
              "object": "block",
              "type": "callout",
              "callout": {
                "icon": { "type": "emoji", "emoji": "✅" },
                "color": "green_background",
                "rich_text": [{ "type": "text", "text": { "content": "Strength" }, "annotations": { "bold": true } }]
              }
            }
          ]
        }
      },
      {
        "object": "block",
        "type": "column",
        "column": {
          "children": [
            {
              "object": "block",
              "type": "callout",
              "callout": {
                "icon": { "type": "emoji", "emoji": "❌" },
                "color": "red_background",
                "rich_text": [{ "type": "text", "text": { "content": "Weakness" }, "annotations": { "bold": true } }]
              }
            }
          ]
        }
      }
    ]
  }
}
```

---

## 5. 이미지 & 차트

### 외부 이미지
```json
{
  "object": "block",
  "type": "image",
  "image": {
    "type": "external",
    "external": { "url": "https://example.com/image.png" }
  }
}
```

### QuickChart.io로 차트 생성 (image 블록 활용) ← 그래프 대체
Notion API는 네이티브 차트를 지원하지 않는다. 대신 QuickChart.io URL로 차트 이미지를 생성해서 `image` 블록으로 삽입.

```
BASE URL: https://quickchart.io/chart?w=600&h=300&c=
```

**막대 차트 예시 (TAM/SAM/SOM)**:
```
https://quickchart.io/chart?w=600&h=300&c={"type":"bar","data":{"labels":["TAM (글로벌)","SAM (한국)","SOM (목표)"],"datasets":[{"label":"시장 규모 (억 달러)","data":[76,3.4,0.05],"backgroundColor":["rgba(99,102,241,0.8)","rgba(99,102,241,0.5)","rgba(99,102,241,0.3)"]}]},"options":{"plugins":{"title":{"display":true,"text":"TAM/SAM/SOM 2024"}}}}
```

**퍼널 차트 예시 (AARRR)**:
```
https://quickchart.io/chart?w=600&h=300&c={"type":"bar","data":{"labels":["Acquisition","Activation","Retention","Referral","Revenue"],"datasets":[{"data":[1000,400,200,50,30],"backgroundColor":["#6366f1","#8b5cf6","#a78bfa","#c4b5fd","#ddd6fe"]}]},"options":{"indexAxis":"y"}}
```

**레이더 차트 (경쟁사 비교)**:
```
https://quickchart.io/chart?w=500&h=400&c={"type":"radar","data":{"labels":["AI 개인화","디자인","가격","B2B","생태계"],"datasets":[{"label":"Twelve Senses","data":[9,8,5,7,6]},{"label":"경쟁사A","data":[4,6,7,5,8]}]}}
```

> URL에 JSON이 들어가므로 공백·특수문자는 `encodeURIComponent`로 처리하거나 최소화해서 삽입.

---

## 6. 북마크 & 임베드

### 북마크 (출처 URL)
```json
{
  "object": "block",
  "type": "bookmark",
  "bookmark": {
    "url": "https://example.com/source",
    "caption": [{ "type": "text", "text": { "content": "출처 설명" } }]
  }
}
```

### 목차 자동 생성
```json
{
  "object": "block",
  "type": "table_of_contents",
  "table_of_contents": { "color": "default" }
}
```

---

## 7. 보고서별 포맷 레시피

### SWOT분석 → 2×2 Color Grid

```
[column_list]
  ├── [column] callout(green) "✅ Strengths" + bulleted_list_items
  └── [column] callout(red)   "❌ Weaknesses" + bulleted_list_items
[column_list]
  ├── [column] callout(blue)   "🚀 Opportunities" + bulleted_list_items
  └── [column] callout(orange) "⚠️ Threats" + bulleted_list_items
```

### 시장조사 → TAM/SAM/SOM 시각화

```
callout(blue) "📊 시장 규모 요약"
image → QuickChart 막대 차트 URL
table → TAM/SAM/SOM × Top-Down/Bottom-Up 교차표
```

### PEST분석 → 색상 구분 표

```
heading_2 "PESTLE 6요소 분석"
table(7열) → 요소 | 내용 | 영향 | 시급도 | 대응 방향
callout(yellow) "💡 Top 3 시사점"
```

### 전략기획 (OKR) → Toggle 계층

```
heading_2 "OKR 현황"
toggle(blue) "🎯 O1: 크라우드펀딩 성공"
  └── to_do "KR1: ..."  [달성률 표시]
  └── to_do "KR2: ..."
toggle(purple) "🎯 O2: 기술 검증 완료"
  └── to_do "KR1: ..."
```

### 브랜딩전략 (Brand Pyramid) → Toggle 5단계

```
toggle(purple) "👑 Brand Essence — 감각의 자유"
  └── paragraph(상세 설명)
toggle(blue)   "🔭 Brand Vision — ..."
toggle(green)  "💎 Brand Values — ..."
toggle(orange) "🤝 Brand Promise — ..."
toggle(gray)   "⚙️ Features & Benefits — ..."
```

### 마케팅전략 (STP) → Quote + Table

```
quote(purple) "포지셔닝 스테이트먼트 전문"
heading_3 "세그먼트별 분석"
table → 세그먼트 × 인구통계 × 심리통계 × 행동특성 × 시장규모
```

### 고객경쟁사분석 → 경쟁사 레이더 차트

```
heading_2 "경쟁사 포지셔닝 맵"
image → QuickChart 레이더 차트 URL
table → 경쟁사 × 평가 기준 비교표
```

---

## 8. 전체 페이지 레이아웃 템플릿

보고서 페이지의 권장 구조:

```
table_of_contents          ← 목차 자동 생성
divider
callout(yellow, 💡)        ← Executive Summary
divider
heading_1 "1. [섹션명]"
  heading_2 + 내용 블록들
divider
heading_1 "2. [섹션명]"
  ...
divider
callout(orange, 🎯)        ← 이번 주 실행 과제 Top 3
  numbered_list_item × 3
callout(gray, 📌)          ← 다음 주 마일스톤
```
