# Twelve Senses — AI 스마트 디퓨저 프로젝트

## 프로젝트 개요

**Twelve Senses**는 사용자 데이터를 학습하고 초개인화된 향기 경험을 제공하는 AI 스마트 디퓨저 스타트업.
대표: 함가영 (CEO/PO) | 이메일: udallijam@naver.com | 서울시 중구 을지로 264 12층

### 핵심 가치 제안
- 4종 에센셜 오일 카트리지 + PWM 마이크로 드롭 조향 → 수천 가지 조합 레시피 실현
- RFID 태그 기반 오일 잔량 추적 → 구독형 Lock-in 생태계 구축
- 생성형 AI + 날씨 데이터 → 맞춤 향기 레시피 제안
- ESP32 SuperMini C3 기반 IoT 앱 연동

### 산출물
- 15×15×15cm 디퓨저 하드웨어 (ESP32 기반)
- RFID 태그 부착 에센셜 오일
- 연동 모바일 어플리케이션

---

## 로드맵

| 기간 | 목표 |
|------|------|
| 2026 Q2 | 조향·AI 기능 하드웨어 + 앱 제작, 기술 검증 완료 |
| 2026 Q3 | 크라우드 펀딩 (시제품 시장 반응 파악, 초기 팬층 확보) |
| 2026 Q4 | 온라인 버티컬 플랫폼 입점 (오늘의집, 29cm 등), 오프라인 박람회 참가 |
| 2027 상반기 | 초기 사용자 1만 명 확보, Big Data Hub 인프라 구축 |
| 2027 하반기 | B2B 판로 구축, 향기 인사이트 리포트 판매 |

---

## 비즈니스 모델

### B2C
- 하드웨어 + 앱 판매 (하이엔드 Tech Object 포지셔닝: 29cm, EQL, 이노메싸 입점)
- RFID 정품 에센셜 오일 Lock-in 생태계
- 다공성 세라믹 카트리지·폐기 카트리지 정기 구독

### B2B
- RFID 기반 무인 통합 관리 시스템 (SaaS형)
- 통합 유지 보수 솔루션 (구독형)
- 호텔·백화점·리조트 대상 공간별 조향 컨설팅

### 데이터
- 사용자 향기 데이터 → Big Data Hub 축적
- 날씨별 향기 트렌드 인사이트 리포트 → B2B 판매

---

## 작업 영역별 지침

### 코딩 작업
- **MCU**: ESP32 SuperMini C3 (WiFi/Bluetooth, PWM 조향 제어)
- **하드웨어 제어**: PWM 기반 BLDC 모터 펌프 4채널, 솔레노이드 배출 밸브, 역류 방지 밸브
- **통신**: RFID 리더 모듈 (오일병 정보 동기화), BLE/WiFi (앱 연동)
- **앱**: IoT 모바일 앱 (조향 레시피 UI, 오일 잔량 확인, 알림)
- **AI**: 생성형 AI (사용자 취향 학습 + 날씨 데이터 기반 레시피 제안)
- **클라우드**: 자사 서버에 향기 데이터 축적·분석 파이프라인

코드 작성 시 다음 우선순위 적용:
1. 하드웨어 제어 정확성 (오버슈팅 알고리즘, 드롭 단위 정밀 제어)
2. 오염 방지 로직 (흡입/폐기 경로 분리, 역류 방지)
3. RFID 기반 데이터 동기화 신뢰성

### 마케팅 작업
- **타겟**: MZ세대, 셀프 디깅·레이어링 취향, 스몰 럭셔리 소비자
- **포지셔닝**: 하이엔드 Tech Object (가심비 + 초개인화)
- **채널**: 온라인 버티컬 플랫폼 (오늘의집, 29cm, EQL, 이노메싸), 크라우드 펀딩, 오프라인 박람회
- **핵심 메시지**: "나만의 향을 만드는 세계 최초 AI 스마트 조향 플랫폼"
- **B2B 마케팅**: 호텔·백화점·리조트 대상 무인 관리 효율 + 조향 컨설팅 강조

시장 데이터:
- 글로벌 홈프래그런스 시장: 2023년 76억 달러 → 2032년 110억 달러+ (CAGR ~4.4~5.65%)
- 한국 시장: 2024년 3.4억 달러 → 2035년 4.5억 달러+

