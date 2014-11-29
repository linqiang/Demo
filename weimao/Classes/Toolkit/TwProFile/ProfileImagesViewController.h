//
//  ProfileImagesViewController.h
//  TwProfile
//
//  Created by Edgar on 5/19/13.
//  Copyright (c) 2013 mx.com.hunk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileImagesViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UIScrollView *imgContainer;
@property (nonatomic, retain) UIScrollView *wrapperScroll;

@end
