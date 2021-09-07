//
//  ViewController.m
//  lecture01
//
//  Created by raonsecure on 2021/09/07.
//

#import "ViewController.h"

static const NSInteger MAX_LEN = 5;

void UncaughtExceptionsHandler(NSException *exception) {
    
    NSLog(@"***************** CRASH LOG START *****************");
    NSLog(@"<logReport> ------> reason: %@", [exception reason]);
    NSLog(@"<logReport> ------> name: %@", [exception name]);
    NSLog(@"<logReport> ------> callStackReturnAddresses: %@", [exception callStackReturnAddresses]);
    NSLog(@"<logReport> ------> callStackSymbols: %@", [exception callStackSymbols]);
    NSLog(@"<logReport> ------> userInfo: %@", [exception userInfo]);
    NSLog(@"***************** CRASH LOG END ******************");
}

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *idTxtFld;
@property (weak, nonatomic) IBOutlet UITextField *pwTxtFld;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSSetUncaughtExceptionHandler(&UncaughtExceptionsHandler);
}

- (IBAction)loginAction:(id)sender {
    
    if (![self validateInput]) {
        self.idTxtFld.text = @"";
        self.pwTxtFld.text = @"";
        return;
    }
    
//    @try {
//        [self validateInput2];
//    } @catch (NSException *e) {
//        NSLog(@"%@", e.reason);
//    } @finally {
//        self.idTxtFld.text = @"";
//        self.pwTxtFld.text = @"";
//    }
}

// https://lldb.llvm.org/use/map.html
- (BOOL)validateInput {
    
//    [self performSelector:@selector(die_die)];
    
    NSString *inputId = [self.idTxtFld text];
    NSString *inputPw = [self.pwTxtFld text];
    
    if (MAX_LEN > [inputId length]) {
        NSLog(@"inputId len: %d", (int)[inputId length]);
        return NO;
    }
    
    if (MAX_LEN > [inputPw length]) {
        NSLog(@"inputPw len: %d", (int)[inputPw length]);
        return NO;
    }
    return YES;
}


- (void)validateInput2 {
    
//    [self performSelector:@selector(die_die)];
    
    NSString *inputId = [self.idTxtFld text];
    NSString *inputPw = [self.pwTxtFld text];
    
    if (MAX_LEN > [inputId length]) {
        @throw [NSException exceptionWithName:@"invalid param" reason:[NSString stringWithFormat:@"inputId len: %d", (int)[inputId length]] userInfo:nil];
    }
    
    if (MAX_LEN > [inputPw length]) {
        @throw [NSException exceptionWithName:@"invalid param" reason:[NSString stringWithFormat:@"inputPw len: %d", (int)[inputPw length]] userInfo:nil];
    }
}


@end
