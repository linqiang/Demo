//
//  RowTableView.h
//  点逸通讯录
//
//  Created by user on 12-6-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol rowTableDelegate;
@interface FCSharePopViewController : UITableViewController{
    id <rowTableDelegate> tableDelegate;
    NSNumber *selectRow;
    NSArray * arrayoflist;
    int _height;
    UITableViewCell *cell;
    NSString *room;
}
@property (nonatomic, assign) id <rowTableDelegate> tableDelegate;
@property(nonatomic, retain)NSNumber* selectRow;
- (id)initWithStyle:(UITableViewStyle)style addArray:(NSArray *)array  andCurrentRoomName:(NSString*)roomName;
@end
@protocol rowTableDelegate <NSObject>
- (void)tableDidSelected;
@end
