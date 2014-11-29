//
//  TMMySotreViewController.h
//  TaoMao
//
//  Created by mac on 14-4-24.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "LTKViewController.h"

@interface TMMySotreViewController : LTKViewController<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
{
    UIView *view_bar;
    UITableView*_tableView;
    int touchID;
    BOOL _isTabbar;
    
    NSData              * data_imghead;
    
    UIImage                 * img_head;
    UrlImageButton                 * img_headSculpture;
    
    int touchID1;//最后选中的按钮的ID
    UIView * bgView;
    int cellIndexPath;
    int secondCellIndexPath;
    UIButton *button_tj;
    int   _xinhao_Height;
}
-(id)initWithTabbar:(BOOL)tabbar;
@end
