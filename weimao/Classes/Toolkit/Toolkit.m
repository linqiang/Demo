//
//  Toolkit.m
//  Flower&Cake
//
//  Created by 123 on 13-7-16.
//  Copyright (c) 2013年 . All rights reserved.
//

#import "Toolkit.h"
#import "JUUserDefaults.h"

UIButton * addButtonWithframeAndtextAndactionAndtargetAndtag(CGRect frame ,NSString * image,SEL sender,id delegate,int tag)
{
    UIButton * btnNormal = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnNormal addTarget:delegate action:sender forControlEvents:UIControlEventTouchUpInside];
    btnNormal.tag = tag;
    [btnNormal setFrame:frame];
    UIImageView * img = [[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, btnNormal.frame.size.width, btnNormal.frame.size.height)] autorelease];
    img.tag = tag+10000;
    [img setBackgroundColor:[UIColor clearColor]];
    [img setImage:[UIImage imageNamed:image]];
    [btnNormal addSubview:img];

    return btnNormal;
}

extern UIImage* getImgFromUrl(NSString * strFrom)
{
    NSString * strTo = nil;
    NSDictionary *initConfigData = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"InitConfig" ofType:@"plist"]];
    NSString *uriStr = [[initConfigData objectForKey:@"init"] objectForKey:@"uri"];
    strTo = [NSString stringWithFormat:@"%@/%@",uriStr,strFrom];
    UIImage * img = [[[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:strTo]]]autorelease];
    return img;
}

extern void ResponseWithDelegateAndLinkerNameAndLinkArray(id delegate,NSString * LinkerName,NSMutableArray * fArray)
{
//    NSMutableArray * array = [[NSMutableArray alloc] initWithObjects:
//                              [NSString stringWithFormat:@"%@%@",@"appid=",[XcGlobalTool sharedGlobalTool].apkid],
//                              [NSString stringWithFormat:@"%@%@",@"deviceid=",[[NSUserDefaults standardUserDefaults] objectForKey:@"deviceid"]],
//                              nil];
//    [array addObjectsFromArray:fArray];
//
//    XcUpdateOne *updateone = [[XcUpdateOne alloc] initWithMethodName:LinkerName params:array delegate:delegate isRefresh:NO];
//    [XcDataManager loadData:[NSArray arrayWithObjects:updateone, nil]];
}
//当前时间
NSString *currentTime(void){
    
    NSDateFormatter*formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd "];
    NSString*time=[formatter stringFromDate:[NSDate date]];
    return time;
}
//用于UIImage的imageNamed函数载入wowtrip.bundle下的图片
NSString* Bundle(NSString* fileName)
{
	JUUserDefaults* defaults = [JUUserDefaults instance];
    
	if (nil != defaults.skinBundle &&
        ExistAtPath(ResourcePath([NSString stringWithFormat:@"%@/%@", defaults.skinBundle, fileName]))) {
		return [NSString stringWithFormat:@"%@/%@", defaults.skinBundle, fileName];
	}
	return [NSString stringWithFormat:@"resource.bundle/%@", fileName];
}

//根据图片路径加载图片
extern UIImage* BundleImage(NSString* imageName)
{
    return [UIImage imageNamed:imageName];
}

//弹出消息框来显示消息
void ShowMessage(NSString* message)
{
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil
											  cancelButtonTitle:@"确定"
											  otherButtonTitles:nil];
	[alertView show];
	[alertView release];
}

//获取资源全路径
NSString* ResourcePath(NSString* fileName) {
	return [[[NSBundle mainBundle] resourcePath] stringByAppendingFormat:@"/%@", fileName];
}

//config目录：用来存放时间戳有效期内的景区下载文件:返回全路径
NSString* CatchPath(NSString* fileName) {
    return nil;
}

//temp目录：用来存放临时下载的文件:返回全路径
//一点说明：fileName格式支持如"suzhou/icon.png"带路径的格式，如果该文件夹路径不存在将自动创建出来
NSString* TemporaryPath(NSString* fileName) {
    return nil;
}

