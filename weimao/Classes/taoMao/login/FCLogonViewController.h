//
//  FCLogonViewController.h
//  Flower&Cake
//
//  Created by 呵呵 on 13-7-14.
//  Copyright (c) 2013年 呵呵. All rights reserved.
//

#import "LTKViewController.h"
//#import "RequestServer.h"
#import "XCTabBarView.h"
@interface FCLogonViewController : LTKViewController<UITextFieldDelegate,XCTabBarDelegate>
{

    UITextField                 *fieldName;
    UITextField                 *fieldPsw;
    NSString                    *_url;
    UITextField                    *fieldCheck;
    NSData                  *responseData;
    UIImageView                 *checkImage;
    UIImage                 *_image;
    UILabel                 *checkLabel;
    BOOL                    _isMine;
  
}
@property (nonatomic, assign) id<XCTabBarDelegate> delegate;
-(id)initWithBool:(BOOL)isMine;
@end
