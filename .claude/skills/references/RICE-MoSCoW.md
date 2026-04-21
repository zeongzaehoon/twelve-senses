# RICE Scoring + MoSCoW 우선순위화 방법론

## RICE Scoring

### 개요
Intercom이 개발한 제품 피처 우선순위화 프레임워크.
4가지 요소를 수식으로 계산해 객관적 우선순위 결정.

### RICE 공식
```
RICE Score = (Reach × Impact × Confidence) / Effort
```

| 변수 | 정의 | 측정 단위 |
|------|------|---------|
| **Reach** | 얼마나 많은 사용자에게 영향? | 3개월 내 영향받는 사용자 수 |
| **Impact** | 목표에 얼마나 기여? | 0.25(최소) / 0.5 / 1 / 2 / 3(최대) |
| **Confidence** | 추정치 신뢰도? | 100%(확실) / 80%(높음) / 50%(중간) |
| **Effort** | 구현에 필요한 인력·시간? | 월(person-month) 단위 |

### Twelve Senses RICE 예시

| 피처 | Reach | Impact | Confidence | Effort | RICE |
|------|-------|--------|------------|--------|------|
| AI 레시피 추천 | 500 | 3 | 80% | 2 | 600 |
| RFID 자동 인식 | 500 | 2 | 90% | 1.5 | 600 |
| 레시피 SNS 공유 | 500 | 1 | 70% | 0.5 | 700 |
| 날씨 연동 | 300 | 2 | 60% | 1 | 360 |
| B2B 원격 관리 | 50 | 3 | 50% | 3 | 25 |

---

## MoSCoW 방법론

### 개요
Dai Clegg(Oracle)가 개발. 요구사항을 4가지 우선순위로 분류해 스코프 관리.

### 4가지 분류

| 카테고리 | 정의 | Twelve Senses 적용 |
|---------|------|------------------|
| **Must Have** | 없으면 제품이 실패 | PWM 4채널 제어, BLE 연결, 기본 앱 |
| **Should Have** | 중요하지만 론칭은 가능 | AI 레시피, RFID 인식, 날씨 연동 |
| **Could Have** | 있으면 좋지만 나중에 | 레시피 공유, 감정 기반 추천, B2B 대시보드 |
| **Won't Have (이번엔)** | 이번 릴리즈에서 제외 | 음성 제어, 타 스마트홈 연동, 해외 버전 |

### 사용 시기
- 스프린트 계획 시 Must vs Should 구분
- 크라우드 펀딩 MVP 정의 시 Must Have만 포함
- 로드맵 수립 시 전체 피처 분류

## 두 방법론 조합
1. **RICE**로 전체 피처 점수화
2. **MoSCoW**로 Must/Should/Could/Won't 분류
3. 높은 RICE 점수 피처 중 Must/Should를 이번 스프린트에 배치

## 출력 형식
```
### 피처 우선순위 (YYYY-WXX)

**RICE Scoring 상위 5개**:
| 피처 | RICE | 근거 |
|------|------|------|

**MoSCoW 분류**:
- Must: [리스트]
- Should: [리스트]
- Could: [리스트]
- Won't: [리스트]

**이번 스프린트 배치**: [Must + 높은 RICE Should]
```
