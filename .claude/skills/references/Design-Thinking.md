# Design Thinking 방법론

## 개요
IDEO와 Stanford d.school이 발전시킨 인간 중심 혁신 방법론.
사용자의 문제를 깊이 이해하고, 다양한 아이디어를 빠르게 프로토타입-테스트하는 반복적 접근.

## 5단계 프로세스

```
Empathize → Define → Ideate → Prototype → Test
  공감하기    정의하기   아이디어   프로토타입   테스트
              ↑______________________|
                    반복 (Iteration)
```

### 1. Empathize (공감)
목적: 사용자를 깊이 이해하기
방법: 관찰, 인터뷰, 직접 경험해보기
산출물: 공감 지도([Empathy-Map.md](Empathy-Map.md)), 인터뷰 인사이트

### 2. Define (문제 정의)
목적: 핵심 문제를 명확하게 정의
방법: HMW(How Might We) 질문법, POV 문장
산출물: Problem Statement
```
[페르소나]는 [문제 상황]이지만 [인사이트]이기 때문에 [필요한 것]이 필요하다.
```

### 3. Ideate (아이디어 발산)
목적: 최대한 많은 해결책 아이디어 생성
방법: 브레인스토밍, SCAMPER, Worst Possible Idea(역발상)
규칙: 판단 금지, 양 우선, 이상한 아이디어 환영

### 4. Prototype (프로토타입)
목적: 아이디어를 빠르게 가시화
방법: 페이퍼 프로토타입, 와이어프레임, MVP
원칙: 저비용·고속 → 학습을 위한 실패

### 5. Test (테스트)
목적: 실제 사용자에게 검증
방법: 사용자 테스트, A/B 테스트, 피드백 수집
출력: 새로운 인사이트 → Empathize 또는 Define으로 되돌아가기

## Twelve Senses 적용

### 현재 단계별 적용
| 단계 | Twelve Senses 적용 방법 |
|------|----------------------|
| Empathize | 잠재 고객 인터뷰, 경쟁사 리뷰 분석, 향기 커뮤니티 관찰 |
| Define | "향기 취향을 아는 MZ는 집에서 원하는 향을 실현할 방법이 없다" |
| Ideate | 조향 UI 방식, 레시피 공유 기능, AI 추천 UX |
| Prototype | Figma 와이어프레임, ESP32 기능 목업 |
| Test | 알파 테스터 10명 세션 |

## Lean UX 연계
Design Thinking + Agile의 결합:
- 짧은 스프린트 내에서 반복
- 문서보다 프로토타입
- 가정 기반 설계 → 검증으로 전환

## User Story Mapping 연계 → [User-Story-Mapping.md](User-Story-Mapping.md) 참조

## 출력 형식
```
### Design Thinking 현황
**현재 단계**: [Empathize/Define/Ideate/Prototype/Test]
**핵심 인사이트**: [사용자 관찰에서 발견된 것]
**Problem Statement (HMW)**: "어떻게 하면 [목표 사용자]가 [목표]할 수 있을까?"
**이번 주 가장 빠른 프로토타입**: [무엇을 만들어 검증할 것인가]
```
