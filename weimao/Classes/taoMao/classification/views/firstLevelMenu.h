//
//  firstLevelMenu.h
//  testDoubleMenu
//
//  Created by Skyler on 13-9-5.
//  Copyright (c) 2013年 SK. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  FirstLevelMenuSelectDelegate<NSObject>

- (void)selectTheSpecificRow:(int)num addSelectTag:(int)tag;

@end


@interface firstLevelMenu : UITableView<UITableViewDataSource,UITableViewDelegate>
{
    NSArray * arrContent;
    id<FirstLevelMenuSelectDelegate>menuDelegate;
    int firstViewSelectTag;
        //一级分数数据
    NSMutableArray *_categoryNameList;
    NSMutableArray*_AreaList;
    int selectTag;
    UIImageView * slideBg;
}
@property(nonatomic,assign)id<FirstLevelMenuSelectDelegate>menuDelegate;

- (id)initWithFrame:(CGRect)frame Contents:(NSArray *)Contents;

@end
