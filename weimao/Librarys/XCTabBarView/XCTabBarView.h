//
//  XCTabBarView.h
//  Appk_ProductShow
//
//  Created by wuxian on 13-6-26.
//  Copyright (c) 2013年 wuxian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XCTabBarDelegate <NSObject>
- (void)selectTabWithIndex:(int)index;
- (void)startRemoveLoginVC;
@end

@interface XCTabBarView : UIView

@property (nonatomic, retain) NSString *backgroundImgName;
@property (nonatomic, retain) NSArray *titleArray;
@property (nonatomic, retain) NSArray *textNormalColorArray;
@property (nonatomic, retain) NSArray *textHighColorArray;
@property (nonatomic, retain) NSArray *normalIconImageArray;
@property (nonatomic, retain) NSArray *highIconImageArray;
@property (nonatomic, retain) NSArray *normalBGImgArray;
@property (nonatomic, retain) NSArray *highBGImgArray;

@property (nonatomic, assign) id<XCTabBarDelegate> tabBarDelegate;
- (void)configUI;
- (void)selectedTabWithIndex:(int)index;
- (void)changeStatusWithIndex:(int)index;
@end
