//
//  TMClassicViewController.h
//  TaoMao
//
//  Created by mac on 14-4-16.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "LTKViewController.h"

@interface TMClassicViewController : LTKViewController<UITableViewDataSource>
{
    
    MJRefreshHeader                 *_header;
    MJRefreshFooter                 *_footer;
    int                     _page;
    int                    _typeId;
    UIScrollView              *_scrollView;
    NSString               *_isFirst;
    
}

@property(nonatomic,retain)NSDictionary *data;
@property(nonatomic,retain)NSArray *marrayAll;

-(id)initWithWhere:(NSString*)isFirstClass;
@end
