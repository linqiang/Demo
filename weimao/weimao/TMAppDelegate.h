//
//  TMAppDelegate.h
//  weimao
//
//  Created by mac on 14-4-28.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMAppDelegate : UIResponder <UIApplicationDelegate,UIAlertViewDelegate>
{
    Reachability *hostRech;
}
@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic)LTKNavigationViewController *navigationController;
- (void)startLoading;
- (void)stopLoading;
- (NSURL *)applicationDocumentsDirectory;@end
