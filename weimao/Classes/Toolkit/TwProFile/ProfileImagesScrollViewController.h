//
//  ProfileImagesScrollViewController.h
//  TwProfile
//
//  Created by Edgar on 5/19/13.
//  Copyright (c) 2013 mx.com.hunk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileImagesScrollViewController : UIViewController<UIScrollViewDelegate>

@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIScrollView *imgContainer;
@property (nonatomic, retain) UIScrollView *wrapperScroll;

@end