//下载文件temp目录：用来下载时临时存储文件，实现断点续传
NSString* DownloadTemporaryPath(NSString* fileName) {
	return nil;
}

//检查文件是否存在：此是ExistAtConfigPath和ExistAtTemporaryPath的综合
BOOL ExistAtPath(NSString* fileFullPath) {
	return [[fileFullPath pathExtension] length] > 0 &&
    [[NSFileManager defaultManager] fileExistsAtPath:fileFullPath];
}


//删除所有catch文件
void RemoveCatchFiels(void) {
	
}

float CalcTextHight(UIFont *font, NSString* text, CGFloat width) {
	CGSize sz = [text sizeWithFont:font
                 constrainedToSize:CGSizeMake(width, 10000.0)];
	
	return sz.height;
}

float CalcTextWidth(UIFont *font, NSString* text, CGFloat width) {
	CGSize sz = [text sizeWithFont:font constrainedToSize:CGSizeMake(width, font.lineHeight)];
    
	return sz.width;
}

NSString*  DateStringWithTimeInterval(NSNumber* secs) {
	if ([secs intValue] <= 0) {
		return @"";
	} else {
		return StringFromDate([NSDate dateWithTimeIntervalSince1970:[secs doubleValue]], @"yyyy-MM-dd HH:mm");
	}
}

NSString* DateStringWithTimeIntervalOnlyDay(NSNumber* secs) {
	if ([secs intValue] <= 0) {
		return @"";
	} else {
		return StringFromDate([NSDate dateWithTimeIntervalSince1970:[secs doubleValue]], @"yyyy-MM-dd");
	}
}

NSString* StringFromDate(NSDate* aDate, NSString *aFormat) {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setTimeZone:[NSTimeZone defaultTimeZone]];
	[formatter setDateFormat:aFormat];
	NSString *dateString = [formatter stringFromDate:aDate];
	[formatter release];
	return dateString;
}

NSDate*   DateFromString(NSString* string, NSString* aFormat) {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone defaultTimeZone]];
    [formatter setDateFormat:aFormat];
    NSDate *date = [formatter dateFromString:string];
    [formatter release];
    return date;
}

UIActionSheet* ActionSheet(NSString* title, NSArray* buttonsArray, id delegate) {
	if ([buttonsArray count] >= 1) {
		UIActionSheet * sheet = [[UIActionSheet alloc]
								 initWithTitle:title
								 delegate:delegate
								 cancelButtonTitle:nil
								 destructiveButtonTitle:nil
								 otherButtonTitles:nil];
		for (int i=0; i<[buttonsArray count]; i++) {
			NSString * label = [buttonsArray objectAtIndex:i];
			[sheet addButtonWithTitle:label];
		}
		[sheet addButtonWithTitle:@"取消"];
		sheet.cancelButtonIndex = [buttonsArray count];
		return [sheet autorelease];
	}
	return nil;
}


UIColor* TEXTCOLOR(NSString* colorHex) {
	return [[JUUserDefaults instance] getColorByColorKey:[@"text_" stringByAppendingString:[colorHex lowercaseString]]];
}

UIColor* BACKCOLOR(NSString* colorHex) {
	return [[JUUserDefaults instance] getColorByColorKey:[@"back_" stringByAppendingString:[colorHex lowercaseString]]];
}

UIColor* BORDERCOLOR(NSString* colorHex) {
	return [[JUUserDefaults instance] getColorByColorKey:[@"border_" stringByAppendingString:[colorHex lowercaseString]]];
}

