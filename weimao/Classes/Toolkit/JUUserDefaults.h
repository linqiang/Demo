//
//  AMUserDefaults.h
//  ApplicationMarket
//
//  Created by chen wei on 13-4-13.
//  Copyright (c) 2013年 chen wei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JUUserDefaults : NSObject
//应用的名称
@property(nonatomic, readonly)NSString*     appName;
@property(nonatomic, readonly)NSString*     appVersion;


//换肤相关属性
//当前皮肤所在bundle名称
@property(nonatomic, assign) NSString*    skinBundle;
//导航栏、工具条的tintcolor
@property(nonatomic, readonly) UIColor*   tintColor;

// 静态全局的改对象实例
+ (JUUserDefaults *)instance;


- (UIColor*) getColorByColorKey:(NSString*) colorKey;
@end
