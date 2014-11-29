//
//  TMThirdClassViewController.h
//  TaoMao
//
//  Created by mac on 14-4-17.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "LTKViewController.h"

@interface TMThirdClassViewController : LTKViewController<UIScrollViewDelegate>
{
    UITableView *_tableView;
    UIImageView*  tabBarArrow;//上部桔红线条
    UIButton*BtnItem1; //上部三个按钮
    UIButton*BtnItem2;
    UIButton*BtnItem3;
    
    UIView*navigationBar;
    UIScrollView *_scrollView;
  
}

@end
