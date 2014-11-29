//
//  FKRSearchBarTableViewController.m
//  TableViewSearchBar
//
//  Created by Fabian Kreiser on 10.02.13.
//  Copyright (c) 2013 Fabian Kreiser. All rights reserved.
//

#import "FKRSearchBarTableViewController.h"

static NSString * const kFKRSearchBarTableViewControllerDefaultTableViewCellIdentifier = @"kFKRSearchBarTableViewControllerDefaultTableViewCellIdentifier";

@interface FKRSearchBarTableViewController () {
    
}

@property(nonatomic, copy) NSArray *famousPersons;
@property(nonatomic, copy) NSArray *filteredPersons;
@property(nonatomic, copy) NSArray *sections;

@property(nonatomic, strong, readwrite) UITableView *tableView;
@property(nonatomic, strong, readwrite) UISearchBar *searchBar;

@property(nonatomic, strong) UISearchDisplayController *strongSearchDisplayController; // UIViewController doesn't retain the search display controller if it's created programmatically: http://openradar.appspot.com/10254897

@end

@implementation FKRSearchBarTableViewController

#pragma mark - Initializer

- (id)initWithSectionIndexes:(BOOL)showSectionIndexes
{
    if ((self = [super initWithNibName:nil bundle:nil])) {
        self.title = @"Search Bar";
        
        _showSectionIndexes = showSectionIndexes;
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Top100FamousPersons" ofType:@"plist"];
        _famousPersons = [[NSArray alloc] initWithContentsOfFile:path];
        
        if (showSectionIndexes) {
            UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
            
            NSMutableArray *unsortedSections = [[NSMutableArray alloc] initWithCapacity:[[collation sectionTitles] count]];
            for (NSUInteger i = 0; i < [[collation sectionTitles] count]; i++) {
                [unsortedSections addObject:[NSMutableArray array]];
            }
            
            for (NSString *personName in self.famousPersons) {
                NSInteger index = [collation sectionForObject:personName collationStringSelector:@selector(description)];
                [[unsortedSections objectAtIndex:index] addObject:personName];
            }
            
            NSMutableArray *sortedSections = [[NSMutableArray alloc] initWithCapacity:unsortedSections.count];
            for (NSMutableArray *section in unsortedSections) {
                [sortedSections addObject:[collation sortedArrayFromArray:section collationStringSelector:@selector(description)]];
            }
            
            self.sections = sortedSections;
        }
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _isBaobei=YES;
    self.navigationController.navigationBar.barTintColor=hongShe;
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    

    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
//    self.tableView.scrollEnabled=NO;
    [self.view addSubview:self.tableView];
//    _view1=  [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
//    _view1.backgroundColor=[UIColor whiteColor];
//   [self.tableView addSubview:_view1];
    self.view.backgroundColor=[UIColor whiteColor];
//    [self.view addSubview:self.searchBar];
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    self.searchBar.placeholder = @"搜索你喜欢的宝贝";
    self.searchBar.delegate = self;
    
    self.searchBar.barStyle=UIBarStyleDefault;
    self.searchBar.barTintColor=hui8;
    [self.searchBar sizeToFit];
    
    self.strongSearchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    self.searchDisplayController.searchResultsDataSource = self;
    self.searchDisplayController.searchResultsDelegate = self;
    self.searchDisplayController.delegate = self;
    
    UIView*view12=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 160, 40)];
    view12.backgroundColor=[UIColor redColor];
    [self.tableView.tableHeaderView addSubview:view12];
    self.tableView.tableHeaderView.frame=CGRectMake(0, self.searchBar.frame.size.height, 320, 40) ;
    [self.tableView addSubview:self.tableView.tableHeaderView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (animated) {
        [self.tableView flashScrollIndicators];
    }
}
//三个按钮事件
-(void)change:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    [UIView beginAnimations:Nil context:Nil];
    [UIView setAnimationDuration:0.2];
    CGRect frame=tabBarArrow.frame;
    frame.origin.x=[self horizontalLocationFor:btn.tag-100];
    tabBarArrow.frame=frame;
    [UIView commitAnimations];
    
    if (btn.tag==100)
    {
        [BtnItem1 setTitleColor:[UIColor colorWithRed:1.0 green:.23 blue:.49 alpha:1.0] forState:0]   ;
        [BtnItem2 setTitleColor:[UIColor colorWithRed:.5 green:.5 blue:.5 alpha:1.0] forState:0]   ;
        BtnItem1.backgroundColor=[UIColor whiteColor];
        BtnItem2.backgroundColor=[UIColor colorWithRed:.95 green:.95 blue:.95 alpha:1.0];
        _isBaobei=YES;
    }else if(btn.tag==101)
    {
        [BtnItem2 setTitleColor:[UIColor colorWithRed:1.0 green:.23 blue:.49 alpha:1.0] forState:0]   ;
        [BtnItem1 setTitleColor:[UIColor colorWithRed:.5 green:.5 blue:.5 alpha:1.0] forState:0]   ;
        BtnItem1.backgroundColor=[UIColor colorWithRed:.95 green:.95 blue:.95 alpha:1.0];
        BtnItem2.backgroundColor=[UIColor whiteColor];
        _isBaobei=NO;
    }
    
}
- (CGFloat) horizontalLocationFor:(NSUInteger)tabIndex
{
    CGFloat tabItemWidth = self.view.frame.size.width/2;
    return (tabIndex * tabItemWidth);
}
- (void)scrollTableViewToSearchBarAnimated:(BOOL)animated
{
    NSAssert(YES, @"This method should be handled by a subclass!");
}

