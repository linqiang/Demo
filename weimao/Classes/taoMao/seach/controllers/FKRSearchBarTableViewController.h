//
//  FKRSearchBarTableViewController.h
//  TableViewSearchBar
//
//  Created by Fabian Kreiser on 10.02.13.
//  Copyright (c) 2013 Fabian Kreiser. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FKRSearchBarTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate> {
    UIView  *_view1;
    UIButton*BtnItem1,*BtnItem2;
    UIImageView *tabBarArrow;
    
    BOOL _isBaobei;
    
}

- (id)initWithSectionIndexes:(BOOL)showSectionIndexes;

- (void)scrollTableViewToSearchBarAnimated:(BOOL)animated; // Implemented by the subclasses

@property(nonatomic, assign, readonly) BOOL showSectionIndexes;

@property(nonatomic, strong, readonly) UITableView *tableView;
@property(nonatomic, strong, readonly) UISearchBar *searchBar;

@end