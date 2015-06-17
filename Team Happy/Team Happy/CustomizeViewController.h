//
//  CustomizeViewController.h
//  Team Happy
//
//  Created by Shao-Chi Yu on 16/06/15.
//  Copyright (c) 2015 Imengine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXImageView.h"
#import "iCarousel.h">
@interface CustomizeViewController : UIViewController <iCarouselDataSource>
- (instancetype)initWithImage:(UIImageView *)pinImage;
@property (nonatomic, strong) UIImageView *pinImage;

@end
