//
//  BackgroundViewController.m
//  Team Happy
//
//  Created by Shao-Chi Yu on 16/06/15.
//  Copyright (c) 2015 Imengine. All rights reserved.
//

#import "BackgroundViewController.h"
#import "iCarousel.h"
#import "CustomizeViewController.h"
#import "MainViewController.h"
@interface BackgroundViewController () <iCarouselDataSource, iCarouselDelegate, UIActionSheetDelegate>
//@interface BackgroundViewController ()

@property (nonatomic, strong) iCarousel *carousel;
@property (nonatomic, strong) UINavigationItem *navItem;
@property (nonatomic, assign) BOOL wrap;
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, assign, getter = isVertical) BOOL vertical;
@property (nonatomic, strong) UIImageView *arrow_right;
@property (nonatomic, strong) UIImageView *arrow_left;

@end

@implementation BackgroundViewController

@synthesize carousel = _carousel;
@synthesize images = _images;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
    {
        NSArray *imagePaths = [[NSBundle mainBundle] pathsForResourcesOfType:@"jpg" inDirectory:@"Backgrounds"];
        //preload images (although FXImageView can actually do this for us on the fly)
        _images = [[NSMutableArray alloc] init];
        for (NSString *path in imagePaths)
        {
            [_images addObject:[UIImage imageWithContentsOfFile:path]];
        }
        //set up data
//        self.items = [NSMutableArray array];
//        for (int i = 0; i < 1000; i++)
//        {
//            [_items addObject:@(i)];
//        }
    }
    return self;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}
- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor orangeColor];
    _wrap = YES;
    
    //add background
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    backgroundView.image = [UIImage imageNamed:@"background.png"];
    [self.view addSubview:backgroundView];
    
    //create carousel
    _carousel = [[iCarousel alloc] initWithFrame:self.view.bounds];
    _carousel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _carousel.type = iCarouselTypeCoverFlow2;
    _carousel.delegate = self;
    _carousel.dataSource = self;
    _carousel.vertical = YES;
    //add carousel to view
    [self.view addSubview:_carousel];
    
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
    
    //add top bar
//    UINavigationBar *navbar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
//    navbar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    self.navItem = [[UINavigationItem alloc] initWithTitle:@"Coverflow2"];
//    _navItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Switch Type" style:UIBarButtonItemStyleBordered target:self action:@selector(switchCarouselType)];
//    _navItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Wrap: ON" style:UIBarButtonItemStyleBordered target:self action:@selector(toggleWrap)];
//    [navbar setItems:@[_navItem]];
//    [self.view addSubview:navbar];
    
    //add bottom bar
//    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 44, self.view.bounds.size.width, 44)];
//    toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
//    [toolbar setItems:@[[[UIBarButtonItem alloc] initWithTitle:@"Insert Item" style:UIBarButtonItemStyleBordered target:self action:@selector(insertItem)],
//                        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:NULL],
//                        [[UIBarButtonItem alloc] initWithTitle:@"Delete Item" style:UIBarButtonItemStyleBordered target:self action:@selector(removeItem)]]];
//    [self.view addSubview:toolbar];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    self.carousel = nil;
    self.navItem = nil;
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [_images count];
}

-(void)tapDetectedRight{
    UIImageView *pinImage = UIImageView.new;
    pinImage.image = self.images[self.carousel.currentItemIndex];
    CustomizeViewController *vc = [[CustomizeViewController alloc] initWithImage:pinImage];
    [self.navigationController pushViewController:vc animated:YES];
    NSLog(@"CustomizeViewController pushed");
}
-(void)tapDetectedLeft{
    [self.navigationController popViewControllerAnimated:YES];
}