void TPLLog(NSString *format, ...) {
    
}
void showShareMessage(NSString* message) {
    UIWindow * _window= [[UIWindow alloc]initWithFrame:CGRectMake((320-196)/2, 200,196,67)];
    _window.windowLevel=UIWindowLevelStatusBar;
    _window.backgroundColor= [UIColor blackColor];
    UIImageView*img=[[UIImageView alloc]init];
    img.frame=CGRectMake(0, 0, 196, 67);
    img.image=BundleImage(@"black_collecting_bg.png");
    [_window addSubview:img];
    //label
    UILabel*label = [[UILabel alloc]initWithFrame:CGRectMake(0,0,196,67)];
    label.textAlignment=UITextAlignmentCenter;
    label.text=message;
    label.font = [UIFont boldSystemFontOfSize:12];
    label.textColor= [UIColor grayColor];
    label.backgroundColor= [UIColor clearColor];
    label.alpha=1.0;
    [_window addSubview:label];
    [_window makeKeyAndVisible];
    _window.backgroundColor = [UIColor clearColor];
    //animation
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:2.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    _window.frame=CGRectMake(320, 200,196,67);
    [UIView commitAnimations];
    
    //慢慢变透明，然后消失
    [UIView animateWithDuration:1.5
                     animations:^{
                         _window.alpha = 0.2;
                         
                     }];
    [_window performSelector:@selector(removeFromSuperview)
                  withObject:nil
                  afterDelay:0.8];
    [label release];
    [_window release];
    //1000~2000
}

