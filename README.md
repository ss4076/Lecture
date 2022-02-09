# 본인 소개
- 자사 iOS 수행 프로젝트
    - mTranskey (sdk)
    - Oneguard (엔터프라이즈), Oneguard serverless (sdk)
    - 해외향 Onepass (sdk) 
    - OneAccessEx (앱스토어)
    - Wallet Authenticator (sdk)
    - ZkpCore (sdk)

# 목차

강좌 1강

- 오리엔테이션 (강좌 방향 및 상황 체크)
- 디버깅 방법론

강좌 2강

- apple developer site (Enterprise, appstore, adhoc, test flight 등)

강좌 3~ 4강

- 인증서 및 프로비저닝 프로파일 개념
- 코드서명
- Push -apns, fcm (live coding), local push
  - server - client

강좌 5강 

- mdm 동작방식 및 원리

강좌 6강 

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

---

## 1강


- developer roadmap 소개

![ios_developer_roadmap](./assets/ios_developer_roadmap.png)



- 디버깅 방법론 (Live 코딩)
  - break points / LLDB - https://lldb.llvm.org/use/map.html
  - crash report
  - try / catch

---

## 2강

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
    - 엔터프라이즈, 앱스토어계정을 운영하며 개발 팀내 담당자들이 권한을 부여받고 업무진행

  

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

----

## 3강 인증서, 프로비저닝, 코드서명

- 개요

  실제로 우리는 다양한 계약, 사안에 대한 서명을 합니다. 우리는 왜 계약에 서명합니까? 서명은 우리에게 무엇을 의미하며 왜 중요할까요? 계약서에 서명하면 합법적으로 우리를 보호할 수 있기 때문입니다. 

  계약 조항 및 조건을 변경할 수 없고, 신뢰할 수 있는 기관에서 증빙하는 계약이 체결되는 동안 서명은 보안을 보장합니다. (보안, 안전, 신뢰가 제공)

  

  마찬가지로 iOS 코드 서명은 모든 형태의 코드, 리소스, 설정파일 등에 디지털 서명을 하는 과정입니다. 누가 코드를 작성했는지 확인하고 코드가 변경되지 않았음을 보장하기 위함입니다.

  코드 서명은 암호화 해시를 사용하여 진위를 확인하며 소프트웨어 코드의 무결성 및 신원을 보장합니다.

  

  예시로 대학 또는 전문과정을 마치면 인증서를 받습니다. 인증서는 그 과정을 마쳤고 지식이 있다는 것을 신뢰하는 자료입니다. 인증서는 신뢰받는 기관이 증명하면 더 강력해집니다. 사람들이 해당 인증서를 더 신뢰하기 떄문입니다.

  

  기본적으로 iOS와 Apple의 세계에서도 동일한 개념을 가지고 있습니다. 애플 개발자 멤버쉽에 비용을 지불하고 가입한 합법적인 앱 개발자에게 애플이 증빙하는 인증서를 발급합니다.

  

  인증서는 iOS 코드서명에 대한 핵심 내용입니다.

