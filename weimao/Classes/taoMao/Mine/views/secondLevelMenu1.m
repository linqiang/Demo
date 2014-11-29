//
//  firstLevelMenu.m
//  testDoubleMenu
//
//  Created by Skyler on 13-9-5.
//  Copyright (c) 2013年 SK. All rights reserved.
//

#import "secondLevelMenu1.h"

@implementation secondLevelMenu1

@synthesize smenuDelegate1;

- (id)initWithFrame:(CGRect)frame Contents:(NSArray *)Contents
{
    self = [super initWithFrame:frame style:UITableViewStylePlain];
    if (self)
    {
        arrContent = [[NSArray alloc]initWithArray:Contents];
        self.delegate = self;
        self.dataSource = self;
        self.showsVerticalScrollIndicator = NO;
        self.separatorColor=[UIColor clearColor];
        self.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0];
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return self;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 37;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrContent count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    
    UITableViewCell *cell = nil;
    
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier: SimpleTableIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.selectedBackgroundView = [[[UIView alloc] initWithFrame:cell.frame] autorelease];
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0];
        cell.backgroundColor=[UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0];
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.text = @"345";
    cell.imageView.image = nil;
    cell.textLabel.textAlignment=1;
    cell.textLabel.backgroundColor=[UIColor clearColor];
    //    cell.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    cell.textLabel.textColor=[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if ([arrContent count]>0)
//    {
        [self.smenuDelegate1 secondLevelMenuselectTheSpecificRow:indexPath.row addName:[arrContent objectAtIndex:indexPath.row]];
    [self.superview removeFromSuperview];
//    }
    
}
@end
