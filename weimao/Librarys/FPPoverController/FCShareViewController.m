
    //
//  JURoomViewController.m
//  JiangnanUniversity
//
//  Copyright (c) 2013年 chen wei. All rights reserved.
//

#import "FCShareViewController.h"
#import "FCTabBarController.h"
@interface FCShareViewController ()

@end

@implementation FCShareViewController

-(id)initWithName:(NSArray*)aName {
    self =[super init];
    if (self) {
        arr_name = aName;

    }
    return self;

}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIView *viewBackground=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 80)];
    
    _tableView =[[UITableView alloc ]initWithFrame:CGRectMake(0, 0, 200,80) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource=self;
    [viewBackground addSubview: _tableView];
    [self.view addSubview:viewBackground];
    [viewBackground release];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
        // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
        // Return the number of rows in the section.
    return [arr_name count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        //    static NSString *CellIdentifier = @"Cell";
    NSString *CellIdentifier=[NSString stringWithFormat:@"section = %d,row=%d",indexPath.section,indexPath.row];
    UITableViewCell *cell =(UITableViewCell*) [_tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    if (cell==nil) {
        cell =[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
        // Configure the cell...
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
    
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    JUTabBarController *tabBarC=[[JUTabBarController alloc]initWithRoomId:@"" addWithRoomName:@""];
//    [self.navigationController pushViewController:tabBarC animated:YES];
//    [tabBarC release];
    
}
@end