void showStatusBarMessage(NSString* message) {
    UIWindow * _window= [[UIWindow alloc]initWithFrame:CGRectMake(320-100, 0,100,20)];
    _window.windowLevel=UIWindowLevelStatusBar;
    _window.backgroundColor= [UIColor blackColor];
    //label
    UILabel*label = [[UILabel alloc]initWithFrame:CGRectMake(0,0,100,20)];
    label.textAlignment=UITextAlignmentCenter;
    label.text=message;
    label.font = [UIFont boldSystemFontOfSize:14];
    label.textColor= [UIColor whiteColor];
    label.backgroundColor= [UIColor blackColor];
    label.alpha=0.8;
    [_window addSubview:label];
    [_window makeKeyAndVisible];
    _window.backgroundColor = [UIColor clearColor];
    //animation
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.2];
    _window.frame=CGRectMake(320-100, 0,100,20);
    [UIView commitAnimations];
    
    //慢慢变透明，然后消失
    [UIView animateWithDuration:2
                     animations:^{
                         _window.alpha = 0;
                     }];
    [_window performSelector:@selector(removeFromSuperview)
                  withObject:nil
                  afterDelay:2];
    [label release];
    [_window release];
    //1000~2000
}
//将十六进制的颜色值转换为uicolor:rrggbbhh
UIColor* hexColor(NSString*hexColor){
	unsigned int red, green, blue, alpha;
	NSRange range;
	range.length = 2;
	@try {
		if ([hexColor hasPrefix:@"#"])
        {
			hexColor = [hexColor stringByReplacingOccurrencesOfString:@"#" withString:@""];
		}
        range.location = 0;
        [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
        range.location = 2;
        [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
        range.location = 4;
        [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
        
		if ([hexColor length] > 6) {
			range.location = 6;
			[[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&alpha];
		}
    }
    @catch (NSException * e) {
        //        showMessage(@"颜色取值错误:%s,%s", [e name], [e reason]);
        return [UIColor blackColor];
    }
    
	return [[UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:(float)(alpha/100.0f)]retain];
}

UIButton *addButton(CGRect frame ,UIImage *aImage ,SEL selector,id delegate)
{
	UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
	btn.frame = frame;
	[btn setBackgroundImage:aImage/*[aImage scaleToSize:frame.size]*/ forState:UIControlStateNormal];
	[btn addTarget:delegate action:selector forControlEvents:UIControlEventTouchUpInside];
    //	[self addSubview:btn];
    
	return [btn retain];
}

UILabel*addLabel(CGRect frame ,NSString*aTitle)
{
	UILabel* label = [[UILabel alloc] initWithFrame:frame];
	label.text = aTitle;
	label.textColor = [UIColor blackColor];//[UIColor colorWithRed:0 green:153/255.0 blue:204/255.0 alpha:1.0];
	label.backgroundColor = [UIColor clearColor];
	label.font = [UIFont boldSystemFontOfSize:16.0];
    //	[self addSubview:label];
	return label;
}

UITextField*addField(CGRect frame ,NSString*aText,id delegate)
{
	UITextField *field = [[UITextField alloc] initWithFrame:frame];
	field.clearsOnBeginEditing = NO;
	field.returnKeyType = UIReturnKeyDone;
    field.clearButtonMode = UITextFieldViewModeWhileEditing;
	field.textColor = [UIColor colorWithRed:0.282 green:0.341 blue:0.455 alpha:1];
	field.borderStyle = UITextBorderStyleNone;
	field.font = [UIFont boldSystemFontOfSize:18.0];
    field.placeholder = aText;
    field.contentHorizontalAlignment=0;
    [field resignFirstResponder];
	[field addTarget:delegate action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
    //	[self addSubview:field];
	return field;
}
void labelFrameWithFont(UILabel*label ,double originX ,double originY, NSString*title)
{
    label.text=title;
    
    //列宽
    CGFloat contentWith1=320-20;
    //显示字体
    UIFont *font1=[UIFont systemFontOfSize:14];
    label.font=font1;
    //        NSString *name=@"12345";
    CGSize size1=[label.text sizeWithFont:font1 constrainedToSize:CGSizeMake(contentWith1, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
    CGRect rect=[label textRectForBounds:label.frame limitedToNumberOfLines:0];
    rect.size = size1;
    label.frame=rect;
    [label setFrame:CGRectMake(originX,originY, rect.size.width, rect.size.height)];
    label.backgroundColor=[UIColor clearColor];
    label.textColor=[UIColor colorWithRed:.173 green:.173 blue:.173 alpha:1.0];
}

//CGColor   由RGB生成CGColor用于底层颜色
CGColorRef BundleCGColor(CGFloat red,CGFloat green,CGFloat blue,CGFloat alpha)
{
    CGColorSpaceRef colorSpaceRef4 = CGColorSpaceCreateDeviceRGB();
    CGFloat components4[4];
    components4[0] = red;
    components4[1] = green;
    components4[2] = blue;
    components4[3] = alpha;
    CGColorRef refColor=CGColorCreate(colorSpaceRef4, components4);
    //    UIColor *_color= [UIColor colorWithCGColor:refColor];
    CGColorSpaceRelease(colorSpaceRef4);
    
    return refColor;
}

NSString *getMacAddress(void)
{
    int                 mgmtInfoBase[6];
    char                *msgBuffer = NULL;
    size_t              length;
    unsigned char       macAddress[6];
    struct if_msghdr    *interfaceMsgStruct;
    struct sockaddr_dl  *socketStruct;
    NSString            *errorFlag = NULL;
    
    // Setup the management Information Base (mib)
    mgmtInfoBase[0] = CTL_NET;        // Request network subsystem
    mgmtInfoBase[1] = AF_ROUTE;       // Routing table info
    mgmtInfoBase[2] = 0;
    mgmtInfoBase[3] = AF_LINK;        // Request link layer information
    mgmtInfoBase[4] = NET_RT_IFLIST;  // Request all configured interfaces
    
    // With all configured interfaces requested, get handle index
    if ((mgmtInfoBase[5] = if_nametoindex("en0")) == 0)
        errorFlag = @"if_nametoindex failure";
        else
        {
            // Get the size of the data available (store in len)
            if (sysctl(mgmtInfoBase, 6, NULL, &length, NULL, 0) < 0)
                errorFlag = @"sysctl mgmtInfoBase failure";
            else
            {
                // Alloc memory based on above call
                if ((msgBuffer = malloc(length)) == NULL)
                    errorFlag = @"buffer allocation failure";
                else
                {
                    // Get system information, store in buffer
                    if (sysctl(mgmtInfoBase, 6, msgBuffer, &length, NULL, 0) < 0)
                        errorFlag = @"sysctl msgBuffer failure";
                }
            }
        }
    
    // Befor going any further...
    if (errorFlag != NULL)
    {
        NSLog(@"Error: %@", errorFlag);
        return errorFlag;
    }
    
    // Map msgbuffer to interface message structure
    interfaceMsgStruct = (struct if_msghdr *) msgBuffer;
    
    // Map to link-level socket structure
    socketStruct = (struct sockaddr_dl *) (interfaceMsgStruct + 1);
    
    // Copy link layer address data in socket structure to an array
    memcpy(&macAddress, socketStruct->sdl_data + socketStruct->sdl_nlen, 6);
    
    // Read from char array into a string object, into traditional Mac address format
    NSString *macAddressString = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x",
                                  macAddress[0], macAddress[1], macAddress[2],
                                  macAddress[3], macAddress[4], macAddress[5]];
    NSLog(@"Mac Address: %@", macAddressString);
    
    // Release the buffer memory
    free(msgBuffer);
    
    return macAddressString;
}
NSString* bundle(NSString* fileName)
{
	JUUserDefaults* defaults = [JUUserDefaults instance];

	if (nil != defaults.skinBundle &&
        existAtPath(resourcePath([NSString stringWithFormat:@"%@/%@", defaults.skinBundle, fileName])))
    {
		return [NSString stringWithFormat:@"%@/%@", defaults.skinBundle, fileName];
	}
	return [NSString stringWithFormat:@"resource.bundle/%@", fileName];
}

id resultByStringOfUrl(NSString * strUrl)
{
    NSError *error;
    NSString * str = [NSString stringWithString:strUrl];
    NSString * escapedURLString = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * urlSelf = [NSURL URLWithString:escapedURLString];
    NSString *jsonStr = [NSString stringWithContentsOfURL:urlSelf encoding:NSUTF8StringEncoding error:&error];
    id ob = [jsonStr JSONValue];
    return ob;
}

    //根据图片路径加载图片
//extern UIImage* bundleImage(NSString* imageName)
//{
//    return [UIImage imageNamed:bundle(imageName)];
//}

//void unzipFile(NSString* aZipFile, NSString* aPath)
//{
//	ZipArchive* zip = [[ZipArchive alloc] init];
//
//	NSString* l_zipfile = [NSString stringWithString: aZipFile] ;
//	NSString* unzipto = [NSString stringWithString:aPath] ;
//
//        //	NSString *dcoumentpath = DocumentPath();
//        //	NSString* l_zipfile = [dcoumentpath stringByAppendingString:aZipFile] ;
//        //NSString* unzipto = [dcoumentpath stringByAppendingString:aPath] ;
//
//	NSFileManager *fileManager = [NSFileManager defaultManager];
//	[fileManager removeItemAtPath:unzipto error:nil];
//
//	if( [zip UnzipOpenFile:l_zipfile] )
//	{
//		BOOL ret = [zip UnzipFileTo:unzipto overWrite:YES];
//		if( NO==ret )
//		{
//		}
//		[zip UnzipCloseFile];
//	}
//	[zip release];
//}

void weatherAppearanceDelegate(id delegate)
{
    NSString *googleURL = @"http://www.weather.com.cn/data/cityinfo/101191101.html";
	NSURL *url = [NSURL URLWithString:googleURL];
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
	NSURLConnection *connection = [[NSURLConnection alloc]
								   initWithRequest:request
								   delegate:delegate];
    [connection release];
	[request release];
}

float theHeightOftheDevice(void)
{
    return [UIScreen mainScreen].bounds.size.height;
}

    //弹出消息框来显示消息
void showMessage(NSString* message)
{
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil
											  cancelButtonTitle:@"确定"
											  otherButtonTitles:nil];
	[alertView show];
	[alertView release];
}

void showWaiting(UIView* view)
{
    int width = 32, height = 32;
    CGRect frame = CGRectMake(0, -20, 320, 480);//[parent frame]; //[[UIScreen mainScreen] applicationFrame];
    int x = frame.size.width;
    int y = frame.size.height;

    frame = CGRectMake((x - width) / 2, (y - height) / 2, width, height);
    UIActivityIndicatorView* progressInd = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    [progressInd startAnimating];
    progressInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;

    frame = CGRectMake(10, 75 , 80, 20);
    UILabel *waitingLable = [[UILabel alloc] initWithFrame:frame];
    waitingLable.text = @"定位中...";
    waitingLable.textColor = [UIColor whiteColor];
    [waitingLable setTextAlignment:NSTextAlignmentCenter];
    waitingLable.font = [UIFont systemFontOfSize:15];
    waitingLable.backgroundColor = [UIColor clearColor];

    frame =  CGRectMake(110, 190, 100, 110) ;//[parent frame];
    UIView *theView = [[UIView alloc] initWithFrame:frame];
//    theView.layer.masksToBounds=YES;
//    theView.layer.borderWidth=1;
//    theView.layer.cornerRadius = 8;
//    theView.layer.borderColor = [[UIColor grayColor] CGColor];
    theView.backgroundColor = [UIColor blackColor] ;
    theView.alpha = 0.6;

    [theView addSubview:progressInd];
    [theView addSubview:waitingLable];

    [theView setTag:9999];
    [view addSubview:theView];

        //整屏幕黑色底
    /*
     int width = 32, height = 32;
     CGRect frame = CGRectMake(0, -20, 320, 480);//[parent frame]; //[[UIScreen mainScreen] applicationFrame];
     int x = frame.size.width;
     int y = frame.size.height;

     frame = CGRectMake((x - width) / 2, (y - height) / 2, width, height);
     UIActivityIndicatorView* progressInd = [[UIActivityIndicatorView alloc]initWithFrame:frame];
     [progressInd startAnimating];
     progressInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;

     frame = CGRectMake((x - 70)/2, (y - height) / 2 + height, 80, 20);
     UILabel *waitingLable = [[UILabel alloc] initWithFrame:frame];
     waitingLable.text = @"请稍候...";
     waitingLable.textColor = [UIColor whiteColor];
     waitingLable.font = [UIFont systemFontOfSize:15];
     waitingLable.backgroundColor = [UIColor clearColor];

     frame =  CGRectMake(0, -20, 320, 480) ;//[parent frame];
     UIView *theView = [[UIView alloc] initWithFrame:frame];
     theView.backgroundColor = [UIColor blackColor];
     theView.alpha = 0.7;

     [theView addSubview:progressInd];
     [theView addSubview:waitingLable];

     [theView setTag:9999];
     [view addSubview:theView];
     */

}

    //消除滚动轮指示器
void hideWaiting(UIView* view)
{
    if([view viewWithTag:9999])
    {
        [[view viewWithTag:9999] removeFromSuperview];
    }
}

//    //获取资源全路径
NSString* resourcePath(NSString* fileName)
{
	return [[[NSBundle mainBundle] resourcePath] stringByAppendingFormat:@"/%@", fileName];
}

    //config目录：用来存放时间戳有效期内的景区下载文件:返回全路径
NSString* catchPath(NSString* fileName)
{
    return nil;
}

    //temp目录：用来存放临时下载的文件:返回全路径
    //一点说明：fileName格式支持如"suzhou/icon.png"带路径的格式，如果该文件夹路径不存在将自动创建出来
NSString* temporaryPath(NSString* fileName) {
    return nil;
}

    //下载文件temp目录：用来下载时临时存储文件，实现断点续传
NSString* downloadTemporaryPath(NSString* fileName) {
	return nil;
}

    //检查文件是否存在：此是ExistAtConfigPath和ExistAtTemporaryPath的综合
BOOL existAtPath(NSString* fileFullPath)
{
	return [[fileFullPath pathExtension] length] > 0 &&
    [[NSFileManager defaultManager] fileExistsAtPath:fileFullPath];
}

NSString* templateFilePathWithUrl(NSString * url)
{
    NSString * str = configCachePath();
	NSString* result = [NSString stringWithFormat:@"%@/%@", str,url];
    return result;
}

    //config-cache存放目录
NSString* configCachePath(void)
{
#if TARGET_IPHONE_SIMULATOR
	NSFileManager *manager = [NSFileManager defaultManager];
	NSError* error;
	[manager createDirectoryAtPath:@"/Developer/Documentation/Iphone/ConfigCache"
	   withIntermediateDirectories:YES
						attributes:nil
							 error:&error];
	return @"/Developer/Documentation/Iphone/ConfigCache";
        //@"/Developer/Documentation/Iphone/ConfigCache"
#else
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSFileManager *manager = [NSFileManager defaultManager];
	NSString *mcPaths = [[paths objectAtIndex:0] stringByAppendingString:@"/config_cache"];
        //	[manager createDirectoryAtPath:mcPaths attributes:nil];
    [manager createDirectoryAtPath:mcPaths withIntermediateDirectories:NO attributes:nil error:nil];

	return mcPaths;
#endif
}


UITextView * makeTextView(id sfDelegate)
{
    UITextView * textView = [[UITextView alloc] init];
        //    UITextView * textView = [[[UITextView alloc] initWithFrame:CGRectMake(30, 75, 240, 50)] autorelease]; //初始化大小并自动释放
    textView.textColor = [UIColor blackColor];//设置textview里面的字体颜色
    textView.font = [UIFont fontWithName:@"Arial" size:16.0];//设置字体名字和字体大小
    textView.delegate = sfDelegate;//设置它的委托方法
    textView.backgroundColor = [UIColor clearColor];//设置它的背景颜色
                                                    //    self.textView.text = @"Now is the time for all good developers to come to serve their country.\n\nNow is the time for all good developers to come to serve their country.";//设置它显示的内容
    textView.returnKeyType = UIReturnKeyDefault;//返回键的类型
    textView.keyboardType = UIKeyboardTypeDefault;//键盘类型
    textView.scrollEnabled = YES;//是否可以拖动
    textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
                                                                 //给UITextView加上边框，用时记得加<QuartzCore/QuartzCore.h>
                                                                 //textView.layer.cornerRadius = 8;
    textView.layer.masksToBounds = YES;
    textView.layer.borderWidth = 1;
    textView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        //    self.view.layer.contents = (id)[UIImage imageNamed:@"31"].CGImage; //给图层添加背景图片
    return textView;//加入到整个页面中
}

NSString* documentPath(void)
{
#if TARGET_IPHONE_SIMULATOR
	NSFileManager *manager = [NSFileManager defaultManager];
	[manager createDirectoryAtPath:@"/Developer/Documentation/Iphone/" attributes:nil];
	return @"/Developer/Documentation/Iphone/";
#else
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSFileManager *manager = [NSFileManager defaultManager];
	NSString *mcPaths = [[paths objectAtIndex:0] stringByAppendingString:@"/AMDoc/"];
	[manager createDirectoryAtPath:mcPaths attributes:nil];

	return mcPaths;
#endif
}

UITextField *addTextFieldwithFramewithPlaceholderwithDelegate(CGRect frame,NSString* aText,id delegate)
{
    UITextField *field = [[UITextField alloc] initWithFrame:frame];
    field.delegate = delegate;
    [field setBackgroundColor:[UIColor clearColor]];
    field.clearsOnBeginEditing = NO;
    field.returnKeyType = UIReturnKeyDefault;
    field.textColor = [UIColor colorWithRed:0.282 green:0.341 blue:0.455 alpha:1];
    field.borderStyle = UITextBorderStyleNone;
    field.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    field.clearButtonMode = UITextFieldViewModeWhileEditing;
    field.font = [UIFont boldSystemFontOfSize:15.0];
    field.placeholder = aText;

        //    field.layer.cornerRadius = 8;
        //    field.layer.masksToBounds = YES;
        //    field.layer.borderWidth = 1;
        //    field.layer.borderColor = [[UIColor lightGrayColor]CGColor];

    return field;
}

UILabel * addLabelwithFramewithTextwithFontwithColor(CGRect frame,NSString * text,CGFloat ft,UIColor * colorSelf)
{
    UILabel * label = [[UILabel alloc]initWithFrame:frame];
    label.text = text;
    [label setTextColor:colorSelf];
    [label setFont:[UIFont systemFontOfSize:ft]];
    [label setBackgroundColor:[UIColor clearColor]];
    return label;
}

    //删除所有catch文件
void removeCatchFiels(void)
{

}

float calcTextHight(UIFont *font, NSString* text, CGFloat width)
{
	CGSize sz = [text sizeWithFont:font
                 constrainedToSize:CGSizeMake(width, 10000.0)];

	return sz.height;
}

float calcTextWidth(UIFont *font, NSString* text, CGFloat width)
{
	CGSize sz = [text sizeWithFont:font constrainedToSize:CGSizeMake(width, font.lineHeight)];

	return sz.width;
}

NSString*  dateStringWithTimeInterval(NSNumber* secs)
{
	if ([secs intValue] <= 0)
    {
		return @"";
	}
    else
    {
		return stringFromDate([NSDate dateWithTimeIntervalSince1970:[secs doubleValue]], @"yyyy-MM-dd HH:mm");
	}
}

NSString* dateStringWithTimeIntervalOnlyDay(NSNumber* secs)
{
	if ([secs intValue] <= 0)
    {
		return @"";
	}
    else
    {
		return stringFromDate([NSDate dateWithTimeIntervalSince1970:[secs doubleValue]], @"yyyy-MM-dd");
	}
}

NSString* stringFromDate(NSDate* aDate, NSString *aFormat)
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setTimeZone:[NSTimeZone defaultTimeZone]];
	[formatter setDateFormat:aFormat];
	NSString *dateString = [formatter stringFromDate:aDate];
	[formatter release];
	return dateString;
}

NSDate* dateFromString(NSString* string, NSString* aFormat)
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone defaultTimeZone]];
    [formatter setDateFormat:aFormat];
    NSDate *date = [formatter dateFromString:string];
    [formatter release];
    return date;
}

