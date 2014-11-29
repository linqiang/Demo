//
//  firstLevelMenu.m
//  testDoubleMenu
//
//  Created by Skyler on 13-9-5.
//  Copyright (c) 2013年 SK. All rights reserved.
//

#import "firstLevelMenu1.h"

@implementation firstLevelMenu1

@synthesize menuDelegate11;

- (id)initWithFrame:(CGRect)frame Contents:(NSArray *)Contents addSelectTag:(int)tag
{
    self = [super initWithFrame:frame style:UITableViewStylePlain];
    if (self)
    {
        selectTag=0;
//        selectTag= tag;
        arrContent = [[[NSArray alloc]initWithArray:Contents] retain];
        _AreaList=[[NSMutableArray alloc]init];
        _categoryNameList =[[NSMutableArray alloc]init];
        firstViewSelectTag=tag;

        if (tag==1)
        {
//            [_categoryNameList addObject:@"不限"];
        }else{
//            [_categoryNameList addObject:@"全部"];
        }

        for (int i =0; i<[arrContent count]; i++)
        {
            if (tag==1)
            {
//                [_categoryNameList addObject:[NSString stringWithFormat:@"%@",[[Contents objectAtIndex:i]name]]];

            }else{
//                [_categoryNameList addObject:[[Contents objectAtIndex:i]name]];
            }
            
            [_categoryNameList addObject:[Contents objectAtIndex:i]];

        }

        self.delegate = self;
        self.dataSource = self;
        self.backgroundView=nil;
        self.scrollEnabled=YES;
        self.showsVerticalScrollIndicator = NO;
        self.separatorColor=[UIColor clearColor];
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.contentSize=CGSizeMake(0, 300);

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
    return 40;
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
        cell.textLabel.text=[NSString stringWithFormat:@"%@",[arrContent objectAtIndex:indexPath.row]];
        if (indexPath.row==0)
        {
            cell.backgroundColor=[UIColor whiteColor];
//            slideBg=[[UIImageView alloc]init];
//            slideBg.frame = CGRectMake(78, 0, 2, 50);
//            slideBg.backgroundColor=hongShe;
//            [cell addSubview:slideBg];
            cell.textLabel.textColor=hongShe;
            cell.textLabel.font=[UIFont systemFontOfSize:18];
   
        }else{

            cell.textLabel.textColor=[UIColor grayColor];
            cell.textLabel.font=[UIFont systemFontOfSize:15];
       
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
    cell.textLabel.font=[UIFont systemFontOfSize:15];
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
    [[NSUserDefaults standardUserDefaults]setObject:cell.textLabel.text forKey:@"fenglei"];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    slideBg.frame = CGRectMake(78,0, 2, 50);
    [cell addSubview:slideBg];
    [UIView commitAnimations];

    cell.textLabel.textColor=hongShe;
    cell.textLabel.font=[UIFont systemFontOfSize:18];
    cell.backgroundColor=[UIColor whiteColor];
    if (indexPath.row!=0)
    {
        UITableViewCell*cell=(UITableViewCell*)[self viewWithTag:1000];
        cell.textLabel.textColor=[UIColor grayColor];
        cell.textLabel.font=[UIFont systemFontOfSize:15];
        cell.backgroundColor=[UIColor colorWithRed:.95 green:.95 blue:.95 alpha:1.0];
    }else{

       
   }
    [self.menuDelegate11 selectTheSpecificRow:indexPath.row addSelectTag:selectTag];

//    [self.superview removeFromSuperview];
}



@end
