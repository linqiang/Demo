//
//  TMDetailView.h
//  TaoMao
//
//  Created by mac on 14-4-17.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol detailDelegate <NSObject>
- (void)detailSelectButtonIndex:(NSInteger)num;
@end

@interface TMDetailView : UIView
@property (nonatomic,assign) id<detailDelegate>LtTtbSDelegate;
@end
