//
//  FKRDefaultSearchBarTableViewController.m
//  TableViewSearchBar
//
//  Created by Fabian Kreiser on 10.02.13.
//  Copyright (c) 2013 Fabian Kreiser. All rights reserved.
//

#import "FKRDefaultSearchBarTableViewController.h"

@implementation FKRDefaultSearchBarTableViewController

#pragma mark - Initializer

- (id)initWithSectionIndexes:(BOOL)showSectionIndexes
{
    if ((self = [super initWithSectionIndexes:showSectionIndexes])) {
        self.title = @"Default Search Bar";
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /*
     Default behavior:
     The search bar scrolls along with the table view.
    */
    
    self.tableView.tableHeaderView = self.searchBar;
    
    // The search bar is hidden when the view becomes visible the first time
//    self.tableView.contentOffset = CGPointMake(0, CGRectGetHeight(self.searchBar.bounds));
}

- (void)scrollTableViewToSearchBarAnimated:(BOOL)animated
{
    [self.tableView scrollRectToVisible:self.searchBar.frame animated:animated];
}

@end