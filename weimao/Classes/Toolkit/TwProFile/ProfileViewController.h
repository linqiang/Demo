//
//  ProfileViewController.h
//  TwProfile
//
//  Created by hunk on 4/30/13.
//  Copyright (c) 2013 mx.com.hunk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UIImageView *imgProfile;
@property (nonatomic, retain) UITableView *tableView;

@end
