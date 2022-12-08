//
//  ViewController.m
//  PushTestIOS
//
//  Created by dong jun park on 2021/10/05.
//

#import "ViewController.h"
@import UserNotifications;

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)localNotiAction:(id)sender {
    
    NSLog(@"local Notification action");

    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    [content setTitle:@"Lecture04"];
    [content setSubtitle:@"local notification"];
    [content setBody:@"local notification message"];
    [content setSound:[UNNotificationSound defaultSound]];
    [content setBadge:@1];
    NSDictionary *alert = @{@"body":@"{\"title\":\"lecture03\",\"body\":\"fcmPush\"}", @"title":@"local notification test"};
    NSDictionary *aps = @{@"alert":alert};
    NSDictionary *userInfo = @{@"aps":aps};
    [content setUserInfo:userInfo];
    
    // 달력으로 알림 가능함 (sec)
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
    
//    NSDateComponents* date = [[NSDateComponents alloc] init];
//    date.hour = 11;  // AM
//    date.minute = 12;
//    date.second = 30;
//    UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:date repeats:NO];
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"alarmTest" content:content trigger:trigger];
    
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            NSLog(@"completed handler : %@", [error description]);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)test1 {
    // 1
    // 2
    // 3
}
- (void)test2 {
    // 1
    // 2
}
-(void)fun3 {
    // hana issue success
}
-(void)mms {
    // 1
}

@end
