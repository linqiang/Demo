//
//  TMCommentListViewController.h
//  TaoMao
//
//  Created by mac on 14-4-21.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMCommentListViewController : LTKViewController<UITableViewDelegate,UITableViewDataSource,EScrollerViewDelegate>
{
    
    UITableView *_tableView;
    MJRefreshHeader                 *_header;
    MJRefreshFooter                 *_footer;
    int                     _page;
    UIView *naviBar;
}

@property(nonatomic,retain)NSDictionary *data;
@property(nonatomic,retain)NSMutableArray *_marray_updateDate;//更新时间
@property(nonatomic,retain)NSMutableArray *_mainHead_marray;//订标题
@property(nonatomic,retain)NSMutableArray *_subHead_marray;//副标题
@property(nonatomic,retain)NSMutableArray *_createDate_marray;//创建时间
@property(nonatomic,retain)NSMutableArray *_filePath_marray;// 图片路径
@property(nonatomic,retain)NSMutableArray *_scrol_marray;//焦点数组
@property(nonatomic,retain)NSMutableArray *newsArray;

@end