#pragma mark - TableView Delegate and DataSource
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
//    if (section==0) {
        UIView*imageView=[[UIView alloc]initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height, self.view.frame.size.width,40 )];
        imageView.backgroundColor=[UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1.0];
        imageView.userInteractionEnabled=YES;
    
        
        
        BtnItem1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [BtnItem1 setFrame:CGRectMake(0, 0, 320/2, 35)];
        BtnItem1.exclusiveTouch=YES;
        BtnItem1.tag = 100;
        [BtnItem1 setTitle:@"待付款" forState:0];
        BtnItem1.titleLabel.font=[UIFont systemFontOfSize:14];
        BtnItem1.titleLabel.textAlignment=1;
        BtnItem1.titleLabel.textColor= hongShe;
 
        BtnItem1.layer.borderColor=[UIColor colorWithRed:.95 green:.95 blue:.95 alpha:1.0].CGColor;
        BtnItem1.backgroundColor=[UIColor whiteColor];
        [BtnItem1 addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:BtnItem1];
        
        
        BtnItem2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [BtnItem2 setFrame:CGRectMake(320/2*1+1, 0, 320/2, 35)];
        BtnItem2.exclusiveTouch=YES;
        BtnItem2.tag = 101;
        BtnItem2.backgroundColor=[UIColor colorWithRed:.95 green:.95 blue:.95 alpha:1.0];
        [BtnItem2 setTitle:@"己完成" forState:0];
        [BtnItem2 setTitleColor:[UIColor colorWithRed:.5 green:.5 blue:.5 alpha:1.0] forState:0];
        BtnItem2.titleLabel.font=[UIFont systemFontOfSize:14];
        [BtnItem2 addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:BtnItem2];
    
        
        tabBarArrow=[[UIImageView alloc]init];
        tabBarArrow.frame = CGRectMake([self horizontalLocationFor:0], 34, 320/2, 2);
        tabBarArrow.image=BundleImage(@"line_p_.png");
        [imageView addSubview:tabBarArrow];
