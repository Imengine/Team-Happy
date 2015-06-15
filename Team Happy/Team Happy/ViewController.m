//
//  ViewController.m
//  Team Happy
//
//  Created by Shao-Chi Yu on 15/06/15.
//  Copyright (c) 2015 Imengine. All rights reserved.
//

#import "ViewController.h"
#import "EndscreenViewController.h"
@interface ViewController ()

@property (nonatomic, strong) UIImageView *startBtn;

@end

@implementation ViewController

- (instancetype)init{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor grayColor];
    UITapGestureRecognizer *tapStartBtn = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected)];
    tapStartBtn.numberOfTapsRequired = 1;
    [self.startBtn setUserInteractionEnabled:YES];
    [self.startBtn addGestureRecognizer:tapStartBtn];
    self.startBtn.frame = CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height/2, 185, 50);
    [self.view addSubview:self.startBtn];
    //self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);

    
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

-(void)tapDetected{
    EndscreenViewController *vc = [[EndscreenViewController alloc] initWithText:@"test"];
    [self.navigationController pushViewController:vc animated:YES];
    NSLog(@"Endscreenviewcontroller pushed");

}


@end