//- (IBAction)switchCarouselType
//{
//    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Select Carousel Type"
//                                                       delegate:self
//                                              cancelButtonTitle:nil
//                                         destructiveButtonTitle:nil
//                                              otherButtonTitles:@"Linear", @"Rotary", @"Inverted Rotary", @"Cylinder", @"Inverted Cylinder", @"Wheel", @"Inverted Wheel",  @"CoverFlow", @"CoverFlow2", @"Time Machine", @"Inverted Time Machine", @"Custom", nil];
//    [sheet showInView:self.view];
//}
//
//- (IBAction)toggleWrap
//{
//    _wrap = !_wrap;
//    _navItem.rightBarButtonItem.title = _wrap? @"Wrap: ON": @"Wrap: OFF";
//    [_carousel reloadData];
//}
//
//- (IBAction)insertItem
//{
//    NSInteger index = _carousel.currentItemIndex;
//    [_items insertObject:@(_carousel.numberOfItems) atIndex:index];
//    [_carousel insertItemAtIndex:index animated:YES];
//}
//
//- (IBAction)removeItem
//{
//    if (_carousel.numberOfItems > 0)
//    {
//        NSInteger index = _carousel.currentItemIndex;
//        [_carousel removeItemAtIndex:index animated:YES];
//        [_items removeObjectAtIndex:index];
//    }
//}
//
#pragma mark -
#pragma mark UIActionSheet methods

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex >= 0)
    {
        //map button index to carousel type
        iCarouselType type = buttonIndex;
        
        //carousel can smoothly animate between types
        [UIView beginAnimations:nil context:nil];
        _carousel.type = type;
        [UIView commitAnimations];
        
        //update title
        _navItem.title = [actionSheet buttonTitleAtIndex:buttonIndex];
    }
}

#pragma mark -
#pragma mark iCarousel methods

//- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
//{
//    return [_items count];
//}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    //create new view if no view is available for recycling
    if (view == nil)
    {
        FXImageView *imageView = [[FXImageView alloc] initWithFrame:CGRectMake(0, 0, 200.0f, 200.0f)];
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
    ((FXImageView *)view).image = _images[index];
    
    return view;
}

//
//- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
//{
//    UILabel *label = nil;
//    
//    //create new view if no view is available for recycling
//    if (view == nil)
//    {
//        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200.0f, 200.0f)];
//        ((UIImageView *)view).image = [UIImage imageNamed:@"page.png"];
//        view.contentMode = UIViewContentModeCenter;
//        label = [[UILabel alloc] initWithFrame:view.bounds];
//        label.backgroundColor = [UIColor clearColor];
//        label.textAlignment = UITextAlignmentCenter;
//        label.font = [label.font fontWithSize:50];
//        label.tag = 1;
//        [view addSubview:label];
//    }
//    else
//    {
//        //get a reference to the label in the recycled view
//        label = (UILabel *)[view viewWithTag:1];
//    }
//    
//    //set item label
//    //remember to always set any properties of your carousel item
//    //views outside of the `if (view == nil) {...}` check otherwise
//    //you'll get weird issues with carousel item content appearing
//    //in the wrong place in the carousel
//    label.text = [_items[index] stringValue];
//    
//    return view;
//}

//- (CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
//{
//    //implement 'flip3D' style carousel
//    transform = CATransform3DRotate(transform, M_PI / 8.0f, 0.0f, 1.0f, 0.0f);
//    return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * carousel.itemWidth);
//}
//
//- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
//{
//    //customize carousel display
//    switch (option)
//    {
//        case iCarouselOptionWrap:
//        {
//            //normally you would hard-code this to YES or NO
//            return _wrap;
//        }
//        case iCarouselOptionSpacing:
//        {
//            //add a bit of spacing between the item views
//            return value * 1.05f;
//        }
//        case iCarouselOptionFadeMax:
//        {
//            if (carousel.type == iCarouselTypeCustom)
//            {
//                //set opacity based on distance from camera
//                return 0.0f;
//            }
//            return value;
//        }
//        default:
//        {
//            return value;
//        }
//    }
//}
//
@end