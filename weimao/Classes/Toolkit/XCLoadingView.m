//
//  XCLoadingView.m
//  Appk_ProductShow
//
//  Created by user on 13-8-3.
//  Copyright (c) 2013年 wuxian. All rights reserved.
//

#import "XCLoadingView.h"
#import <QuartzCore/QuartzCore.h>

@interface XCLoadingView() {
    id mcontext;
    UIView  *_loadingView;
}

@end

@implementation XCLoadingView
+(id)build:(id)ncontext{
    return [[[XCLoadingView alloc]init:ncontext] autorelease];
}

-(id)init:(id)context{
    self=[super init];
    if(self){
        mcontext=context;
    }
    return self;
}

-(void)dismiss{
    [_loadingView removeFromSuperview];
    [_loadingView release];
    _loadingView=nil;
    
    if ([mcontext isKindOfClass:[UIView class]]) {
        [mcontext setUserInteractionEnabled:YES];
    }
    else if ([mcontext isKindOfClass:[UIViewController class]]) {
        [[mcontext view] setUserInteractionEnabled:YES];
    }
}

-(void)show{
    _loadingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 100)];
    _loadingView.backgroundColor = [UIColor clearColor];
    _loadingView.clipsToBounds = YES;
    _loadingView.layer.cornerRadius = 6.0;
    
    UIView *bg = [[UIView alloc] initWithFrame:_loadingView.frame];
    bg.backgroundColor = [UIColor blackColor];
    bg.alpha = 0.6;
    [_loadingView addSubview:bg];
    
    UIActivityIndicatorView *loadAct = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    loadAct.hidesWhenStopped = YES;
    [loadAct startAnimating];
    loadAct.center = CGPointMake(CGRectGetMidX(_loadingView.frame), CGRectGetMidY(_loadingView.frame)-10);
    [_loadingView addSubview:loadAct];
    [loadAct release];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    label.text = @"加载中...";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:14];
    label.backgroundColor = [UIColor clearColor];
    label.center = CGPointMake(loadAct.center.x, loadAct.center.y+40);
    [_loadingView addSubview:label];
    [label release];
    
    if ([mcontext isKindOfClass:[UIView class]]) {
        _loadingView.center = CGPointMake(CGRectGetMidX([mcontext frame]), CGRectGetMidY([mcontext frame]));
        [mcontext addSubview:_loadingView];
//        [mcontext setUserInteractionEnabled:NO];
    }
    else if ([mcontext isKindOfClass:[UIViewController class]]) {
        _loadingView.center = CGPointMake(CGRectGetMidX([[mcontext view] frame]), CGRectGetMidY([[mcontext view] frame]));
        [[mcontext view] addSubview:_loadingView];
//        [[mcontext view] setUserInteractionEnabled:NO];
    }
}

-(id)getContext{
    return mcontext;
}
@end
