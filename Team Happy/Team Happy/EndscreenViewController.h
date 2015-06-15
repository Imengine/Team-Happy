//
//  EndscreenViewController.h
//  Team Happy
//
//  Created by Shao-Chi Yu on 15/06/15.
//  Copyright (c) 2015 Imengine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EndscreenViewController : UIViewController <UIPrintInteractionControllerDelegate>
@property (nonatomic, strong) UIButton * printBtn;
- (instancetype)initWithText:(NSString *)text;

@end
