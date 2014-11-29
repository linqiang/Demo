//
//  TMShopCarViewController.h
//  TaoMao
//
//  Created by mac on 14-4-18.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "LTKViewController.h"

@interface TMShopCarViewController1 : LTKViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UITextFieldDelegate>
{
    UITableView                     *_tableView;
    NSMutableArray                  *_marrayAll;
    NSMutableArray                  *_checkBtnArray;
    NSMutableArray                  *_checkBtnArray1;
    //    UITextField                     *numTextField;//添加数量
    BOOL                    _isTouch;
    BOOL                    _isCheck;
    //    UIButton                    *checkBtn;
    BOOL                    _isSelecedAll;
    UIWindow                * _window;//弹出视图
    BOOL                    _isDelete;
    NSMutableIndexSet                   *_set;
    UIView                  *_popView;
    NSMutableArray                  *deleteArray;//删除对象
    NSMutableArray                  *tempArray;
    //    int            btnTag;
    BOOL                    _isShare;
    BOOL                    _isAccount;
    NSString                    *_strings;
    NSString                    *_cellectings;
    NSMutableArray                  *_marrayProductid;

    NSMutableArray                  *_arrayPrice;
    
    NSDictionary                    *dic;
    NSMutableArray                      *arrayLabel;
    NSMutableArray                  *arrayTextFeild;
    BOOL                    _isfirst;
    BOOL                    _isPOP;
    NSInteger _index;
    
    UILabel *amoutLabel;
    
    UIView *view_bar;
//    BOOL _isTabbar;
    UIView *view_toolBar;
}
-(id)initWithTabbar:(BOOL)isTabbar;
@end
