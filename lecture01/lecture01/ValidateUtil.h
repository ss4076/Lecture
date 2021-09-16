//
//  ValidateUtil.h
//  lecture01
//
//  Created by raonsecure on 2021/09/07.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ValidateUtil : NSObject
+ (BOOL)validateInput:(NSString *)idText withPwText:(NSString *)pwText;
+ (void)validateInput2:(NSString *)idText withPwText:(NSString *)pwText;
@end

NS_ASSUME_NONNULL_END