UIActionSheet* actionSheet(NSString* title, NSArray* buttonsArray, id delegate)
{
	if ([buttonsArray count] >= 1)
    {
		UIActionSheet * sheet = [[UIActionSheet alloc]
								 initWithTitle:title
								 delegate:delegate
								 cancelButtonTitle:nil
								 destructiveButtonTitle:nil
								 otherButtonTitles:nil];
		for (int i=0; i<[buttonsArray count]; i++)
        {
			NSString * label = [buttonsArray objectAtIndex:i];
			[sheet addButtonWithTitle:label];
		}
		[sheet addButtonWithTitle:@"取消"];
		sheet.cancelButtonIndex = [buttonsArray count];
		return [sheet autorelease];
	}
	return nil;
}

//UIColor* TEXTCOLOR(NSString* colorHex)
//{
//	return [[JUUserDefaults instance] getColorByColorKey:[@"text_" stringByAppendingString:[colorHex lowercaseString]]];
//}
//
//UIColor* BACKCOLOR(NSString* colorHex)
//{
//	return [[JUUserDefaults instance] getColorByColorKey:[@"back_" stringByAppendingString:[colorHex lowercaseString]]];
//}

//UIColor* BORDERCOLOR(NSString* colorHex)
//{
//	return [[JUUserDefaults instance] getColorByColorKey:[@"border_" stringByAppendingString:[colorHex lowercaseString]]];
//}

void tPLLog(NSString *format, ...)
{
    
}
