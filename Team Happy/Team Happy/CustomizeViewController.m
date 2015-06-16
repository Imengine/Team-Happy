//
//  CustomizeViewController.m
//  Team Happy
//
//  Created by Shao-Chi Yu on 16/06/15.
//  Copyright (c) 2015 Imengine. All rights reserved.
//

#import "CustomizeViewController.h"
#import "EndscreenViewController.h"

@interface CustomizeViewController ()
@property (nonatomic, strong) UIImageView *arrow_right;
@property (nonatomic, strong) UIImageView *arrow_left;


@end

@implementation CustomizeViewController
- (instancetype)initWithImage:(UIImageView *)pinImage{
    self = [super init];
    if (self) {
        self.pinImage = pinImage;
    }
    return self;
}
- (void) viewDidLoad {
    self.view.backgroundColor = [UIColor cyanColor];
    UITapGestureRecognizer *tapRightBtn = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetectedRight)];
    tapRightBtn.numberOfTapsRequired = 1;
    [self.arrow_right setUserInteractionEnabled:YES];
    [self.arrow_right addGestureRecognizer:tapRightBtn];
    self.arrow_right.frame = CGRectMake(self.view.frame.size.width-55, self.view.frame.size.height-55, 48, 48);
    [self.view addSubview:self.arrow_right];
    
    UITapGestureRecognizer *tapLeftBtn = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetectedLeft)];
    tapLeftBtn.numberOfTapsRequired = 1;
    [self.arrow_left setUserInteractionEnabled:YES];
    [self.arrow_left addGestureRecognizer:tapLeftBtn];
    self.arrow_left.frame = CGRectMake(7, self.view.frame.size.height-55, 48, 48);
    [self.view addSubview:self.arrow_left];
    self.pinImage.frame = CGRectMake(self.view.frame.size.width/2 - 200, self.view.frame.size.height/2 - 200, 400, 400);
    [self.view addSubview:self.pinImage];

}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}
- (UIImageView *)pinImage {
    if (_pinImage) {
        return _pinImage;
    }
    _pinImage = UIImageView.new;
    _pinImage.image = [UIImage imageNamed:@"arrow_right"];
    return _pinImage;
}
- (UIImageView *)arrow_right {
    if (_arrow_right) {
        return _arrow_right;
    }
    _arrow_right = UIImageView.new;
    _arrow_right.image = [UIImage imageNamed:@"arrow_right"];
    return _arrow_right;
}
- (UIImageView *)arrow_left {
    if (_arrow_left) {
        return _arrow_left;
    }
    _arrow_left = UIImageView.new;
    _arrow_left.image = [UIImage imageNamed:@"arrow_left"];
    return _arrow_left;
}
-(void)tapDetectedRight{
    EndscreenViewController *vc = [[EndscreenViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    NSLog(@"EndscreenViewcontroller pushed");
}
-(void)tapDetectedLeft{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