- ##### 인증서 발급 

  공개키 인프라 시스템에서 csr은 기본적으로 인증서를 신청하기 위해 사용자가 인증서 기관에게 보내는 메시지이며 애플은 인증서를 발행 하기 위해서 csr 형태의 메시지를 받아서 세부정보를 확인 후 애플의 서명이 포함된 인증서를 발급합니다. (아래에 단계적으로 설명)

  

  ![스크린샷 2021-10-21 오전 7.36.20](file:///Users/dongjunpark/gitlab/github/Lecture/assets/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202021-10-21%20%EC%98%A4%EC%A0%84%2010.21.36.png?lastModify=1634810555)

  

- 키체인 접근 (키 관리 클라이언트)
- 신청자는 인증기관에 인증서 요청 (certificate signing request) 
  - 키쌍 생성 후 세부정보 입력(이름, 이메일, 국가)과 서명과 함께 공개키 제출
    - 개인키를 바탕으로 CertificateSigningRequest.certSigningRequest (세부정보, 공개키 포함) 생성
    - 키체인에 개인키는 저장됨
- 해당 인증서 요청전문(csr)은 애플 개발자 맴버쉽 프로그램에서 인증서 생성시 사용됨
- 인증서 발급시 발급 기관(애플)은 누가 요청하는지에 대한 세부 정보를 확인하여 인증서를 발급
- 발급 받은 ios_development.cer/ ios_distribution.cer 더블 클릭 시 Apple Worldwite Developer Relations Certification Authority가 서명한 인증서인지 체크하고 키체인에 있는 내 개인키와 인증서가 결합이 되어 xcode에서 사용 가능한 형태가 됨

- ##### 프로비저닝 프로파일 생성

  Apple의 인증서가 아닌 Apple이 발급한 개발자 인증서로 코드 서명한 앱을 기기에 설치할 때는 프로비저닝 프로파일이 반드시 필요합니다. 프로비저닝 프로파일에 명시된 기기에 프로비저닝 프로파일을 설치해야 Apple의 인증서로 코드 서명된 앱이 아니더라도 기기에서 실행할 수 있기 때문입니다.

  

  - 프로비저닝 프로파일 또한 개발용/배포용이 있으며 각 인증서와 결함되어 사용됨 
  - 생성과정은 아래와 같이 여러 요소와 연관되어 있음
    - Team ID
    - Bundle ID(App ID)
    - Device ID
    - Entitlements

  ![스크린샷 2021-10-21 오전 7.36.33](file:///Users/dongjunpark/gitlab/github/Lecture/assets/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA%202021-10-21%20%E1%84%8B%E1%85%A9%E1%84%8C%E1%85%A5%E1%86%AB%207.36.33.png?lastModify=1634810555)

- ##### 코드 서명

  - xCode IDE에 내 개인키로 코드 서명 후 바이너리 파일(IPA) 생성
    - iOS 보안 구조 코드 서명
    - 파일의 무결성 검증, 서명자 확인하는 기능
    - Mach-O 형식의 ios 바이너리 파일의 무결성을 검증하고 서명자를 확인 시 code signature 구조체를 이용한다.
  - 앱스토어에서 설치된 앱은 apple에서 발급한 인증서로 코드서명 되어 있다.
  - 개발자가 테스트하거나 배포하는 앱은 apple이 발급한 개발/ 배포 인증서로 코드서명 한다.

![스크린샷 2021-10-21 오전 7.36.41](file:///Users/dongjunpark/gitlab/github/Lecture/assets/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA%202021-10-21%20%E1%84%8B%E1%85%A9%E1%84%8C%E1%85%A5%E1%86%AB%207.36.41.png?lastModify=1634810555)

- 참조
  - https://engineering.linecorp.com/ko/blog/ios-code-signing/

---

## 4강 Push Notification

- 개요

  이번 강의에서 전달드리는 내용은 푸시의 필요성과 사용법입니다.

  iOS 어플리케이션의 백그라운드에서 앱을 깨우거나 메시지를 전달하기 위한 Local Notification, Remote Notification 두가지 방식이 있습니다.

  Local Notification은 사용자가 특정 시간에 알람을 설정하거나 특정 위치에 도착했을때 앱내에서 사용자에게 알림을 주는 방식입니다. 이러한 기능은 서버가 필요 없는 기능으로 앱내에서 간단하게 알림기능을 구현할 수 있습니다.

  Remote Notification은 개발용, 배포용 인증서에 따른 device 토큰을 사용해서 서버(SP)가 해당 단말로 알림 메시지를 보내는 기능입니다. 메시지로 전달가능한 길이가 짧기 때문에 앱에서 알림 수신 후 서버(SP)로 접속하여 요청에 대한 질의를 하는 경우가 많습니다. 

  추가로 최근에 추가된 Silent Push 기능은 사용자에게 알리지 않고 백그라운드에서 간단한 테스크를 처리할 수 있는 기능으로 본 강의에서는 다루지 않습니다. (https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/pushing_background_updates_to_your_app)

  

  #### 1. Local notification

  - 앱내 타이머를 설정하고 알람을 주는 방식
  - 앱내 알림 (live coding)

  #### 2. Remote notification

  - 원격 서버(SP)에서 메시지를 보내서 어플리케이션에게 전달되는 방식
  - 구성요소 (앱, APNs 서버, APNs Provider)
    - 레거시 방식 APNs, FCM 방식 예제 (live coding)

  ![스크린샷 2021-10-21 오전 7.39.20](file:///Users/dongjunpark/gitlab/github/Lecture/assets/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202021-10-21%20%EC%98%A4%EC%A0%84%2010.27.25.png?lastModify=1634810638)




## 5강 iOS MDM 동작 방식

### 개요 및 목표

이번 강의에서는 MDM(Mobile Device Management) 동작방식을 이해하는것을 목표로 합니다. 

MDM서버(SP)로부터 iOS 디바이스가 어떠한 원리로 관리를 받는지 알아보겠습니다.

이 기능의 핵심 또한 인증서와 프로파일 입니다. 

MDM 푸시 인증서 및 MDM profile 생성과정을 살펴보고 원가드 제품을 MDM protocol 을 참고하여 설명드리겠습니다.

### MDM 서비스 구성

![스크린샷 2021-10-31 오후 12.47.18](file:///Users/dongjunpark/gitlab/github/Lecture/assets/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA%202021-10-31%20%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE%2012.47.18.png?lastModify=1636364046)

### MDM Push 인증서 생성 (이론 상 고객사와 벤더 양쪽에서 인증서 생성에 관여 함)

다른 문서로 단계 별로 설명

- Customer(고객사)

  1. 고객사의 개인정보로 csr 생성 (키쌍 생성) 

  2. customer.csr -> customer.der로 변경 (mdm push plist 생성의 재료)

  3. vender(라온)로 der 전달 (고객사의 개인정보 및 서명 +공개키)

     -- vender 절차

  4. 고객사는 MDM Push 인증서를 생성하기 위해 apple enterprise 계정에 가입해야 한다.

  5. 고객사의 Enterprise계정 apple.com/iphone/business/integration/mdm/ 접속

  6. 최종적으로 받은 라온의 plist 파일을 업로드 하여 푸시 인증서를 다운로드 받고 키체인을 이용해 패스워드와 함께 sp 서버로 .p12파일을 전달한다.

  7. sp 서버에서는 .p12 와 패스워드로 MDM push를 보낸다. 누구에게??

     - Mdm 푸시 인증서에는 고객사의 id(apsp)가 있다. 
     - 해당 id를 기준으로 고객사별 MDM profile을 생성하고 기기에 설치 한다.

  

- Vender(라온)

  1. 라온의 개인정보로 csr 생성 (키쌍 생성)
  2. 라온 엔터프라이즈 계정에서 csr 첨부하여 MDM.cer 파일 생성 및 다운로드 (키체인 저장)
  3. 키체인에서 내보내기 하여 .p12로 패스워드 설정
  4. apple ROOT_CA 인증서, apple 중간자 CA인증서를 다운로드
  5. 고객사에서 받은 customer.der와, 라온에서 생성한 mdm.p12를 이용하여 push 인증서를 생성하기 위한 encoded_plist를 생성한다.
     - 아래 참조 문서
     - 고객사의 der을 라온의 mdm 인증서 개인키로 서명문을 만든다
     - encoded_plist = sign(라온 개인키, customer원본) + customer원본 + ca 정보

### MDM Profile 생성

다른 문서로 단계 별로 설명

- 고객사 마다 다른 MDM 푸시 인증서를 사용하고 있음
- MDM 푸시 인증서 및 apple ca 인증서를 재료로 MDM Profile을 생성한다.
- MDM 푸시인증서의 개인키로 MDM Profile을 서명 후 설치

### MDM Protocol

원가드 제품을 예시로 단계 별로 설명

- check-in (프로파일 최초 설치시 프로토콜)

  - Authenticate message

    | MsgType      | Topic                 | UDID               |
    | ------------ | --------------------- | ------------------ |
    | Authenticate | MDM 고객사 구분값 (A) | 디바이스 구분값(B) |

    | OS   | BuildVer | ProdctNm | SerialNum | Imei | Meid |
    | ---- | -------- | -------- | --------- | ---- | ---- |
    | 13.0 | 4.0.0.1  | MDM      | xxxx      | xxx  | Xxx  |

  - Token update message

    | MsgType      | Topic | UDID | Token | PushMagic | UnlockToken |
    | ------------ | ----- | ---- | ----- | --------- | ----------- |
    | Authenticate | A     | B    | C     | D         | E           |

  - 배포된 앱 시작시 서버에서 설정한 고유값을 이용해서 앱 로그인 시 위 정보와 매핑한다. (https://developer.apple.com/library/archive/samplecode/sc2279/Introduction/Intro.html)

    | SerialNumber | UserId | UserPW |
    | ------------ | ------ | ------ |
    | Xxxxx        | djpark | 1234   |

- check-out (프로파일 삭제 시 프로토콜)

  | MsgType | Topic | UDID |
  | ------- | ----- | ---- |
  |         | A     | B    |

  - 프로파일 삭제 시 배포한 앱 모두 삭제 옵션

- command (모바일 디비이스 관리 프로토콜) / request type별

  아래 명령을 수행시 아래 table과 같이 명령에 대한 이력을 관리 해야 함 (idle/ ack/ error/ notnow 상태 존재)

  | commandUUID         | command | status | result | date       |
  | ------------------- | ------- | ------ | ------ | ---------- |
  | Xxxx-xxxx-xxxx-xxxx | Apps    | 1      | 1      | 20211031.. |

  - DeviceInfomation (디바이스 정보조회)

  - InstalledApplicationList (설치된 앱 리스트 조회) - 원가드 -> 업무앱 관리

  - InstallApplication (앱 설치) 원가드, 업무앱 

  - RemoveApplication (앱 삭제)

  - InstallProfile (제한정책) 카메라 화면 캡쳐, .....

  - RemoveProfile (정책해제)

  - DeviceLock (화면잠금)

  - EraseDevice (공장초기화)

  - ClearPasscode (사용자 패스코드 초기화)

    ![스크린샷 2021-11-04 오전 10.55.18](file:///Users/dongjunpark/Library/Application%20Support/typora-user-images/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA%202021-11-04%20%E1%84%8B%E1%85%A9%E1%84%8C%E1%85%A5%E1%86%AB%2010.55.18.png?lastModify=1636364046)

### 참조

- 애플 기기 MDM 개요 
  - https://support.apple.com/ko-kr/guide/mdm/mdmbf9e668/web
- MDM Server java 기반
  - https://github.com/zuoyy/IOS-MDM-Server/tree/master/src/com/zuoyy
- encoded_plist 생성 java 기반
  - https://developer.apple.com/documentation/devicemanagement/implementing_device_management/setting_up_push_notifications_for_your_mdm_customers
- encoded_plist 생성 python 기반
  - https://github.com/grinich/mdmvendorsign/blob/f3565f5191e2a2d3a19b41589986bb5fba9fb555/mdm_vendor_sign.py
- apple mdm protocol 문서
  - https://developer.apple.com/business/documentation/MDM-Protocol-Reference.pdf
- apple mdm configuration profile 문서(제한정책 payload 포함)
  - https://developer.apple.com/business/documentation/Configuration-Profile-Reference.pdf



