//
//  TMAccountWINViewController.m
//  TaoMao
//
//  Created by mac on 14-4-23.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "TMAccountWINViewController.h"
#import "TMMyOrderViewController.h"
@interface TMAccountWINViewController ()

@end

@implementation TMAccountWINViewController

-(UIView*)initNavigationBar
{
    self.navigationController.navigationBarHidden = YES;
    view_bar =[[UIView alloc]init];
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>6.1)
    {
        view_bar .frame=CGRectMake(0, 0, self.view.frame.size.width, 44+20);
        UIImageView *imageV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, 44+20)];
        imageV.image = BundleImage(@"top.png");
        [view_bar addSubview:imageV];
        [imageV release];
        
    }else{
        view_bar .frame=CGRectMake(0, 0, self.view.frame.size.width, 44);
        UIImageView *imageV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, 44)];
        imageV.image = BundleImage(@"top.png");
        [view_bar addSubview:imageV];
        [imageV release];    }
    view_bar.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:view_bar];
    UILabel *title_label=[[UILabel alloc]initWithFrame:CGRectMake(65, view_bar.frame.size.height-44, self.view.frame.size.width-130, 44)];
    title_label.text=@"支付成功";
    title_label.font=[UIFont boldSystemFontOfSize:20];
    title_label.backgroundColor=[UIColor clearColor];
    title_label.textColor =[UIColor whiteColor];
    title_label.textAlignment=1;
    [view_bar addSubview:title_label];
    
    UIButton*btnBack=[UIButton buttonWithType:0];
    btnBack.frame=CGRectMake(0, view_bar.frame.size.height-34, 47, 34);
    [btnBack setImage:BundleImage(@"ret_01.png") forState:0];
    [btnBack addTarget:self action:@selector(btnBack:) forControlEvents:UIControlEventTouchUpInside];
    [view_bar addSubview:btnBack];
    
    return view_bar;
}



//返回
-(void)btnBack:(id)sender
{
    TMAppDelegate *app=(TMAppDelegate*)[UIApplication sharedApplication].delegate;
    [app.navigationController popViewControllerAnimated:YES];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNavigationBar];
    
    UIImageView *imageHead=[[UIImageView alloc]initWithFrame:CGRectMake(40, view_bar.frame.size.height+10, 30, 30)];
    imageHead.image=BundleImage(@"dd_smile.png");
    [self.view addSubview:imageHead];
    [imageHead release];
    UILabel *title_label=[[UILabel alloc]initWithFrame:CGRectMake(imageHead.frame.size.width+imageHead.frame.origin.x+5, imageHead.frame.origin.y, 200, 30)];
    title_label.text=@"恭喜，订单提交成功！";
    title_label.font=[UIFont boldSystemFontOfSize:16];
    title_label.backgroundColor=[UIColor clearColor];
    title_label.textColor =hui2;
    title_label.textAlignment=1;
    //    title_label.shadowColor = [UIColor darkGrayColor];
    //    title_label.shadowOffset = CGSizeMake(1, 1);
    [view_bar addSubview:title_label];

    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-296)/2, imageHead.frame.size.height+15+imageHead.frame.origin.y, 296, 221)];
    image.userInteractionEnabled=YES;
    image.image=BundleImage(@"bg.png");
    [self.view addSubview:image];
    
    UILabel *labelDDH=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 270, 22)];
    labelDDH.text=@"订单号：";
    labelDDH.font=[UIFont systemFontOfSize:14];
    labelDDH.backgroundColor=[UIColor clearColor];
    labelDDH.textColor =hui2;
    labelDDH.textAlignment=0;
    [image addSubview:labelDDH];

    
    UILabel *labelJE=[[UILabel alloc]initWithFrame:CGRectMake(10, 10+44, 270, 22)];
    labelJE.text=@"需支付金额：$129.00";
    labelJE.font=[UIFont systemFontOfSize:14];
    labelJE.backgroundColor=[UIColor clearColor];
    labelJE.textColor =hui2;
    labelJE.textAlignment=0;
    [image addSubview:labelJE];
    
    UILabel *labelSHR=[[UILabel alloc]initWithFrame:CGRectMake(10, 10+44*2, 270, 22)];
    labelSHR.text=[NSString stringWithFormat:@"收货人：%@" ,@"傻逼中卫"];
    labelSHR.font=[UIFont systemFontOfSize:14];
    labelSHR.backgroundColor=[UIColor clearColor];
    labelSHR.textColor =hui2;
    labelSHR.textAlignment=0;
    [image addSubview:labelSHR];
    
    UILabel *labelDZ=[[UILabel alloc]initWithFrame:CGRectMake(10, 10+44*3, 270, 22)];
    labelDZ.text=[NSString stringWithFormat:@"地址：%@" ,@"武进区"];
    labelDZ.font=[UIFont systemFontOfSize:14];
    labelDZ.backgroundColor=[UIColor clearColor];
    labelDZ.textColor =hui2;
    labelDZ.textAlignment=0;
    [image addSubview:labelDZ];
    
    UILabel *labelDH=[[UILabel alloc]initWithFrame:CGRectMake(10, 10+44*4, 270, 22)];
    labelDH.text=[NSString stringWithFormat:@"电话：%@" ,@"18661168519"];
    labelDH.font=[UIFont systemFontOfSize:14];
    labelDH.backgroundColor=[UIColor clearColor];
    labelDH.textColor =hui2;
    labelDH.textAlignment=0;
    [image addSubview:labelDH];


    UIButton*btnHome=[UIButton buttonWithType:0];
    btnHome.frame=CGRectMake((self.view.frame.size.width/2-90)/2, image.frame.size.height+image.frame.origin.y+40, 90, 29);
    [btnHome setImage:BundleImage(@"dd_ffsy.png") forState:0];
    [btnHome addTarget:self action:@selector(btnHome:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnHome];
    
    
    UIButton*btnDD=[UIButton buttonWithType:0];
    
    btnDD.frame=CGRectMake(self.view.frame.size.width-(self.view.frame.size.width/2-90)/2-90, btnHome.frame.origin.y, 90, 29);
    [btnDD setImage:BundleImage(@"dd_wddd.png") forState:0];
    [btnDD addTarget:self action:@selector(btnDD:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnDD];

}
-(void)btnHome:(id)sender
{
   [[NSNotificationCenter defaultCenter] postNotificationName:@"backHome" object:nil];

}

-(void)btnDD:(id)sender
{
    TMMyOrderViewController*order=[[TMMyOrderViewController alloc]init];
    TMAppDelegate *delegate=(TMAppDelegate*)[UIApplication sharedApplication].delegate;
    [delegate.navigationController pushViewController:order animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
