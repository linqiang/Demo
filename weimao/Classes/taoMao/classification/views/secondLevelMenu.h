 //
//  firstLevelMenu.h
//  testDoubleMenu
//
//  Created by Skyler on 13-9-5.
//  Copyright (c) 2013年 SK. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol  SecondLevelMenuSelectDelegate<NSObject>

- (void)secondLevelMenuselectTheSpecificRow:(int)num  addName:(NSString*)name;

@end


@interface secondLevelMenu : UIScrollView<UIScrollViewDelegate>
{
    NSArray * arrContent;
    id<SecondLevelMenuSelectDelegate>smenuDelegate;
    CGRect   popupRect;
	CGRect   hideRect;
    BOOL isPopup;
    NSString *_class_id;
    NSMutableDictionary*marrayall;
}
@property(nonatomic,assign)id<SecondLevelMenuSelectDelegate>smenuDelegate;
- (id)initWithFrame:(CGRect)frame Contents:(NSArray *)Contents  addWithClassicID:(NSString*)classID;
- (void)hide;
-(void)popup;
-(void)hideFrame;
@end
