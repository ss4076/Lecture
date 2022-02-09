//
//  AppDelegate.m
//  PushTestIOS
//
//  Created by dong jun park on 2021/10/05.
//

#import "AppDelegate.h"


@import UserNotifications;

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate
NSString *const kGCMMessageIDKey = @"gcm.message_id";
//
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
    [FIRApp configure];
  
  
    [FIRMessaging messaging].delegate = self;
  
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
      // Register for remote notifications. This shows a permission dialog on first run, to
  // show the dialog at a more appropriate time move this registration accordingly.

    if ([UNUserNotificationCenter class] != nil) {
        // For iOS 10 display notification (sent via APNS)
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
        UNAuthorizationOptions authOptions = UNAuthorizationOptionAlert |
            UNAuthorizationOptionSound | UNAuthorizationOptionBadge;
        [[UNUserNotificationCenter currentNotificationCenter]
            requestAuthorizationWithOptions:authOptions
            completionHandler:^(BOOL granted, NSError * _Nullable error) {
              // ...
            NSLog(@"granted: %i",granted);
        }];
  }

  [application registerForRemoteNotifications];

  return YES;
}


// [START receive_message]
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
    fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // If you are receiving a notification message while your app is in the background,
    // this callback will not be fired till the user taps on the notification launching the application.
    // TODO: Handle data of notification

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // [[FIRMessaging messaging] appDidReceiveMessage:userInfo];


    // Print message ID.
    if (userInfo[kGCMMessageIDKey]) {
        NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
    }
  

    // Print full message.
    NSLog(@"%@", userInfo);

    completionHandler(UIBackgroundFetchResultNewData);
}



// Receive displayed notifications for iOS 10 devices.
// Handle incoming notification messages while app is in the foreground.
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {

    NSDictionary *userInfo = notification.request.content.userInfo;

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // [[FIRMessaging messaging] appDidReceiveMessage:userInfo];

    // [START_EXCLUDE]
    // Print message ID.
    if (userInfo[kGCMMessageIDKey]) {
    NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
    }
    // [END_EXCLUDE]

    // Print full message.
    NSLog(@"userInfo1: %@", userInfo);
    
    // Change this to your preferred presentation option
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionAlert);
}

// Handle notification messages after display notification is tapped by the user.
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler {

    NSDictionary *userInfo = response.notification.request.content.userInfo;
    if (userInfo[kGCMMessageIDKey]) {
    NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
    }

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // [[FIRMessaging messaging] appDidReceiveMessage:userInfo];

    // Print full message.
    NSLog(@"userInfo2: %@", userInfo);
    
    completionHandler();
    
    NSDictionary *aps = userInfo[@"aps"];
    NSLog(@"dic: %@", aps);
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:[[aps objectForKey:@"alert"] objectForKey:@"title"] message:[[aps objectForKey:@"alert"] objectForKey:@"body"] preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIWindow* topWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    topWindow.rootViewController = [UIViewController new];
    topWindow.windowLevel = UIWindowLevelAlert + 1;

    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"OK",@"confirm") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        // continue your work
        [alert dismissViewControllerAnimated:YES completion:nil];;
    }]];

    UIViewController *activeController = (UIViewController*)[[UIApplication sharedApplication].windows.lastObject rootViewController];
    
    
    while (activeController.presentedViewController) {
        activeController = activeController.presentedViewController;
    }
    
    if ([activeController isKindOfClass:[UINavigationController class]])
            activeController = [(UINavigationController*) activeController visibleViewController];
    else if (activeController.presentedViewController)
        activeController = activeController.presentedViewController;
    
    [activeController presentViewController:alert animated:YES completion:^{}];
}

// [END ios_10_message_handling]

// [START refresh_token]
- (void)messaging:(FIRMessaging *)messaging didReceiveRegistrationToken:(NSString *)fcmToken {

    NSLog(@"FCM registration token: %@", fcmToken);
    // Notify about received token.
    NSDictionary *dataDict = [NSDictionary dictionaryWithObject:fcmToken forKey:@"token"];
    [[NSNotificationCenter defaultCenter] postNotificationName:
     @"FCMToken" object:nil userInfo:dataDict];
    // TODO: If necessary send token to application server.
    // Note: This callback is fired at each app startup and whenever a new token is generated.
}
// [END refresh_token]


- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {

    NSLog(@"Unable to register for remote notifications: %@", error);
}

// This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
// If swizzling is disabled then this function must be implemented so that the APNs device token can be paired to
// the FCM registration token.
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {

    NSLog(@"APNs device token retrieved: %@", deviceToken);

    NSMutableString*     stringBuffer = [NSMutableString stringWithCapacity:([deviceToken length] * 2)];
    const unsigned char* dataBuffer   = [deviceToken bytes];

    for (int i = 0; i < [deviceToken length]; ++i) {
        [stringBuffer appendFormat:@"%02x", (unsigned int)dataBuffer[i]];
    }


    NSLog(@"token: %@", [NSString stringWithString:stringBuffer]);
    
    // With swizzling disabled you must set the APNs device token here.
//   [FIRMessaging messaging].APNSToken = deviceToken;
}

#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
