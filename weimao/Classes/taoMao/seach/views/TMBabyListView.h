//
//  TMBabyListView.h
//  TaoMao
//
//  Created by mac on 14-4-25.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMBabyListView : UITableView<UITableViewDataSource,UITableViewDelegate>
{
    NSArray * arrContent;
    int firstViewSelectTag;
    //一级分数数据
    NSMutableArray *_categoryNameList;
    NSMutableArray*_AreaList;
    //    NSMutableArray*_shopInfoTypeList;
    int selectTag;
    UIImageView * slideBg;
}

@end
