//
//  GlobalTool.m
//  Appk_ProductShow
//
//  Created by wuxian on 13-6-13.
//  Copyright (c) 2013年 wuxian. All rights reserved.
//

#import "GlobalTool.h"
#define FavoriateFileName @"favoriateFile.txt"
static GlobalTool *sharedObj = nil;

@implementation GlobalTool

+ (void)readFavoriateFromFile {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cacheDirectory = [paths objectAtIndex:0];
    NSString *filePath = [cacheDirectory stringByAppendingPathComponent:FavoriateFileName];
//    [g_FavoriateArray addObjectsFromArray:[NSArray arrayWithContentsOfFile:filePath]];
//    NSLog(@"g_FavoriateArray:%@",g_FavoriateArray);
}

+ (void)writeFavoriateToFile {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cacheDirectory = [paths objectAtIndex:0];
    NSString *filePath = [cacheDirectory stringByAppendingPathComponent:FavoriateFileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:filePath]) {
        [fileManager createFileAtPath:filePath contents:nil attributes:nil];
    }
//    [g_FavoriateArray writeToFile:filePath atomically:YES];
//    NSLog(@"g_FavoriateArray:%@",g_FavoriateArray);
}

+(UIImage *)colorizeImage:(UIImage *)baseImage withColor:(UIColor *)theColor {
    UIGraphicsBeginImageContext(baseImage.size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, baseImage.size.width, baseImage.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSaveGState(ctx);
    CGContextClipToMask(ctx, area, baseImage.CGImage);
    
    [theColor set];
    CGContextFillRect(ctx, area);
	
    CGContextRestoreGState(ctx);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextDrawImage(ctx, area, baseImage.CGImage);
	
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (GlobalTool *)sharedGlobalTool {
    @synchronized (self)
    {
        if (sharedObj == nil)
        {
            sharedObj=[[self alloc] init];
        }
    }
    return sharedObj;
}

- (void)getAppData {
    NSDictionary *appData = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"App_Data" ofType:@"plist"]];
    NSArray *allkeys = [appData allKeys];
    if ([allkeys containsObject:@"apkid"]) {
        self.apkid = [appData objectForKey:@"apkid"];
    }
    if ([allkeys containsObject:@"canLogin"]) {
        self.canLogin = [[appData objectForKey:@"canLogin"] boolValue];
    }
    if ([allkeys containsObject:@"canRegister"]) {
        self.canRegister = [[appData objectForKey:@"canRegister"] boolValue];
    }
    if ([allkeys containsObject:@"moduleIds"]) {
        self.moduleIds = [[appData objectForKey:@"moduleIds"] componentsSeparatedByString:@","];
    }
    if ([allkeys containsObject:@"moduleNames"]) {
        self.moduleNames = [[appData objectForKey:@"moduleNames"] componentsSeparatedByString:@","];
    }
    if ([allkeys containsObject:@"bussesid"]) {
        self.bussesid = [appData objectForKey:@"bussesid"];
    }
    
    NSDictionary *initConfigData = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"InitConfig" ofType:@"plist"]];
    NSString *uriStr = [[initConfigData objectForKey:@"init"] objectForKey:@"uri"];
    self.uri = uriStr;
    
    NSString *uurlStr = [[initConfigData objectForKey:@"init"] objectForKey:@"uurl"];
    self.uurl = uurlStr;
    
    if ([allkeys containsObject:@"appkey"]) {
        self.appkey = [appData objectForKey:@"appkey"];
    }
    
    if ([allkeys containsObject:@"channel"]) {
        self.channel = [appData objectForKey:@"channel"];
    }
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    self.apkversion = app_build;
    
    [GlobalTool readFavoriateFromFile];
    
}
@end
