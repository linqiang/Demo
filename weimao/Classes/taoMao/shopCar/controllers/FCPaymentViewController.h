//
//  FCPaymentViewController.h
//  Flower&Cake
//
//  Created by 呵呵 on 13-7-13.
//  Copyright (c) 2013年 呵呵. All rights reserved.
//


#import "FCShoppingCell.h"
@interface FCPaymentViewController :LTKViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView                 *_tableView;
    NSMutableArray                  *_marrayTitle;
//    UIButton                    *checkBtn;
    NSInteger                   _index;
    BOOL _isPop;
    UIView *view_bar;
}


@end
