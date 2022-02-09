//
//  ViewController.m
//  lecture01
//
//  Created by raonsecure on 2021/09/07.
//

#import "ViewController.h"
#import "ValidateUtil.h"


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
    
    if (![ValidateUtil validateInput:self.idTxtFld.text withPwText:self.pwTxtFld.text]) {
        self.idTxtFld.text = @"";
        self.pwTxtFld.text = @"";
        return;
    }
//    @try {
//        [ValidateUtil validateInput2:self.idTxtFld.text withPwText:self.pwTxtFld.text];
//    } @catch (NSException *e) {
//        NSLog(@"%@", e.reason);
//    } @finally {
//        self.idTxtFld.text = @"";
//        self.pwTxtFld.text = @"";
//    }
}
-(void) test1 {
    NSLog(@"test");
}


-(void) test2 {
    NSLog(@"test2");
    dsdfa
}
@end
