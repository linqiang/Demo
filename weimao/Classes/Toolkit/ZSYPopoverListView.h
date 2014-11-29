//
//  ZSYPopoverListView.h
//  MyCustomTableViewForSelected
//
//  Created by Zhu Shouyu on 6/2/13.
//  Copyright (c) 2013 zhu shouyu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ZSYPopoverListViewButtonBlock)();

@class ZSYPopoverListView;
@protocol ZSYPopoverListDatasource <NSObject>

- (NSInteger)popoverListView:(ZSYPopoverListView *)tableView numberOfRowsInSection:(NSInteger)section;

- (UITableViewCell *)popoverListView:(ZSYPopoverListView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol ZSYPopoverListDelegate <NSObject>
- (void)popoverListView:(ZSYPopoverListView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)popoverListView:(ZSYPopoverListView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0);
@end

@interface ZSYPopoverListView : UIView<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) id <ZSYPopoverListDelegate>delegate;
@property (nonatomic, retain) id <ZSYPopoverListDatasource>datasource;

@property (nonatomic, retain) UILabel *titleName;

//展示界面
- (void)show;

//消失界面
- (void)dismiss;

//列表cell的重用
- (id)dequeueReusablePopoverCellWithIdentifier:(NSString *)identifier;

- (UITableViewCell *)popoverCellForRowAtIndexPath:(NSIndexPath *)indexPath;            // returns nil if cell is not visible or index path is out of

//设置确定按钮的标题，如果不设置的话，不显示确定按钮
- (void)setDoneButtonWithTitle:(NSString *)aTitle block:(ZSYPopoverListViewButtonBlock)block;

//设置取消按钮的标题，不设置，按钮不显示
- (void)setCancelButtonTitle:(NSString *)aTitle block:(ZSYPopoverListViewButtonBlock)block;

//选中的列表元素
- (NSIndexPath *)indexPathForSelectedRow;
@end

