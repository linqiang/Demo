//
//  XCTabBarView.m
//  Appk_ProductShow
//
//  Created by wuxian on 13-6-26.
//  Copyright (c) 2013年 wuxian. All rights reserved.
//

#import "XCTabBarView.h"
#import "XCTab.h"
#define kTabCount 5

@interface XCTabBarView() {
    int _currentIndex;
}

@end

@implementation XCTabBarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _currentIndex = -1;
    }
    return self;
}

- (void)configUI {
    if (self.backgroundImgName) {
        UIImageView *bg = [[UIImageView alloc] initWithFrame:self.bounds];
        [bg setImage:[UIImage imageNamed:self.backgroundImgName]];
        [self addSubview:bg];
    }
//    self.backgroundColor = [UIColor whiteColor];
    
    float origX = 0;
    float origY = 0;
    float width = 64;
    float height = 49;
    
    for (int i=0; i<kTabCount; i++) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"XCTab" owner:self options:nil];
        XCTab *tab = (XCTab *)[array objectAtIndex:0];
        tab.frame = CGRectMake(origX+width*i, origY, width, height);
        tab.index = i;
        tab.delegate = self;
        if ([self.titleArray count]>i) {
            tab.title = [self.titleArray objectAtIndex:i];
        }
        if ([self.textNormalColorArray count]>i) {
            tab.textNormalColor = [self.textNormalColorArray objectAtIndex:i];
        }
        if ([self.textHighColorArray count]>i) {
            tab.textHighColor = [self.textHighColorArray objectAtIndex:i];
        }
        if ([self.normalIconImageArray count]>i) {
            tab.normalIconImage = [self.normalIconImageArray objectAtIndex:i];
        }
        if ([self.highIconImageArray count]>i) {
            tab.highIconImage = [self.highIconImageArray objectAtIndex:i];
        }
        if ([self.normalBGImgArray count]>i) {
            tab.normalBGImg = [self.normalBGImgArray objectAtIndex:i];
        }
        if ([self.highBGImgArray count]>i) {
            tab.highBGImg = [self.highBGImgArray objectAtIndex:i];
        }
        [tab configUI];
        [self addSubview:tab];
    }
}

- (void)selectedTabWithIndex:(int)index {
//    if (_currentIndex==index) {
//        return;
//    }
    
    [self.tabBarDelegate selectTabWithIndex:index];
//    _currentIndex = index;
}

- (void)changeStatusWithIndex:(int)index {
    for (id subview in self.subviews) {
        if ([subview isKindOfClass:[XCTab class]]) {
            if ([(XCTab *)subview index]==index) {
                [(XCTab *)subview setSelected:YES];
            }
            else {
                [(XCTab *)subview setSelected:NO];
            }
        }
    }

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
