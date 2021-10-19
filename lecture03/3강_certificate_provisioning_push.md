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

- 참조
  - https://engineering.linecorp.com/ko/blog/ios-code-signing/



- Push 
  - APNS
    - Apple push notification service
  - FCM
