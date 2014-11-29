//
//  TMStoreListView.m
//  TaoMao
//
//  Created by mac on 14-4-25.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "TMStoreListView.h"
#import "TMShopStoreDetailScrollController.h"


@implementation TMStoreListView

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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cate_cell";
    
    UITableViewCell*   cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.editingAccessoryType=UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType=UITableViewCellAccessoryNone;
        cell.selected=NO;
        cell.tag=1000+indexPath.row;
        //        cell.backgroundColor=[UIColor colorWithRed:.95 green:.95 blue:.95 alpha:1.0];
        
        //图片
        //
        // NSString*_url=[NSString stringWithFormat:@"%@/%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"currentUrl"],[[[[_marrayAll objectAtIndex:indexPath.row]productList]objectAtIndex:0] icon]];
        
        //        UIImageView *bgImage=[[UIImageView alloc]initWithFrame:CGRectMake(320/2-297/2, 10, 297, 97)];
        //        bgImage.image=BundleImage(@"ddmj_3.png");
        //        [cell addSubview:bgImage];
        
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
        
        //        if ([[[[_marrayAll objectAtIndex:indexPath.row]productList]objectAtIndex:0] icon]==nil)
        //        {
        
        //        }else
        //        {
        //            [imgView setImageWithURL:[NSURL URLWithString:_url]];
        //
        //        }
        
        //        [cell addSubview:imgView];
        
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
    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TMShopStoreDetailScrollController *shopStore=[[TMShopStoreDetailScrollController alloc]init];
    TMAppDelegate *appDelegate = (TMAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController pushViewController:shopStore animated:YES];
//    [self removeFromSuperview];

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return 90;
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    
    
}
- (void)scrollViewWillBeginDragging:(TMStoreListView *)scrollView{
    
    UITextField*tf=(UITextField*)[self.superview viewWithTag:-19];
    [tf resignFirstResponder];
    
}

@end