//        [tabBarArrow release];
//        return imageView;
//    }
    return imageView;
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (tableView == self.tableView && self.showSectionIndexes) {
        return [[NSArray arrayWithObject:UITableViewIndexSearch] arrayByAddingObjectsFromArray:[[UILocalizedIndexedCollation currentCollation] sectionIndexTitles]];
    } else {
        return nil;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    
    if (tableView == self.tableView && self.showSectionIndexes) {
        if ([[self.sections objectAtIndex:section] count] > 0) {
            return [[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:section];
        } else {
            return nil;
        }
    } else {
        return nil;
    }
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if ([title isEqualToString:UITableViewIndexSearch]) {
        [self scrollTableViewToSearchBarAnimated:NO];
        return NSNotFound;
    } else {
        return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index] - 1; // -1 because we add the search symbol
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.tableView) {
        if (self.showSectionIndexes) {
            return self.sections.count;
        } else {
            return 1;
        }
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        if (self.showSectionIndexes) {
            return [[self.sections objectAtIndex:section] count];
        } else {
            return self.famousPersons.count;
        }
    } else {
        return self.filteredPersons.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kFKRSearchBarTableViewControllerDefaultTableViewCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kFKRSearchBarTableViewControllerDefaultTableViewCellIdentifier];
    }
    
    if (tableView == self.tableView&&_isBaobei==YES) {
        if (self.showSectionIndexes) {
            cell.textLabel.text = [[self.sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        } else {
            cell.textLabel.text = [self.famousPersons objectAtIndex:indexPath.row];
        }
    } else {
        
        
        UIImageView *imageP=[[UIImageView alloc]initWithFrame:CGRectMake(cell.frame.size.width-44, (90-70)/2, 44, 70)];
        imageP.image=BundleImage(@"bt_04_J.png");
        [cell addSubview:imageP];
        
        
        UrlImageView *headImg=[[UrlImageView alloc]initWithFrame:CGRectMake(90/2-60/2, 15, 60, 60)];
        headImg.image=BundleImage(@"df_03_.png");
        [cell addSubview:headImg];
        headImg.backgroundColor=[UIColor clearColor];
        
        UrlImageView *headImg1=[[UrlImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
        headImg1.image=BundleImage(@"bg_01_.png");
        [headImg addSubview:headImg1];
        headImg1.backgroundColor=[UIColor clearColor];
        
        UrlImageView*imgView=[[UrlImageView alloc]initWithFrame:CGRectMake(20, 10, 56,56)];

        
        //title店铺名
        UILabel*title=[[UILabel alloc]initWithFrame:CGRectMake(imgView.frame.size.width+imgView.frame.origin.y+20, 25, 100, 20)];
        title.backgroundColor=[UIColor clearColor];
        title.textAlignment=0;
        title.text=@"魅典幻镜";
        title.textColor=[UIColor colorWithRed:.2 green:.2 blue:.2 alpha:1.0];
        title.font=[UIFont systemFontOfSize:14];
        [cell addSubview:title];
        
        //店铺介绍
        UILabel*title1=[[UILabel alloc]initWithFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+title.frame.size.height+5, 60, 20)];
        title1.textAlignment=0;
        title1.tag=1000+indexPath.row;
        title1.font=[UIFont systemFontOfSize:12];
        title1.textColor=[UIColor colorWithRed:.2 green:.2 blue:.2 alpha:1.0];
        title1.text=@"店铺介绍：";
        title1.backgroundColor=[UIColor clearColor];
        [cell addSubview:title1];
        
        //店铺介绍详情
        UILabel*title2=[[UILabel alloc]initWithFrame:CGRectMake(title1.frame.origin.x+title1.frame.size.width, title1.frame.origin.y, 140, 20)];
        title2.textAlignment=0;
        title2.tag=1000+indexPath.row;
        title2.font=[UIFont systemFontOfSize:12];
        title2.textColor=[UIColor colorWithRed:.8 green:.8 blue:.8 alpha:1.0];
        title2.text=@"欧美 混搭 居家 传媒 中性 居家 传媒 中性";
        title2.numberOfLines=0;
        title2.backgroundColor=[UIColor clearColor];
        [cell addSubview:title2];
        
        CGRect cellFrame = [cell frame];
        cellFrame.origin=CGPointMake(5, 5);
        cellFrame.size.width=320;
        cellFrame.size.height=imgView.frame.size.height+10;
        [cell setFrame:cellFrame];
        [imgView release];
        
        //        line@2x
        UIImageView *line=[[UIImageView alloc]initWithFrame:CGRectMake(0, 89, 320, 1)];
        line.image=BundleImage(@"gwc_line_.png");
        line.backgroundColor=[UIColor colorWithRed:.5 green:.5 blue:.5 alpha:1.0];
        [cell addSubview:line];
        [line release];

        cell.textLabel.text = [self.filteredPersons objectAtIndex:indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Search Delegate

- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
    self.navigationController.toolbar.backgroundColor=hongShe;
    self.filteredPersons = self.famousPersons;
    self.searchBar.barTintColor=hongShe;
//     self.navigationController.navigationBar.barTintColor=[UIColor clearColor];
    
//    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
//    self.tableView.dataSource = self;
//    self.tableView.delegate = self;
//    
//    [self.view addSubview:self.tableView];
}

- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
{
    self.filteredPersons = nil;
//    self.tableView.scrollEnabled=YES;
    [_view1 removeFromSuperview];
    self.searchBar.barTintColor=hui8;
     self.navigationController.navigationBar.barTintColor=hongShe;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    self.filteredPersons = [self.filteredPersons filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF contains[cd] %@", searchString]];
    
    return YES;
}

@end