### 기획 작업
- **제품 기획**: ESP32 기반 하드웨어 스펙, 카트리지 시스템, 앱 UX 설계
- **비즈니스 기획**: B2C → B2B → 데이터 판매 3단계 수익 구조
- **파트너십**: 기술 검증 파트너, 버티컬 플랫폼 입점 협의, B2B 고객사 발굴
- 기획서·제안서 작성 시 위 비즈니스 모델과 로드맵 기준으로 작성

---

## AI 작업 시스템

### 규칙 파일 (`.claude/rules/`)
모든 분석 작업에 자동 적용되는 규칙:
- [공통규칙.md](.claude/rules/공통규칙.md) — 시작 전 확인사항, 데이터 수집·저장 규칙
- [Notion저장규칙.md](.claude/rules/Notion저장규칙.md) — Notion 자동 저장 (페이지 ID: `3299f52b-c636-801c-bc4f-d656074382d4`)
- [분석품질기준.md](.claude/rules/분석품질기준.md) — 보고서별 최소 품질 체크리스트

### 스킬 파일 (`.claude/skills/`)
분석 방법론 참조 라이브러리:
| 스킬 | 설명 | 참조 방법론 |
|------|------|-----------|
| [환경분석.md](.claude/skills/환경분석.md) | 거시환경 분석 | PESTLE, 시나리오 플래닝 |
| [시장분석.md](.claude/skills/시장분석.md) | 시장규모 산정 | TAM/SAM/SOM |
| [고객경쟁사분석.md](.claude/skills/고객경쟁사분석.md) | 고객·경쟁 분석 | JTBD, Empathy Map, Porter |
| [통합전략.md](.claude/skills/통합전략.md) | 전략 도출 | SWOT/TOWS, OKR, BSC, Blue Ocean |
| [마케팅전략.md](.claude/skills/마케팅전략.md) | 성장 전략 | STP, AARRR, Growth Loop |
| [브랜딩전략.md](.claude/skills/브랜딩전략.md) | 브랜드 정체성 | Golden Circle, Brand Pyramid, Archetypes |
| [Notion저장.md](.claude/skills/Notion저장.md) | Notion 저장 방법 | — |

방법론 레퍼런스: `.claude/skills/references/` (PESTLE, JTBD, SWOT-TOWS, TAM-SAM-SOM, OKR, BSC, Blue Ocean, STP, AARRR, Growth Loop, Golden Circle, Brand Pyramid, Brand Archetypes, Porter Five Forces, Empathy Map, Design Thinking, RICE-MoSCoW, Scenario Planning, **Notion-블록레퍼런스**)

### 에이전트 (`/.claude/agents/`)
복잡한 분석 위임 가능한 전문가 페르소나:
| 에이전트 | 전문 영역 |
|---------|---------|
| [마케팅분석가](.claude/agents/마케팅분석가.md) | STP, AARRR, Growth Loop, 콘텐츠 전략 |
| [브랜딩분석가](.claude/agents/브랜딩분석가.md) | Golden Circle, Brand Pyramid, Archetype |
| [경영전략분석가](.claude/agents/경영전략분석가.md) | OKR, BSC, Blue Ocean, SWOT/TOWS |
| [영업전략분석가](.claude/agents/영업전략분석가.md) | B2B 영업, 플랫폼 입점, 파트너십 |
| [시장조사분석가](.claude/agents/시장조사분석가.md) | TAM/SAM/SOM, 경쟁사 모니터링, 트렌드 |
| [제품기획자](.claude/agents/제품기획자.md) | RICE/MoSCoW, JTBD, 피처 우선순위 |

---

## 주요 용어 정리

| 용어 | 설명 |
|------|------|
| 조향 | 여러 향을 혼합하여 새로운 향을 만드는 행위 |
| 레이어링 | 여러 향을 겹쳐 쓰는 소비 패턴 |
| 셀프 디깅 | 자신의 취향을 직접 탐구하는 MZ세대 트렌드 |
| PWM 조향 | Pulse Width Modulation으로 오일 토출량을 드롭 단위로 정밀 제어 |
| Lock-in | RFID 정품 오일만 사용 가능하도록 하는 폐쇄형 생태계 |
| HaaS/SaaS | Hardware/Software as a Service — 구독형 비즈니스 모델 |
| 오버슈팅 알고리즘 | 즉시 발향 변화를 위한 펌프 제어 알고리즘 |
