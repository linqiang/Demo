//
//  GlobalTool.h
//  Appk_ProductShow
//
//  Created by wuxian on 13-6-13.
//  Copyright (c) 2013年 wuxian. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GlobalTool : NSObject
{
    NSMutableArray *g_FavoriateArray;
}
@property (nonatomic, retain) NSString *apkid;
@property (nonatomic) BOOL canLogin;
@property (nonatomic) BOOL canRegister;
@property (nonatomic, retain) NSArray *moduleIds;
@property (nonatomic, retain) NSArray *moduleNames;
@property (nonatomic, retain) NSString *bussesid;
@property (nonatomic, retain) NSString *uri;
@property (nonatomic, retain) NSString *uurl;
@property (nonatomic, retain) NSString *appkey;
@property (nonatomic, retain) NSString *channel;
@property (nonatomic, retain) NSString *apkversion;

+ (GlobalTool *)sharedGlobalTool;
+ (void)readFavoriateFromFile;
+ (void)writeFavoriateToFile;

- (void)getAppData;
@end
