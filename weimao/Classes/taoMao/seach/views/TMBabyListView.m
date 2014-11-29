//
//  TMBabyListView.m
//  TaoMao
//
//  Created by mac on 14-4-25.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "TMBabyListView.h"
#import "TMGoodsDetailsViewController.h"

@implementation TMBabyListView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:UITableViewStylePlain];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundView=nil;
        self.scrollEnabled=NO;
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
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
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
        cell.backgroundColor=[UIColor clearColor];
        cell.userInteractionEnabled=YES;
//        cell.textLabel.text=@"123";
//        if (indexPath.row==0)
//        {
//            cell.backgroundColor=[UIColor whiteColor];
//            slideBg=[[UIImageView alloc]init];
//            slideBg.frame = CGRectMake(78, 0, 2, 50);
//            slideBg.backgroundColor=hongShe;
//            [cell addSubview:slideBg];
//            cell.textLabel.textColor=hongShe;
//            cell.textLabel.font=[UIFont systemFontOfSize:18];
//            
//        }else{
//            
//            cell.textLabel.textColor=[UIColor grayColor];
//            cell.textLabel.font=[UIFont systemFontOfSize:15];
//            
//        }
        
        
        cell.tag=1000+indexPath.row;
        
        
//        line_01_@2x
        UIImageView *line=[[UIImageView alloc]initWithFrame:CGRectMake(0, 39, 320, 1)];
        line.image=BundleImage(@"line_01_.png");
        [cell addSubview:line];
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
    
//    [self removeFromSuperview];
    TMGoodsDetailsViewController *goods=[[TMGoodsDetailsViewController alloc]init];
    TMAppDelegate *delegate=(TMAppDelegate*)[UIApplication sharedApplication].delegate;
    [delegate.navigationController pushViewController:goods animated:YES];

//    [self removeFromSuperview];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    
    
}
- (void)scrollViewWillBeginDragging:(TMBabyListView *)scrollView{
    
    UITextField*tf=(UITextField*)[self.superview viewWithTag:-19];
   [tf resignFirstResponder];
    
}

@end
