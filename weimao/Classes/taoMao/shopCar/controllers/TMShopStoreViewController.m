//
//  TMShopStoreViewController.m
//  TaoMao
//
//  Created by mac on 14-4-19.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "TMShopStoreViewController.h"
#import "TMShopCarViewController.h"

#import "TMMyOrderViewController.h"

@interface TMShopStoreViewController ()

@end

@implementation TMShopStoreViewController

-(id)initWithTabbar:(BOOL)isTabbar{
    self = [super init];
    if (self) {
        _isTabbar=isTabbar;
    }
    return self;
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initNavigationBar];
    [self addViews];
}

-(void)addViews
{
  
    if (_isTabbar==YES) {
          _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, view_bar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-view_bar.frame.size.height-49)style:UITableViewStylePlain];
    }else{
      _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, view_bar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-view_bar.frame.size.height)style:UITableViewStylePlain];
    
    }
    _tableView.userInteractionEnabled=YES;
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.backgroundView=nil;
    _tableView.backgroundColor=[UIColor colorWithRed:.98 green:.98 blue:.98 alpha:1.0];
    _tableView.showsHorizontalScrollIndicator=NO;
    _tableView.showsVerticalScrollIndicator=NO;
    _tableView.separatorColor=[UIColor clearColor];
    //    self.view.backgroundColor=[UIColor colorWithRed:.5 green:.5 blue:.5 alpha:1.0];
    [self.view addSubview:_tableView];
}

-(UIView*)initNavigationBar
{
    view_bar =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>6.1)
    {
        view_bar .frame=CGRectMake(0, 0, self.view.frame.size.width, 44+20);
        UIImageView *imageV = [[UIImageView alloc]initWithImage:BundleImage(@"top.png")];
        [view_bar addSubview:imageV];
        [imageV release];
        
    }else{
        view_bar .frame=CGRectMake(0, 0, self.view.frame.size.width, 44);
        UIImageView *imageV = [[UIImageView alloc]initWithImage:BundleImage(@"top.png")];
        [view_bar addSubview:imageV];
        [imageV release];
    }
    UILabel *title_label=[[UILabel alloc]initWithFrame:CGRectMake(65, view_bar.frame.size.height-44, self.view.frame.size.width-130, 44)];
    title_label.text=@"购物车商家分类";
    title_label.font=[UIFont boldSystemFontOfSize:20];
    title_label.backgroundColor=[UIColor clearColor];
    title_label.textColor =[UIColor whiteColor];
    title_label.textAlignment=1;
    [view_bar addSubview:title_label];
    

    UIImageView*leftImageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-60, (44-37)/2, 2,37)];
    leftImageView.image=BundleImage(@"navigation_bar_line.png");
    [view_bar addSubview:leftImageView];

    [self.view addSubview:view_bar];
    
    if (_isTabbar==NO)
    {
        UIButton*btnBack=[UIButton buttonWithType:0];
        btnBack.frame=CGRectMake(0, view_bar.frame.size.height-34, 47, 34);
        [btnBack setImage:BundleImage(@"ret_01.png") forState:0];
        [btnBack addTarget:self action:@selector(btnBack:) forControlEvents:UIControlEventTouchUpInside];
        [view_bar addSubview:btnBack];
        
        
        UIButton*btnHome=[UIButton buttonWithType:0];
        btnHome.frame=CGRectMake(view_bar.frame.size.width-55, view_bar.frame.size.height-40, 47, 34);
        [btnHome setImage:BundleImage(@"shop_zy_.png") forState:0];
        [btnHome addTarget:self action:@selector(btnHome:) forControlEvents:UIControlEventTouchUpInside];
        [view_bar addSubview:btnHome];

    }  else
    {
        UIButton*btnDD=[UIButton buttonWithType:0];
        btnDD.frame=CGRectMake(self.view.frame.size.width-60, view_bar.frame.size.height-44, 54, 44);
        [btnDD setTitleColor:[UIColor whiteColor] forState:0];
        [btnDD setTitle:@"订单" forState:0];
        btnDD.titleLabel.textColor=[UIColor whiteColor];
        [btnDD addTarget:self action:@selector(btnDD:) forControlEvents:UIControlEventTouchUpInside];
        [view_bar addSubview:btnDD];
        
    }
    
    
    [title_label release];
    [view_bar release];

    return view_bar;
}
-(void)btnDD:(id)sender
{
    TMMyOrderViewController *order=[[TMMyOrderViewController alloc]init];
    TMAppDelegate *delegate=(TMAppDelegate*)[UIApplication sharedApplication].delegate;
    [delegate.navigationController pushViewController:order animated:YES];
    
}


-(void)btnHome:(id)sender
{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"backHome" object:nil];
}
-(void)btnBack:(id)sender
{
    TMAppDelegate *app=(TMAppDelegate*)[UIApplication sharedApplication].delegate;
    [app.navigationController popViewControllerAnimated:YES];
    
}
-(void)viewWillAppear:(BOOL)animated
{

}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
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
    
    TMShopCarViewController *car=[[TMShopCarViewController alloc]initWithTabbar:NO];
    TMAppDelegate *delegate=(TMAppDelegate*)[UIApplication sharedApplication].delegate;
    [delegate.navigationController pushViewController:car animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return 90;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
