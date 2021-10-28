# 4강 푸시 노티피케이션 (Push Notification)

#### 개요

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

<img src="/Users/dongjunpark/gitlab/github/Lecture/assets/스크린샷 2021-10-21 오전 10.27.25.png" alt="스크린샷 2021-10-21 오전 7.39.20" style="zoom:80%;" />
