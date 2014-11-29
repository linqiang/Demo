//
//  XCTab.h
//  Appk_ProductShow
//
//  Created by wuxian on 13-6-19.
//  Copyright (c) 2013年 wuxian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCTab : UIView
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) UIColor *textNormalColor;
@property (nonatomic, retain) UIColor *textHighColor;
@property (nonatomic, retain) NSString *normalIconImage;
@property (nonatomic, retain) NSString *highIconImage;
@property (nonatomic, retain) NSString *normalBGImg;
@property (nonatomic, retain) NSString *highBGImg;

@property (retain, nonatomic) IBOutlet UIImageView *bgImg;
@property (retain, nonatomic) IBOutlet UIImageView *iconImg;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, assign) id delegate;
@property (nonatomic) int index;

- (void)configUI;
- (void)setSelected:(BOOL)isSelected;
@end
