//
//  firstLevelMenu.h
//  testDoubleMenu
//
//  Created by Skyler on 13-9-5.
//  Copyright (c) 2013年 SK. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  SecondLevelMenuSelectDelegate1<NSObject>

- (void)secondLevelMenuselectTheSpecificRow:(int)num  addName:(NSString*)name;

@end


@interface secondLevelMenu1 : UITableView<UITableViewDataSource,UITableViewDelegate>
{
    NSArray * arrContent;
    id<SecondLevelMenuSelectDelegate1>smenuDelegate1;
    CGRect   popupRect;
	CGRect   hideRect;
    BOOL isPopup;
}
@property(nonatomic,assign)id<SecondLevelMenuSelectDelegate1>smenuDelegate1;
- (id)initWithFrame:(CGRect)frame Contents:(NSArray *)Contents;
- (void)hide;
-(void)popup;
-(void)hideFrame;
@end
