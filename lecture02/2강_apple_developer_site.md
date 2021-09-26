# 2강 Apple Developer Program 

- https://developer.apple.com/kr/
  - Apple Event
  - WWDC21 요약
    - 매년 소프트웨어 개발자들을 위한 기술발표. 한국 시간 새벽 2시
    - iOS15 (iPhone), iPad, watch 등 생략 (언택트 시대 적응 해법)
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

  - 기업 - Apple Business Manager 

  - 교육, 기관 - Apple School Manager (DEP) - 취급 안함

- 계정 권한  (계정 종류 별)

  - https://developer.apple.com/kr/support/roles/#adep







# 3강 인증서/ 프로비저닝, Push, 코드서명 

- 인증서 생성
  - 키체인 (키관리 클라이언트) -> 인증기관에 인증서 요청
  - 개인 정보 입력 (이메일, 이름)
  - CertificateSigningRequest.certSigningRequest(공개키 포함)
    - 키체인에 개인키 저장됨
  - 인증서 생성 및 다운로드 및 선택
    - ios_development.cer/ ios_distribution_cer
  - 키체인에 있는 내 개인키와 인증서가 결합
    - Apple Worldwite Developer Relations Certification Authority가 서명한 인증서
    - 인증서 내 공개키 획득
    - xCode IDE에 내 개인키로 앱 서명 후 앱 빌드
      - iOS 보안 구조 코드 서명
      - 파일의 무결성 검증, 서명자 확인하는 기능
      - Mach-O 형식의 ios 바이너리 파일의 무결성을 검증하고 서명자를 확인하는 작업뒤에 code signature 구조체를 이용한다.
    - 앱스토어에서 설치된 앱은 apple에서 발급한 인증서로 코드서명 되어 있다.
    - 개발자가 테스트하거나 배포하는 앱은 apple이 발급한 개발자 또는 배포 인증서로 코드서명 한다.
      - 기기에 설치된 프로비저닝 프로파일이 반드시 필요
        - 프로비저닝 프로파일에 명시된 프로비저닝 프로파일을 설치해야 apple의 인증서로 코드 서명된 앱이 아니더라도 기기에서 실행할 수 있음