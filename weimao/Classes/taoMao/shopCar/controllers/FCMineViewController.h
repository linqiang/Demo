//
//  FCMineViewController.h
//  Flower&Cake
//
//  Created by 呵呵 on 13-7-3.
//  Copyright (c) 2013年 呵呵. All rights reserved.
//


#import "QBPopupMenu.h"
//#import "listTitleDisplayTb.h"
@interface FCMineViewController : LTKViewController<UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
{
    UITextField * tf_userName;
    
    UITextField * tf_waitToPay;
    UITextField * tf_waitToSend;
    UITextField * tf_waitToGet;
    UITextField * tf_waitToComment;
    UIImageView * img_headSculpture;
    
    
}
@end
