//
//  firstLevelMenu.m
//  testDoubleMenu
//
//  Created by Skyler on 13-9-5.
//  Copyright (c) 2013年 SK. All rights reserved.
//

#import "firstLevelMenu.h"

@implementation firstLevelMenu

@synthesize menuDelegate;

- (id)initWithFrame:(CGRect)frame Contents:(NSArray *)Contents
{
    self = [super initWithFrame:frame style:UITableViewStylePlain];
    if (self)
    {
        selectTag= 0;
        arrContent = [[NSArray alloc]initWithArray:Contents];
        _AreaList=[[NSMutableArray alloc]init];
        _categoryNameList =[[NSMutableArray alloc]init];

        for (int i =0; i<[arrContent count]; i++)
        {
            [_categoryNameList addObject:[Contents objectAtIndex:i]];

        }
        NSLog(@"%fdddd%f",frame.origin.y,CGRectGetHeight(frame));
        
        CGRectGetHeight(frame);
        self.delegate = self;
        self.dataSource = self;
        self.backgroundView=nil;
        self.frame=frame;
        
        if ([[[UIDevice currentDevice]systemVersion]floatValue]>6.1)
        {
            self.contentOffset=CGPointMake(0, 0);
        }else{
            self.contentOffset=CGPointMake(0, 0);
        
        }
        
        self.showsVerticalScrollIndicator = NO;
        self.separatorColor=[UIColor clearColor];
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
       
    }
    return self;
}

- (void)dealloc
{
    [arrContent release];
    [super dealloc];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrContent.count;
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
    
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType=UITableViewCellAccessoryNone;
        cell.backgroundColor=[UIColor colorWithRed:.95 green:.95 blue:.95 alpha:1.0];
        cell.userInteractionEnabled=YES;
        cell.textLabel.text=[[arrContent objectAtIndex:indexPath.row]objectForKey:@"name"];
        cell.textLabel.frame=CGRectMake(5, 50/2-20/2, cell.frame.size.width, 20);
        
        if (indexPath.row==selectTag)
        {
            cell.backgroundColor=[UIColor whiteColor];
            slideBg=[[UIImageView alloc]init];
            slideBg.frame = CGRectMake(78, 0, 2, 50);
            slideBg.backgroundColor=hongShe;
            [cell addSubview:slideBg];
            cell.textLabel.textColor=hongShe;
            cell.textLabel.font=[UIFont systemFontOfSize:14];
   
       
        }else{
        
            cell.textLabel.textColor=[UIColor grayColor];
            cell.textLabel.font=[UIFont systemFontOfSize:12];
        
        }
        cell.tag=1000+indexPath.row;
    }

    return cell;
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIImageView *imageV=(UIImageView*)[ self viewWithTag:10000+indexPath.row];
    imageV.backgroundColor=[UIColor clearColor];
    imageV.image=BundleImage(@"bg_01_n_.png");

    UITableViewCell*cell=(UITableViewCell*)[self viewWithTag:indexPath.row+1000];
    cell.textLabel.textColor=[UIColor grayColor];
    cell.textLabel.font=[UIFont systemFontOfSize:12];
    cell.backgroundColor=[UIColor colorWithRed:.95 green:.95 blue:.95 alpha:1.0];
    
    if (indexPath.row==0)
    {
        cell.textLabel.textColor=[UIColor grayColor];
        cell.backgroundColor=[UIColor colorWithRed:.95 green:.95 blue:.95 alpha:1.0];
        
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

   
        selectTag=indexPath.row;
        UITableViewCell*cell=(UITableViewCell*)[self viewWithTag:indexPath.row+1000];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];
        slideBg.frame = CGRectMake(78,0, 2, 50);
        [cell addSubview:slideBg];
        [UIView commitAnimations];
        
        cell.textLabel.textColor=hongShe;
        cell.textLabel.font=[UIFont systemFontOfSize:14];
        cell.backgroundColor=[UIColor whiteColor];
        if (indexPath.row!=0)
        {
            UITableViewCell*cell=(UITableViewCell*)[self viewWithTag:1000];
            cell.textLabel.textColor=[UIColor grayColor];
            cell.textLabel.font=[UIFont systemFontOfSize:12];
            cell.backgroundColor=[UIColor colorWithRed:.95 green:.95 blue:.95 alpha:1.0];
        }else{
            
            
        }

    [self.menuDelegate selectTheSpecificRow:indexPath.row addSelectTag:selectTag];
}



@end
