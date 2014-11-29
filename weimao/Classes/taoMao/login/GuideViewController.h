//
//  ViewController.h
//  GuideViewController
//
//  Created by chenwei on 12-9-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface GuideViewController : LTKViewController<UIScrollViewDelegate>
{
    
    UIImageView     *_imageView;
    UIImageView     *_left;
    UIImageView     *_reight;
    UIScrollView    *_pageScroll;
    UIPageControl   *_pageControl;
    UIButton    *_gotoMainViewBtn;
    NSMutableDictionary    *dic;

}
@property (nonatomic,retain) UIImageView *imageView;
@property (nonatomic,retain) UIImageView *left;
@property (nonatomic,retain) UIImageView *right;
@property (retain, nonatomic)  UIScrollView *pageScroll;
@property (retain, nonatomic)  UIPageControl *pageControl;
@property (retain, nonatomic)   UIButton * gotoMainViewBtn;

- (void)gotoMainView;


@end
