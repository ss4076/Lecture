# 2강 Apple Developer Site

- 개요 

  애플 개발자 싸이트에 애플의 이벤트, 개발, 배포, 도구, 계정, 문서 등이 존재합니다.

  애플의 트렌트를 지속적으로 관찰하는 방법중 하나로 개발자 싸이트를 살펴보는 방법이며, 담당자는 가능한 빠르게 캐치하여 라온제품에 반영하거나 대응해야합니다.

  ##### 금일 전달할 내용을 요약하면 애플 개발자 싸이트를 파악하고 개발자 계정을 등록하고 운영하는 방법론입니다.

  - 애플의 신제품 릴리즈 패턴
    - 매년 6월 즈음, WWDC 스티븐잡스, 팀쿡 CEO의 키노트 발표 (PPT) 
      - 소프트웨어 개발자들을 위한 기술발표. 한국 시간 새벽 2시
    - 사전에 개발자 초대(유료) -> 코로나 이후 온라인(무료)
      - Q&A 및 이벤트 등
    - 이후 매년 9월 새로운 iOS 출시전 Beta 릴리즈
      - 개발자는 WWDC에서 발표했던 내용들을 beta에서 확인, 디버그 리포팅
    - 매년 10월 안정화 된 새로운 iOS 정식 출시와 더불어 새로운 기기 출시
  - 애플 개발자 계정
    - 개인, 중소기업, 기관에서 용도에 맞는 프로그램 선택 (appstore, enterprise, dep 등)
    - 프로그램내 개개인의 계정 권한 부여 
      - 앱 개발부터 출시까지 분리되진 권한, 허가 존재
      - 라온에서는 김성도프로가 모든 계정의 소유자권한(superAdmin)
        - 엔터프라이즈, 앱스토어계정을 운영하며 개발 팀내 담당자들이 권한을 부여받고 업무진행

----

- https://developer.apple.com/kr/
  - Apple Event
  - WWDC21 요약
    - iOS15 (iPhone), iPad, watch 등 생략 (언택트 시대 적응 해법)
      - 페이스타임 링크를 통한 회의 참여(Grid view)
      - 쉐어플레이 - 음악을 같이 들으면서 페이스타임
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
  - 중소기업 - App Store Small Business
    - https://developer.apple.com/kr/app-store/small-business-program/
  - 개인 - App Store (₩129000)
    - https://developer.apple.com/kr/programs/enroll/
    - test flight
  
      - ad-hoc 배포 방식처리 테스트 기기 소유자로부터 UUID를 받지 않아도 됨
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
  - 기업 - 엔터프라이즈 계정 (₩ 355000)
    - https://developer.apple.com/kr/programs/enterprise/
  - 기관, 교육 - Apple Business Manager / Apple School Manager (DEP)
    - https://business.apple.com/#enrollment
    - https://support.apple.com/ko-kr/HT204142
- 계정 권한  (계정 종류 별)

  - https://developer.apple.com/kr/support/roles/#adep
