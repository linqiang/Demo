//
//  TMMyClientOrdersViewController.h
//  TaoMao
//
//  Created by mac on 14-4-25.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "LTKViewController.h"

@interface TMMyClientOrdersViewController : LTKViewController<UITableViewDataSource,UITableViewDelegate>
{
    UIView *view_bar;
    UIButton*BtnItem1,*BtnItem2;
    UIImageView *tabBarArrow;
    UITableView*_tableView;
}


@end
