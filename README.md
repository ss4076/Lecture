# Lecture1
- 자사 iOS 수행 프로젝트
    - mTranskey (sdk)
    - Oneguard (엔터프라이즈), Oneguard serverless (sdk)
    - 해외향 Onepass (sdk) 
    - OneAccessEx (앱스토어)
    - Wallet Authenticator (sdk)

# 목차

강좌 1강

- 오리엔테이션 (강좌 방향 및 상황 체크)
- 디버깅 방법론

강좌 2강

- apple developer site (Enterprise, appstore, adhoc, test flight 등)

강좌 3~ 4강

- 인증서 및 프로비저닝 프로파일 개념
- Push apns, fcm
- 코드서명

강좌 5강 

- mdm 동작방식 및 원리

강좌 5 ~6강 

- 솔루션 별 sample 연동 및 프로젝트 설정 (MTK, FIDO, 원가드)
  - RSLicense 발급 및 적용
  - Framework import 설정
  - ios bitcode, c library 사용시 bitcode 옵션

강좌 7강 ~ 8강

- Swift 프로젝트에서 Object-c library 만들어 사용
- Objective-c 프로젝트에서 Swift library 만들어 사용

강좌 9강 ~ 10강

- Resource image(assets), String (다국어 처리)
- 의존성 툴(Cocoapod, 카르타고) 소개
- TestCase, TDD



## 1강


- developer roadmap 소개

![ios_developer_roadmap](./assets/ios_developer_roadmap.png)



- 디버깅 방법론 (Live 코딩)
  - break points / LLDB - https://lldb.llvm.org/use/map.html
  - crash report
  - try / catch
