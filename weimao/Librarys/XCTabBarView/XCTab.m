//
//  XCTab.m
//  Appk_ProductShow
//
//  Created by wuxian on 13-6-19.
//  Copyright (c) 2013年 wuxian. All rights reserved.
//

#import "XCTab.h"
#import <QuartzCore/QuartzCore.h>

@interface XCTab() {
    BOOL _isSelected;
}

@end
@implementation XCTab

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)configUI {
    _isSelected = NO;
    if (self.normalBGImg) {
        [_bgImg setImage:[UIImage imageNamed:self.normalBGImg]];
    }
    if (self.normalIconImage) {
        [_iconImg setImage:[UIImage imageNamed:self.normalIconImage]];
    }
    if (self.title) {
        _titleLabel.text = self.title;
        if (self.textNormalColor) {
            _titleLabel.textColor = self.textNormalColor;
        }
    }
}

- (void)selectedTabWithIndex:(int)index {}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    if ([self.delegate respondsToSelector:@selector(selectedTabWithIndex:)]) {
        [self.delegate selectedTabWithIndex:self.index];
    }
}

- (void)setSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    CATransition *animation = [CATransition animation];
    animation.duration = 0.2f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionFade;
    if (_isSelected) {
        if (self.highBGImg) {
            [_bgImg setImage:[UIImage imageNamed:self.highBGImg]];
        }
        if (self.highIconImage) {
            [_iconImg setImage:[UIImage imageNamed:self.highIconImage]];
        }
        if (self.title) {
            _titleLabel.text = self.title;
            if (self.textHighColor) {
                _titleLabel.textColor = self.textHighColor;
            }
        }
    }
    else {
//        if (self.normalBGImg) {
            [_bgImg setImage:[UIImage imageNamed:self.normalBGImg]];
//        }
        if (self.normalIconImage) {
            [_iconImg setImage:[UIImage imageNamed:self.normalIconImage]];
        }
        if (self.title) {
            _titleLabel.text = self.title;
            if (self.textNormalColor) {
                _titleLabel.textColor = self.textNormalColor;
            }
        }
    }
    [self.layer addAnimation:animation forKey:@"animation"];
}

- (void)dealloc {
    [_bgImg release];
    [_iconImg release];
    [_titleLabel release];
    [super dealloc];
}
@end
