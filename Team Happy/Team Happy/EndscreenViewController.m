//
//  EndscreenViewController.m
//  Team Happy
//
//  Created by Shao-Chi Yu on 15/06/15.
//  Copyright (c) 2015 Imengine. All rights reserved.
//

#import "EndscreenViewController.h"

@implementation EndscreenViewController

- (instancetype)initWithText:(NSString *)text{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    NSLog(@"Endscreenviewcontroller loaded");
    self.view.backgroundColor = [UIColor darkGrayColor];
    [self.printBtn addTarget:self action:@selector(printHappyButton:withEvent:) forControlEvents:UIControlEventTouchUpInside];
    self.printBtn.frame = CGRectMake(self.view.frame.size.width-200, self.view.frame.size.height-200, 185, 50);
    [self.view addSubview:self.printBtn];
}


- (UIButton *)printBtn {
    if (_printBtn) {
        return _printBtn;
    }
    
    _printBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_printBtn setTitle:@"Print" forState:UIControlStateNormal];
//    [_payBtn setTitle:@"Betaald" forState:UIControlStateNormal];
//    [_payBtn setBackgroundImage:[UIImage imageNamed:@"btnGreen"] forState:UIControlStateNormal];
//    [_payBtn setBackgroundImage:[UIImage imageNamed:@"btnGreenSelected"] forState:UIControlStateSelected];
//    [_payBtn setTitleColor:[UIColor colorWithRed:0.129 green:0.827 blue:0.482 alpha:1] forState:UIControlStateNormal];
//    [_payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    return _printBtn;
}

- (void)printHappyButton:(UIButton *)tapBtn withEvent:(UIEvent *)event {
    if ([UIPrintInteractionController isPrintingAvailable])
    {
        
        NSLog(@"Printer found");
        NSMutableString *printBody = [NSMutableString stringWithFormat:@"%@",@"Testprint"];
        //[printBody appendFormat:@"\n\n\n\nPrinted From *myapp*"];
        
        UIPrintInteractionController *pic = [UIPrintInteractionController sharedPrintController];
        pic.delegate = self;
        
        UIPrintInfo *printInfo = [UIPrintInfo printInfo];
        printInfo.outputType = UIPrintInfoOutputGeneral;
        printInfo.jobName = @"JobName";
        pic.printInfo = printInfo;
        
        UISimpleTextPrintFormatter *textFormatter = [[UISimpleTextPrintFormatter alloc] initWithText:printBody];
        textFormatter.startPage = 0;
        textFormatter.contentInsets = UIEdgeInsetsMake(72.0, 72.0, 72.0, 72.0); // 1 inch margins
        textFormatter.maximumContentWidth = 6 * 72.0;
        pic.printFormatter = textFormatter;
        pic.showsPageRange = YES;
        
        void (^completionHandler)(UIPrintInteractionController *, BOOL, NSError *) =
        ^(UIPrintInteractionController *printController, BOOL completed, NSError *error) {
            if (!completed && error) {
                NSLog(@"Printing could not complete because of error: %@", error);
            }
        };
        [pic presentFromRect:CGRectMake((self.view.frame.size.width/2)-200, 0, 400, 400) inView:self.view animated:YES completionHandler:completionHandler];
       // [pic presentAnimated:YES completionHandler:completionHandler];

    } else {
        NSLog(@"printer not available");
    }
}
@end
