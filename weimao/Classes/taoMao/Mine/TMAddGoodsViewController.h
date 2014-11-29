//
//  TMAddGoodsViewController.h
//  TaoMao
//
//  Created by mac on 14-4-24.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "LTKViewController.h"
#import "firstLevelMenu1.h"
#import "secondLevelMenu1.h"
#import "ELCImagePickerController.h"
#import "ELCAlbumPickerController.h"
#import "ELCAssetTablePicker.h"
#import "SwipeView.h"

@interface TMAddGoodsViewController : LTKViewController<UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UITextViewDelegate,UITextFieldDelegate,FirstLevelMenuSelectDelegate1,SecondLevelMenuSelectDelegate1,ELCImagePickerControllerDelegate,SwipeViewDelegate, SwipeViewDataSource>
{

    UIScrollView* _scrollViewBG;
//    UITableView            *_tableView;
    UIView              *view_bar;
    NSData              * data_imghead;
    
    UIImage                 * img_head;
    UrlImageButton                 * img_headSculpture;
    
    int touchID1;//最后选中的按钮的ID
    
    firstLevelMenu1 * firstLevelMenuView;//分类1
    secondLevelMenu1 * secondLevelMenuView;//分类2
    UIView * bgView;
    int cellIndexPath;
    int secondCellIndexPath;
    UIButton *button_tj;
    int   _xinhao_Height;
    NSMutableArray *arrayView;
    ELCImagePickerController *elcPicker;
    SwipeView *_swipeView;
    NSMutableArray *images;
    
    UILabel*label_xzfl;
}
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, retain) NSMutableArray *chosenImages;
@end
