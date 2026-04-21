# Notion 저장 규칙

모든 분석 보고서는 로컬(`reports/`) 저장과 동시에 Notion에도 저장한다.

---

## ⚠️ 스킬 파일 강제 로드 (가장 먼저 실행)

Notion 저장 단계에 진입하면 **Step 1~3을 실행하기 전에** 반드시 아래 두 파일을 Read 도구로 읽어야 한다:

```
Read(".claude/skills/Notion저장.md")
Read(".claude/skills/references/Notion-블록레퍼런스.md")
```

- `Notion저장.md`: 저장 플로우 + **보고서 유형별 리치 포맷 템플릿**
- `Notion-블록레퍼런스.md`: 블록 타입 JSON 예시 + QuickChart 차트 URL 패턴

**금지**: 이 두 파일을 읽지 않고 heading/paragraph/bulleted_list만으로 저장하는 것은 규칙 위반이다.
**필수**: callout, table, column_list, image(차트), toggle 등 보고서 유형에 맞는 리치 블록을 사용한다.

---

## 대상

| 항목 | 값 |
|------|-----|
| 페이지명 | [개인] TwelveSense |
| 페이지 ID | `3299f52b-c636-801c-bc4f-d656074382d4` |
| 데이터베이스명 | 📊 주간 분석 보고서 |
| **데이터베이스 ID** | **`33f9f52b-c636-8183-8a2a-f8bf9146b778`** |

## 저장 트리거

다음 커맨드 실행 완료 시 자동 Notion 저장:
- `/주간분석` (각 서브 분석 완료 시 각각 저장)
- `/시장조사`, `/PEST분석`, `/고객경쟁사분석`
- `/SWOT분석`, `/전략기획`, `/제품기획`
- `/UI기획`, `/디자인`, `/브랜딩전략`, `/마케팅전략`

---

## 보고서 유형 → 속성 매핑

| 보고서 유형 | 분석 단계 | 보고서명 형식 |
|------------|---------|-------------|
| _리서치 | STEP 0 | `_리서치 — 2026-W{주차}` |
| 시장조사 | STEP 1 | `시장조사 — 2026-W{주차}` |
| PEST분석 | STEP 1 | `PEST분석 — 2026-W{주차}` |
| 고객경쟁사분석 | STEP 1 | `고객경쟁사분석 — 2026-W{주차}` |
| SWOT분석 | STEP 2 | `SWOT분석 — 2026-W{주차}` |
| 전략기획 | STEP 3 | `전략기획 — 2026-W{주차}` |
| 제품기획 | STEP 3 | `제품기획 — 2026-W{주차}` |
| UI기획 | STEP 4 | `UI기획 — 2026-W{주차}` |
| 디자인 | STEP 4 | `디자인 — 2026-W{주차}` |
| 브랜딩전략 | STEP 4 | `브랜딩전략 — 2026-W{주차}` |
| 마케팅전략 | STEP 5 | `마케팅전략 — 2026-W{주차}` |

---

## 저장 절차 (3단계 하네스)

### Step 1 — 중복 확인
```
mcp__notion__notion_query_database(
  database_id: "33f9f52b-c636-8183-8a2a-f8bf9146b778",
  filter: {
    property: "보고서명",
    title: { equals: "{보고서명}" }
  }
)
→ results가 비어 있으면 Step 2로
→ results에 항목이 있으면 해당 page_id 사용 후 Step 3으로 (속성 업데이트)
```

### Step 2 — 데이터베이스 항목 생성
```
mcp__notion__notion_create_database_item(
  database_id: "33f9f52b-c636-8183-8a2a-f8bf9146b778",
  properties: {
    "보고서명":      { title:     [{ text: { content: "{보고서유형} — {주차}" } }] },
    "주차":          { select:    { name: "2026-W{NN}" } },
    "보고서 유형":   { select:    { name: "{보고서유형}" } },
    "분석 단계":     { select:    { name: "STEP {N}" } },
    "상태":          { status:    { name: "완료" } },
    "작성일":        { date:      { start: "YYYY-MM-DD" } },
    "Executive Summary": { rich_text: [{ text: { content: "3줄 요약" } }] },
    "핵심 인사이트": { rich_text: [{ text: { content: "• 인사이트1\n• 인사이트2\n..." } }] },
    "실행 과제 Top 3": { rich_text: [{ text: { content: "1. 과제1\n2. 과제2\n3. 과제3" } }] }
  }
)
→ 응답에서 page_id 추출
```

### Step 3 — 리치 포맷 블록 추가 (스킬 파일 필수 사용)

> ⚠️ **MANDATORY**: Step 3 실행 전 반드시 `.claude/skills/Notion저장.md`를 Read 도구로 읽어라.
> 해당 파일에 보고서 유형별 리치 포맷 템플릿이 정의되어 있다. 그 템플릿을 그대로 적용해야 한다.
>
> **금지 사항**: heading/paragraph/bulleted_list만 사용하는 plain text 저장은 규칙 위반이다.
> callout, table, column_list, image(차트), toggle 등 보고서 유형에 맞는 블록을 반드시 사용한다.

**적용 절차**:
1. `Read(".claude/skills/Notion저장.md")` 실행
2. "보고서별 리치 포맷 템플릿" 섹션에서 현재 보고서 유형에 해당하는 템플릿 확인
3. 해당 템플릿 구조를 그대로 `notion_append_block_children` children 배열로 변환해 호출
4. 차트가 필요한 경우 QuickChart.io URL을 `image` 블록으로 삽입 (템플릿에 예시 URL 포함)

---

## 새 주차 처리

데이터베이스의 `주차` 속성은 Select 타입이며 W14~W24가 사전 정의되어 있다.
W24를 초과한 주차(예: W25 이후)를 저장할 때는 `notion_update_database`로 새 옵션을 추가하거나,
그냥 `notion_create_database_item`에서 새 이름을 사용하면 Notion이 자동으로 옵션을 추가한다.

---

## 기존 항목 업데이트 (재작성 시)

Step 1에서 이미 존재하는 항목을 찾은 경우:
```
mcp__notion__notion_update_page_properties(
  page_id: "{기존 page_id}",
  properties: { ... }   ← 변경된 속성만 포함
)
```
이후 Step 3에서 `notion_append_block_children`으로 내용 덧붙임.
(기존 블록 교체가 필요하면 `notion_delete_block` 후 재추가)

---

## 저장 실패 시 처리

1. 로컬 저장은 완료 처리 (로컬이 항상 우선)
2. 오류 메시지를 사용자에게 인라인으로 보고
3. 재시도 1회 (동일 도구 재호출)
4. 재시도도 실패 시: "Notion 저장 실패 — {오류}" 메시지로 마무리

---

## 스킬 파일 강제 로드 규칙

Notion 저장 단계에 진입하면 아래 두 파일을 **반드시 Read 도구로 읽어야 한다**:

1. `.claude/skills/Notion저장.md` — 저장 플로우 + 보고서별 리치 포맷 템플릿
2. `.claude/skills/references/Notion-블록레퍼런스.md` — 모든 블록 타입 JSON 예시 + QuickChart 차트 URL 예시

이 두 파일을 읽지 않고 Notion에 plain text를 저장하는 것은 **규칙 위반**이다.
