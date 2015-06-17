//
//  CustomizeViewController.m
//  Team Happy
//
//  Created by Shao-Chi Yu on 16/06/15.
//  Copyright (c) 2015 Imengine. All rights reserved.
//

#import "CustomizeViewController.h"
#import "EndscreenViewController.h"
#import "iCarousel.h"
@interface CustomizeViewController () <iCarouselDataSource, iCarouselDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) UIImageView *arrow_right;
@property (nonatomic, strong) UINavigationItem *navItem;

@property (nonatomic, strong) UIImageView *arrow_left;
@property (nonatomic, strong) iCarousel *topCarousel;
@property (nonatomic, strong) NSMutableArray *topImages;


@end

@implementation CustomizeViewController

@synthesize topCarousel = _topcarousel;
@synthesize topImages = _topimages;

- (instancetype)initWithImage:(UIImageView *)pinImage{
    self = [super init];
    if (self) {
        self.pinImage = pinImage;
        NSArray *imagePaths = [[NSBundle mainBundle] pathsForResourcesOfType:@"jpg" inDirectory:@"TopImages"];
        //preload images (although FXImageView can actually do this for us on the fly)
        _topimages = [[NSMutableArray alloc] init];
        for (NSString *path in imagePaths)
        {
            [_topimages addObject:[UIImage imageWithContentsOfFile:path]];
        }

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
    
    //create carousel
    _topcarousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/2)];
    _topcarousel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    _topcarousel.type = iCarouselTypeCoverFlow2;
    _topcarousel.type = iCarouselTypeLinear;

    _topcarousel.delegate = self;
    _topcarousel.dataSource = self;
    _topcarousel.vertical = NO;
    
    //add carousel to view
    [self.view addSubview:_topcarousel];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.topCarousel = nil;
    self.navItem = nil;
}
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [_topimages count];
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

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    //create new view if no view is available for recycling
    if (view == nil)
    {
        FXImageView *imageView = [[FXImageView alloc] initWithFrame:CGRectMake(0, 0, 400.0f, 400.0f)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.asynchronous = YES;
        //        imageView.reflectionScale = 0.5f;
        //        imageView.reflectionAlpha = 0.25f;
        //        imageView.reflectionGap = 10.0f;
        imageView.shadowOffset = CGSizeMake(0.0f, 2.0f);
        imageView.shadowBlur = 5.0f;
        imageView.cornerRadius = 10.0f;
        view = imageView;
    }
    
    //show placeholder
    ((FXImageView *)view).processedImage = [UIImage imageNamed:@"placeholder.png"];
    
    //set image
    ((FXImageView *)view).image = _topimages[index];
    
    return view;
}
- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    if (option == iCarouselOptionSpacing)
    {
        return value * 1.1;
    }
    return value;
}


@end
