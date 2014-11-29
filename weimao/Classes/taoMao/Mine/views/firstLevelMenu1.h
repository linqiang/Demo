//
//  firstLevelMenu.h
//  testDoubleMenu
//
//  Created by Skyler on 13-9-5.
//  Copyright (c) 2013年 SK. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  FirstLevelMenuSelectDelegate1<NSObject>

- (void)selectTheSpecificRow:(int)num addSelectTag:(int)tag;

@end


@interface firstLevelMenu1 : UITableView<UITableViewDataSource,UITableViewDelegate>
{
    NSArray * arrContent;
    id<FirstLevelMenuSelectDelegate1>menuDelegate11;
    int firstViewSelectTag;
        //一级分数数据
    NSMutableArray *_categoryNameList;
    NSMutableArray*_AreaList;
//    NSMutableArray*_shopInfoTypeList;
    int selectTag;
    UIImageView * slideBg;
}
@property(nonatomic,assign)id<FirstLevelMenuSelectDelegate1>menuDelegate11;

- (id)initWithFrame:(CGRect)frame Contents:(NSArray *)Contents addSelectTag:(int)tag;

@end
