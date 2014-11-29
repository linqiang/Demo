//
//  Toolkit.h
//  Flower&Cake
//
//  Created by 123 on 13-7-16.
//  Copyright (c) 2013年 . All rights reserved.
//

#import <Foundation/Foundation.h>
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#define deviceHeight [[UIScreen mainScreen]bounds].size.height
extern UIButton * addButtonWithframeAndtextAndactionAndtargetAndtag(CGRect frame ,NSString * image,SEL sender,id delegate,int tag);
extern UIImage* getImgFromUrl(NSString * strFrom);
extern void ResponseWithDelegateAndLinkerNameAndLinkArray(id delegate,NSString * LinkerName,NSMutableArray * fArray);

extern UITextField *addTextFieldwithFramewithPlaceholderwithDelegate(CGRect frame,NSString* aText,id delegate);

extern UILabel * addLabelwithFramewithTextwithFontwithColor(CGRect frame,NSString * text,CGFloat ft,UIColor * colorSelf);
    //删除所有catch文件
    //输入url的string形式，得到服务器返回信息
extern id resultByStringOfUrl(NSString * strUrl);
extern void removeCatchFiels(void);
    //获取资源全路径
extern NSString* resourcePath(NSString* fileName);
    //用于UIImage的imageNamed函数载入wowtrip.bundle下的图片
extern NSString* bundle(NSString* fileName);

extern float theHeightOftheDevice(void);

    //用于天气显示
extern void weatherAppearanceDelegate(id delegate);

    //弹出消息框来显示消息
extern void showMessage(NSString* message);
    //等待框
extern void showWaiting(UIView* view);
extern void hideWaiting(UIView* view);
    //根据图片路径加载图片
extern UIImage* bundleImage(NSString* imageName);
    //解压缩文件
extern void unzipFile(NSString* aZipFile, NSString* aPath);
    //@{目录结构
    //config目录：用来存放时间戳有效期内的景区下载文件:返回全路径
    //一点说明：fileName格式支持如"suzhou/icon.png"带路径的格式，如果该文件夹路径不存在将自动创建出来

extern NSString* templateFilePathWithUrl(NSString * url);

extern NSString* configCachePath(void);

extern UITextView * makeTextView(id obj);

extern NSString* catchPath(NSString* fileName);
    //temp目录：用来存放临时下载的文件:返回全路径
    //一点说明：fileName格式支持如"suzhou/icon.png"带路径的格式，如果该文件夹路径不存在将自动创建出来
extern NSString* temporaryPath(NSString* fileName);
    //下载文件temp目录：用来下载时临时存储文件，实现断点续传
extern NSString* downloadTemporaryPath(NSString* fileName);
    //@}

    //删除文件
extern BOOL removeFile(NSString* fileName);
    //检查文件是否存在：此是ExistAtConfigPath和ExistAtTemporaryPath的综合，但不负责创建路径
extern BOOL existAtPath(NSString* fileFullPath);
extern NSString* DocumentPath(void);
    //计算文字实际高度
extern float calcTextHight(UIFont *font, NSString* text, CGFloat width);
extern float calcTextWidth(UIFont *font, NSString* text, CGFloat width);


    //时间日期转换
extern NSString* dateStringWithTimeInterval(NSNumber* secs);
extern NSString* dateStringWithTimeIntervalOnlyDay(NSNumber* secs);
extern NSString* stringFromDate(NSDate* aDate, NSString *aFormat);
extern NSDate*   dateFromString(NSString* string, NSString* aFormat);

    //创建actionsheet
extern UIActionSheet* actionSheet(NSString* title, NSArray* buttonsArray, id delegate);


extern UIColor* TEXTCOLOR(NSString* colorHex);
extern UIColor* BACKCOLOR(NSString* colorHex);
extern UIColor* BORDERCOLOR(NSString* colorHex);
//当前时间
extern NSString* currentTime(void);
//删除所有catch文件
extern void RemoveCatchFiels(void);
//获取资源全路径
extern NSString* ResourcePath(NSString* fileName);
//用于UIImage的imageNamed函数载入wowtrip.bundle下的图片
extern NSString* Bundle(NSString* fileName);
//弹出消息框来显示消息
extern void ShowMessage(NSString* message);
//收藏
extern void showShareMessage(NSString* message);
extern void showStatusBarMessage(NSString* message);
//根据图片路径加载图片
extern UIImage* BundleImage(NSString* imageName);

//@{目录结构
//config目录：用来存放时间戳有效期内的景区下载文件:返回全路径
//一点说明：fileName格式支持如"suzhou/icon.png"带路径的格式，如果该文件夹路径不存在将自动创建出来
extern NSString* CatchPath(NSString* fileName);
//temp目录：用来存放临时下载的文件:返回全路径
//一点说明：fileName格式支持如"suzhou/icon.png"带路径的格式，如果该文件夹路径不存在将自动创建出来
extern NSString* TemporaryPath(NSString* fileName);
//下载文件temp目录：用来下载时临时存储文件，实现断点续传
extern NSString* DownloadTemporaryPath(NSString* fileName);
//@}

//删除文件
extern BOOL RemoveFile(NSString* fileName);
//检查文件是否存在：此是ExistAtConfigPath和ExistAtTemporaryPath的综合，但不负责创建路径
extern BOOL ExistAtPath(NSString* fileFullPath);

//计算文字实际高度
extern float CalcTextHight(UIFont *font, NSString* text, CGFloat width);
extern float CalcTextWidth(UIFont *font, NSString* text, CGFloat width);


//时间日期转换
extern NSString* DateStringWithTimeInterval(NSNumber* secs);
extern NSString* DateStringWithTimeIntervalOnlyDay(NSNumber* secs);
extern NSString* StringFromDate(NSDate* aDate, NSString *aFormat);
extern NSDate*   DateFromString(NSString* string, NSString* aFormat);

//创建actionsheet
extern UIActionSheet* ActionSheet(NSString* title, NSArray* buttonsArray, id delegate);
extern UIColor* TEXTCOLOR(NSString* colorHex);
extern UIColor* BACKCOLOR(NSString* colorHex);
extern UIColor* BORDERCOLOR(NSString* colorHex);
//将十六进制的颜色值转换为uicolor:rrggbbhh
extern UIColor*hexColor(NSString*hexColor);

//extern void TPLLog(NSString *format, ...);
extern UIButton*addButton(CGRect frame ,UIImage *aImage ,SEL selector,id delegate);
extern UILabel*addLabel(CGRect frame ,NSString*aTitle);
extern UITextField*addField(CGRect frame ,NSString*aText,id delegate);
//label
extern void labelFrameWithFont(UILabel*label ,double originX ,double originY, NSString*title);
extern  CGColorRef BundleCGColor(CGFloat red,CGFloat green,CGFloat blue,CGFloat alpha);


