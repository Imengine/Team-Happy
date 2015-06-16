//
//  ViewController.m
//  Team Happy
//
//  Created by Shao-Chi Yu on 15/06/15.
//  Copyright (c) 2015 Imengine. All rights reserved.
//

#import "MainViewController.h"
#import "EndscreenViewController.h"
#import "BackgroundViewController.h"

@interface MainViewController ()

@property (nonatomic, strong) UIImageView *startBtn;
@property (nonatomic, strong) UIImageView *tempBtn;


@end

@implementation MainViewController

- (instancetype)init{
    self = [super init];
    if (self) {
    }
    return self;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    
    self.navigationController.navigationBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.view.backgroundColor = [UIColor grayColor];
    UITapGestureRecognizer *tapStartBtn = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected)];
    tapStartBtn.numberOfTapsRequired = 1;
    [self.startBtn setUserInteractionEnabled:YES];
    [self.startBtn addGestureRecognizer:tapStartBtn];
    self.startBtn.frame = CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height/2, 185, 50);
    [self.view addSubview:self.startBtn];
    
    //self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    UITapGestureRecognizer *tapTempBtn = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tmpTapDetected)];
    tapTempBtn.numberOfTapsRequired = 1;
    [self.tempBtn setUserInteractionEnabled:YES];
    [self.tempBtn addGestureRecognizer:tapTempBtn];
    self.tempBtn.frame = CGRectMake(self.view.frame.size.width/2-400, self.view.frame.size.height/2, 185, 50);
    [self.view addSubview:self.tempBtn];

    
    NSLog(@"Viewcontroller loaded");
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIImageView *)startBtn {
    if (_startBtn) {
        return _startBtn;
    }
    _startBtn = UIImageView.new;
    _startBtn.image = [UIImage imageNamed:@"startBtn"];
    return _startBtn;
}

- (UIImageView *)tempBtn {
    if (_tempBtn) {
        return _tempBtn;
    }
    _tempBtn = UIImageView.new;
    _tempBtn.image = [UIImage imageNamed:@"startBtn"];
    return _tempBtn;
}

-(void)tapDetected{
    EndscreenViewController *vc = [[EndscreenViewController alloc] initWithText:@"test"];
    [self.navigationController pushViewController:vc animated:YES];
    NSLog(@"Endscreenviewcontroller pushed");

}
-(void)tmpTapDetected{
    BackgroundViewController *vc = [[BackgroundViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    NSLog(@"BackgroundViewController pushed");
    
}


@end
