//
//  TMBuildShopStoreViewController.h
//  TaoMao
//

//  Copyright (c) 2014年. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMBuildShopStoreViewController : LTKViewController<UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UITextViewDelegate,UITextFieldDelegate>
{

    UIScrollView            *_scrollView;
    UIView              *view_bar;
    NSData              * data_imghead;
    
    UIImage                 * img_head;
    UrlImageButton                 * img_headSculpture;
    
    int                 touchID1;//最后选中的按钮的ID
    UIButton                *btnBack;
    UIButton                *btnTJ;
}

@end
