# 본인 소개
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

---

- 애플 개발자 계정
  - https://developer.apple.com/kr/

- Apple Event
- WWDC21 요약
  - 매년 소프트웨어 개발자들을 위한 기술발표. 한국 시간 새벽 2시
  - iOS15 (iPhone), iPad, watch 등 생략
    - 페이스타임 링크를 통한 회의 참여(Grid view)
    - 쉐어플레이 - 음악을 같이 들으면 페이스타임
    - 쉐어스크린 - iOS 끼리 화면 공유 
    - 알림 기능 날짜, 상황, 사용패턴에 맞춰 자동 요약
    - 방해금지 모드 ,일모드, 개인, 수면 모드등 각각 개별 설정 가능(기존에는 방해금지만)
    - 라이브 텍스트 기능 (사진에서 텍스트를 인식)
    - 사진 추억 기능 업그레이드
- 디자인
  - ios 플렛폼별 사용자 및 개발 가이드
- 개발
  - Xcode(sdk), swift, iOS beta 관련(최신 xcode, ios profile)
- 배포
  - 아래 상세 설명

---

- 개발자 계정 도움말

  - https://help.apple.com/developer-account/#/

- 계정 종류

  - 개인 - App Store

    - apple store connect

      - 개발자가 빌드한 바이너리가 apple store connect로 제출을 위한 바이너리 자동 업로드
      - 제출/ 심사/ 앱스토어 게시

    - test flight

      - ad-hoc 배포 처럼 테스트 기기 소유자로부터 UUID를 받지 않아도 됨
      - 배포 후 앱 테스트 관련 통계 제공

      - 테스트 기기 소유자만큼의 애플 계정 생성 (번거로움)

      - 순서
        - 앱 Archive
          - distribute app 
          - iOS App Store
          - upload to App Store Connect

        - 업로드한 바이너리가 성공적으로 등록이 되면 애플에서 메일 수신

        - App Store Connect 페이지 -> TestFlight 이동
          - 새그룹 추가
          - 빌드 탭 선택 후 upload한 바이너리 선택
          - 로그인정보 입력
          - 애플 심사

        - 애플이 제공하는 두가지 방식의 테스트 
          - 자신이 알고있는 테스터를 추가하는 방법
            - 테스트 할 email 정보 입력 (테스트 앱스토어 사용자 계정)
            - 계정으로 메일발송되어 다운로드 가능
          - 공개 URL을 생성하여 이 링크를 배포하는 방법
            - 공개링크 선택하여 링크를 실행하면 모두가 다운로드 가능

  - 기업 - Apple Business Manager(Enterprise)

  - 교육, 기관 - Apple School Manager (DEP) - 취급 안함

- 계정 권한  (계정 종류 별)

  - https://developer.apple.com/kr/support/roles/#adep
