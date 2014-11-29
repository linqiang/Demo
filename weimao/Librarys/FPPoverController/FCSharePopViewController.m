//
//  RowTableView.m
//  //
//  Created by user on 12-6-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FCSharePopViewController.h"
//#import "UIColor+ColorWithHex.h"
//#import "SQLiteManager.h"
@interface FCSharePopViewController ()

@end

@implementation FCSharePopViewController
@synthesize tableDelegate,selectRow;

- (id)initWithStyle:(UITableViewStyle)style addArray:(NSArray *)array andCurrentRoomName:(NSString*)roomName
{
    self = [super init];
    if (self) {
        arrayoflist= [[NSArray alloc]initWithArray: array ];
        room = [NSString stringWithString:roomName];
        }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    self.title = @"分享";
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController.navigationBar setHidden:YES];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayoflist count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
     cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }

    UIView *tempView = [[[UIView alloc] init] autorelease];
    [cell setBackgroundView:tempView];
    [cell setBackgroundColor:[UIColor clearColor]];
    cell.textLabel.text= [arrayoflist objectAtIndex:indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:12.0f];
    if ([room isEqualToString:[arrayoflist objectAtIndex:indexPath.row]]) {
        cell.textLabel.textColor = [UIColor greenColor];
    } else {
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    cell.textLabel.numberOfLines=0;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.textLabel.textAlignment=0;
    cell.imageView.image=BundleImage(@"logo.png");
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectRow = [NSNumber numberWithInt:indexPath.row];
    [self.tableDelegate tableDidSelected];
//    cell.textLabel.textColor=[UIColor redColor];
//    cell.backgroundColor=[UIColor grayColor];
}
-(void)dealloc
{

    [arrayoflist release];
    [super dealloc];
}
@end
