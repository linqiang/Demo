//
//  NSTNoticeViewController.h
//  NewsTextModel
//
//  Created by mac on 14-3-21.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "LTKViewController.h"
#import "MJRefresh.h"
#import "EScrollerView.h"
@interface NSTNoticeViewController : LTKViewController<UITableViewDelegate,UITableViewDataSource,MJRefreshBaseViewDelegate,EScrollerViewDelegate>
{

    UITableView *_tableView;
    MJRefreshHeaderView                 *_header;
    MJRefreshFooterView                 *_footer;
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
