//
//  XCLoadingView.h
//  Appk_ProductShow
//
//  Created by user on 13-8-3.
//  Copyright (c) 2013年 wuxian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCLoadingView : NSObject
-(id)init:(id)context;

+(id)build:(id)ncontext;

-(void)show;

-(void)dismiss;

-(id)getContext;
@end
