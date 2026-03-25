# Twelve Senses — 주간 분석 리포트

AI 스마트 디퓨저 스타트업 **Twelve Senses**의 주간 분석 보고서 저장소.
매주 10개 분석 보고서가 `reports/YYYY-WNN/` 폴더에 생성됩니다.

---

## 리포트 뷰어 실행

### 시작

1. Finder에서 `view_reports.command` **더블클릭**
2. 터미널 창이 열리고 브라우저가 자동으로 열립니다

> 처음 실행 시 macOS 보안 경고가 뜨면:
> **시스템 설정 → 개인 정보 보호 및 보안 → "확인 없이 열기"** 클릭

### 종료

브라우저 탭을 닫거나 터미널 창을 닫으면 됩니다. 백그라운드 프로세스 없음.

### 동작 방식

```
더블클릭
  → reports/ 스캔
  → 모든 .md 파일을 base64로 읽어 HTML 안에 embed
  → 임시 viewer.html 생성 → 브라우저로 열기 (file://)
  → 스크립트 종료 (서버 없음, 포트 없음)
```

**설치 필요 없음** — bash + base64 는 macOS 기본 내장.

### 새 주차 리포트 추가 후

`view_reports.command`를 다시 더블클릭하면 새 리포트가 포함된 뷰어가 열립니다.

---

## 리포트 읽는 순서

주간 분석은 아래 순서로 읽어야 각 보고서의 맥락이 연결됩니다.
앞 단계의 결과가 뒷 단계의 인풋으로 사용됩니다.

```
_리서치 → 시장조사 ┐
         PEST분석   ├─→ SWOT분석 → 전략기획 ┐
         고객경쟁사분석 ┘               제품기획 ├─→ UI기획 ┐
                                                디자인   ├─→ 마케팅전략
                                                브랜딩전략 ┘
```

### 각 리포트 설명

| 순서 | 파일명 | 목적 | 핵심 방법론 |
|------|--------|------|------------|
| 0 | `_리서치.md` | 이번 주 전체 분석의 공용 데이터 소스. 나머지 9개 보고서가 이 파일을 참조 | WebSearch 6개 영역 집약 |
| 1 | `시장조사.md` | 시장 규모와 진입 타이밍 판단 | TAM/SAM/SOM Top-down × Bottom-up 교차검증 |
| 2 | `PEST분석.md` | 거시환경이 사업에 미치는 기회·위협 식별 | PESTLE 6요소 + Scenario Planning |
| 3 | `고객경쟁사분석.md` | 고객이 진짜 원하는 것과 경쟁 구도 파악 | JTBD + Empathy Map + Porter's Five Forces |
| 4 | `SWOT분석.md` | 위 3개를 통합해 전략 방향 도출 | Weighted SWOT + TOWS Matrix + 동적 SWOT |
| 5 | `전략기획.md` | 분기별 목표와 실행 계획 수립 | OKR + Balanced Scorecard + Blue Ocean |
| 6 | `제품기획.md` | 어떤 기능을 어떤 순서로 만들지 결정 | JTBD + RICE Scoring + MoSCoW |
| 7 | `UI기획.md` | 사용자 경험 설계와 화면 흐름 정의 | Design Thinking + User Story Mapping + Lean UX |
| 8 | `디자인.md` | 하드웨어·앱·브랜드 디자인 방향 정의 | Design Sprint + Atomic Design + Brand Identity |
| 9 | `브랜딩전략.md` | 브랜드 정체성과 커뮤니케이션 방향 | Golden Circle + Brand Pyramid + Archetypes |
| 10 | `마케팅전략.md` | 고객 획득·유지·성장 실행 전략 | STP + AARRR + Growth Loops |

---

## 폴더 구조

```
sense/
├── reports/
│   ├── index.html          ← 뷰어 UI
│   ├── marked.min.js       ← 마크다운 렌더러 (view_reports.command가 인라인으로 삽입)
│   └── 2026-W13/
│       ├── _리서치.md
│       ├── 시장조사.md
│       ├── PEST분석.md
│       ├── 고객경쟁사분석.md
│       ├── SWOT분석.md
│       ├── 전략기획.md
│       ├── 제품기획.md
│       ├── UI기획.md
│       ├── 디자인.md
│       ├── 브랜딩전략.md
│       └── 마케팅전략.md
├── .claude/
│   └── commands/           ← /주간분석 등 Claude Code 커맨드
├── view_reports.command     ← 더블클릭으로 뷰어 실행
└── README.md
```

---

## 분석 커맨드 목록

Claude Code에서 `/커맨드명` 으로 실행:

| 커맨드 | 설명 |
|--------|------|
| `/주간분석` | 전체 10개 분석을 순서대로 실행 (약 20분) |
| `/_리서치` | 공용 리서치만 단독 실행 |
| `/시장조사` | 시장 규모 분석만 단독 실행 |
| `/PEST분석` | 거시환경 분석만 단독 실행 |
| `/고객경쟁사분석` | 고객·경쟁사 분석만 단독 실행 |
| `/SWOT분석` | SWOT 통합 분석만 단독 실행 |
| `/전략기획` | 전략 기획만 단독 실행 |
| `/제품기획` | 제품 기획만 단독 실행 |
| `/UI기획` | UI 기획만 단독 실행 |
| `/디자인` | 디자인 방향만 단독 실행 |
| `/브랜딩전략` | 브랜딩 전략만 단독 실행 |
| `/마케팅전략` | 마케팅 전략만 단독 실행 |
