//
//  FCTabBarController.h
//  fc
//
//  Created by  on 13-4-17.
//  Copyright (c) 2013年 chen wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTabBar.h"
#import "ZSYPopoverListView.h"


@protocol FCTabBarDelegate <NSObject>

-(BOOL)tabBarArrowHidden:(BOOL)hidden;

@end
@interface FCTabBarController : CustomTabBar<ZSYPopoverListDatasource,ZSYPopoverListDelegate,UITabBarControllerDelegate,FCTabBarDelegate,UITabBarDelegate>
{
    NSArray                     *  room_count;
    NSString                    *room_name;
    NSString                    *room_id;
    NSString                    *student_id;
    bool                    itmeSelect;
    Reachability *hostRech;

}

@property (nonatomic, retain) UIImageView                   * tabBarArrow;
@property(nonatomic,retain)NSMutableArray       *daoHangArray;

@end
