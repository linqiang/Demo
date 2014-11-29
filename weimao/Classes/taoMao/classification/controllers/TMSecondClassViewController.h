//
//  TMSecondClassViewController.h
//  TaoMao
//
//  Created by mac on 14-4-16.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "LTKViewController.h"
#import "firstLevelMenu.h"
#import "secondLevelMenu.h"
@interface TMSecondClassViewController : LTKViewController<FirstLevelMenuSelectDelegate,SecondLevelMenuSelectDelegate>
{
    firstLevelMenu * firstLevelMenuView;//分类1
    secondLevelMenu * secondLevelMenuView;//分类2
    BOOL _isFirst;
    BOOL _isFoot;
    BOOL _isSecond;
    UIView*navigationBar;
    
    BOOL hasSecond;
    
    float firstViewHeight;
    NSString *naviTitle;
    NSString*_ID;

}
@property(nonatomic,retain)NSDictionary *data;
@property(nonatomic,retain)NSArray *marrayAll;
-(id)initWithTitle:(NSString*)title addWithID:(NSString*)ID;
@end
