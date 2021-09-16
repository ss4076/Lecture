//
//  ValidateUtil.m
//  lecture01
//
//  Created by raonsecure on 2021/09/07.
//

#import "ValidateUtil.h"

static const NSInteger MAX_LEN = 5;

@implementation ValidateUtil

    // https://lldb.llvm.org/use/map.html
+ (BOOL)validateInput:(NSString *)idText withPwText:(NSString *)pwText {
    
    //    @try {
    //        [self performSelector:@selector(die_die)];
    //    } @catch (NSException *e) {
    //        NSLog(@"%@", e.reason);
    //    }
    
    
    if (MAX_LEN > [idText length]) {
        NSLog(@"inputId len: %d", (int)[idText length]);
        return NO;
    }
    
    if (MAX_LEN > [pwText length]) {
        NSLog(@"inputPw len: %d", (int)[pwText length]);
        return NO;
    }
    
    return YES;
}

+ (void)validateInput2:(NSString *)idText withPwText:(NSString *)pwText {
    
        //    [self performSelector:@selector(die_die)];
    
    
    if (MAX_LEN > [idText length]) {
        @throw [NSException exceptionWithName:@"invalid param" reason:[NSString stringWithFormat:@"inputId len: %d", (int)[idText length]] userInfo:nil];
    }
    
    if (MAX_LEN > [pwText length]) {
        @throw [NSException exceptionWithName:@"invalid param" reason:[NSString stringWithFormat:@"inputPw len: %d", (int)[pwText length]] userInfo:nil];
    }
}

@end
