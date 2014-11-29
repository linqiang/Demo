//
//  MJDetailViewController.m
//  MJPopupViewControllerDemo
//
//  Created by Martin Juhasz on 24.06.12.
//  Copyright (c) 2012 martinjuhasz.de. All rights reserved.
//

#import "MJDetailViewController.h"

@implementation MJDetailViewController

-(void)viewDidLoad
{

    self.view.backgroundColor=[UIColor whiteColor];
    self.view.frame=CGRectMake(0, 0, 320, 400);
    
    UILabel *title_label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    title_label.text=@"选择颜色，尺码";
    title_label.font=[UIFont systemFontOfSize:16];
    title_label.backgroundColor=[UIColor clearColor];
    title_label.textColor =hui2;
    title_label.textAlignment=1;
    //    title_label.shadowColor = [UIColor darkGrayColor];
    //    title_label.shadowOffset = CGSizeMake(1, 1);
    [self.view addSubview:title_label];

//    bt_clo_@2x  36 32
    UIButton *btnClose=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-36, 0, 36, 32)];
    [btnClose setImage:BundleImage(@"bt_clo_.png") forState:0];
    [self.view addSubview:btnClose];
    
    UIImageView *headImg=[[UIImageView alloc]initWithFrame:CGRectMake(10, 60, 70, 70)];
    headImg.image=BundleImage(@"df_04_.png");
    [self.view addSubview:headImg];
    [headImg release];
    
    UILabel *title_label1=[[UILabel alloc]initWithFrame:CGRectMake(headImg.frame.size.width+headImg.frame.origin.x+10, headImg.frame.origin.y, 320-100, 40)];
    title_label1.text=@"首页首页首页首页首页首页首页首页首页首页首页首页首页首页首页首页";
    title_label1.font=[UIFont systemFontOfSize:16];
    title_label1.backgroundColor=[UIColor clearColor];
    title_label1.textColor =hui2;
    title_label1.numberOfLines=0;
    title_label1.textAlignment=0;

    [self.view addSubview:title_label1];
    UILabel *price_label1=[[UILabel alloc]initWithFrame:CGRectMake(headImg.frame.size.width+headImg.frame.origin.x+10, title_label1.frame.origin.y+title_label1.frame.size.height+5, 70, 20)];
    price_label1.text=@"￥120.70";
    price_label1.font=[UIFont systemFontOfSize:16];
    price_label1.backgroundColor=[UIColor clearColor];
    price_label1.textColor =hongShe;
    price_label1.numberOfLines=2;
    price_label1.textAlignment=0;
    
    [self.view addSubview:price_label1];
    
    UILabel *price_label2=[[UILabel alloc]initWithFrame:CGRectMake(price_label1.frame.size.width+price_label1.frame.origin.x+10, title_label1.frame.origin.y+title_label1.frame.size.height+5, 100, 20)];
    price_label2.text=@"(库存128件)";
    price_label2.font=[UIFont systemFontOfSize:16];
    price_label2.backgroundColor=[UIColor clearColor];
    price_label2.textColor =hui5;
    price_label2.numberOfLines=0;
    price_label2.textAlignment=0;
    
    [self.view addSubview:price_label2];
    
}

-(void)btnClose:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];

}


@end
