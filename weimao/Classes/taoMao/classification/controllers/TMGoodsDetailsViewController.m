//
//  TMGoodsDetailsViewController.m
//  TaoMao
//
//  Created by mac on 14-4-17.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "TMGoodsDetailsViewController.h"
#import "TMCommentListViewController.h"
#import "TMShopStoreDetailScrollController.h"
#import "TMShopStoreViewController.h"
#import "TMRulerColor.h"
#import "UIViewController+MJPopupViewController.h"
#import "MJDetailViewController.h"
#import "FCImageTextViewController.h"
//#import <Frontia/Frontia.h>

static CGFloat kImageOriginHight = 400;
@interface TMGoodsDetailsViewController ()
{
    UIView*navigationBar;
    UrlImageButton* threeButtonImg;//三个按钮背影图
  
    UIView *_bgView;
    TMRulerColor*rulerView;
    UIView *view_bar1;
}
@end

@implementation TMGoodsDetailsViewController

-(UIView*)initNavigationBar
{
    self.navigationController.navigationBarHidden = YES;
    view_bar1 =[[UIView alloc]init];
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>6.1)
    {
        view_bar1 .frame=CGRectMake(0, 0, self.view.frame.size.width, 44+20);
        UIImageView *imageV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, 44+20)];
        imageV.image = BundleImage(@"top.png");
        [view_bar1 addSubview:imageV];
        [imageV release];
        
    }else{
        view_bar1 .frame=CGRectMake(0, 0, self.view.frame.size.width,44);
        UIImageView *imageV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,44)];
        imageV.image = BundleImage(@"top.png");
        [view_bar1 addSubview:imageV];
        [imageV release];
    }
    view_bar1.backgroundColor=[UIColor clearColor];
    
    [self.view addSubview:view_bar1];
    UILabel *title_label=[[UILabel alloc]initWithFrame:CGRectMake(65, view_bar1.frame.size.height-44, self.view.frame.size.width-130, 44)];
    title_label.text=@"商品详情";
    title_label.font=[UIFont boldSystemFontOfSize:20];
    title_label.backgroundColor=[UIColor clearColor];
    title_label.textColor =[UIColor whiteColor];
    title_label.textAlignment=1;
    [view_bar1 addSubview:title_label];
    
    UIButton*btnBack=[UIButton buttonWithType:0];
    btnBack.frame=CGRectMake(0, view_bar1.frame.size.height-34, 47, 34);
    [btnBack setImage:BundleImage(@"ret_01.png") forState:0];
    [btnBack addTarget:self action:@selector(btnBack:) forControlEvents:UIControlEventTouchUpInside];
    [view_bar1 addSubview:btnBack];

    
    UIButton*btnHome=[UIButton buttonWithType:0];
    btnHome.frame=CGRectMake(view_bar1.frame.size.width-55, view_bar1.frame.size.height-40, 47, 34);
    [btnHome setImage:BundleImage(@"shop_zy_.png") forState:0];
    [btnHome addTarget:self action:@selector(btnHome:) forControlEvents:UIControlEventTouchUpInside];
    [view_bar1 addSubview:btnHome];
 
    
   
    return view_bar1;
}


-(UIView *)initToolBar
{
    UIView *view_bar =[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-49, self.view.frame.size.width, 49)];
    view_bar.backgroundColor=[UIColor whiteColor];
    view_bar.layer.borderColor=[UIColor colorWithRed:.9 green:.9  blue:.9  alpha:1.0].CGColor;
    view_bar.layer.borderWidth=1;
    [self.view addSubview:view_bar];

    UIButton*btnCall=[UIButton buttonWithType:0];
    btnCall.frame=CGRectMake(20, 0, 80, 50);
    btnCall.backgroundColor=[UIColor clearColor];
    [btnCall addTarget:self action:@selector(call:) forControlEvents:UIControlEventTouchUpInside];
    [btnCall setImage:BundleImage(@"shopbt_02_.png") forState:0];
    [view_bar addSubview:btnCall];
    
    UIButton*btnAdd=[UIButton buttonWithType:0];
    btnAdd.frame=CGRectMake(20+80+10, 0, 80, 50);
    btnAdd.backgroundColor=[UIColor clearColor];
    [btnAdd addTarget:self action:@selector(shopping:) forControlEvents:UIControlEventTouchUpInside];
    [btnAdd setImage:BundleImage(@"shopbt_03_.png") forState:0];
    [view_bar addSubview:btnAdd];
    
    UIButton*btnShop=[UIButton buttonWithType:0];
    btnShop.frame=CGRectMake(20+80+20+80, 49/2-28/2, 100, 28);
    btnShop.backgroundColor=[UIColor clearColor];
    [btnShop addTarget:self action:@selector(shopping:) forControlEvents:UIControlEventTouchUpInside];
    [btnShop setImage:BundleImage(@"shopbt_01_n_.png") forState:0];
    [view_bar addSubview:btnShop];
    

    
    return view_bar;
}


-(void)viewDidLoad
{
    
    [super viewDidLoad];
    
    UIView *naviView=(UIView*) [self initNavigationBar];
    
    
    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, kImageOriginHight-100, 320, self.view.frame.size.height)];
    _scrollView.delegate = self;
    _scrollView.userInteractionEnabled=YES;
    _scrollView.contentSize=CGSizeMake(320, self.view.frame.size.height);
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.backgroundColor=[UIColor colorWithRed:.98 green:.98 blue:.98 alpha:1.0];
    _scrollView.contentInset=UIEdgeInsetsMake(kImageOriginHight-100, 0, 50, 0);
    [self.view addSubview:_scrollView];
    _bigImg=[[UrlImageButton alloc]initWithFrame:CGRectMake(0, -kImageOriginHight, 320, kImageOriginHight)];
    [_bigImg addTarget:self action:@selector(btnImageText:) forControlEvents:UIControlEventTouchUpInside];
    [_bigImg setImage:BundleImage(@"shop_df_big_.png") forState:0];
    _bigImg.backgroundColor=[UIColor clearColor];
    [_scrollView addSubview:_bigImg ];
    [self initScrollView];
    
    
    [self initToolBar];
    
    UIButton*btnShare=[UIButton buttonWithType:0];
    btnShare.frame=CGRectMake(self.view.frame.size.width-50, naviView.frame.size.height+10, 42, 42);
    //    btnShare.backgroundColor=[UIColor clearColor];
    [btnShare addTarget:self action:@selector(btnShare:) forControlEvents:UIControlEventTouchUpInside];
    [btnShare setImage:BundleImage(@"shop_fx_.png") forState:0];
    [self.view insertSubview:btnShare aboveSubview:_scrollView];
    
    UIButton*btnGoShop=[UIButton buttonWithType:0];
    btnGoShop.frame=CGRectMake(self.view.frame.size.width-50*2, naviView.frame.size.height+10, 42, 42);
    btnGoShop.backgroundColor=[UIColor clearColor];
    [btnGoShop addTarget:self action:@selector(btnGoCar:) forControlEvents:UIControlEventTouchUpInside];
    [btnGoShop setImage:BundleImage(@"shop_gwc_.png") forState:0];
    [self.view insertSubview:btnGoShop aboveSubview:_scrollView];
}
-(void)viewWillAppear:(BOOL)animated
{
    _bigImg.frame=CGRectMake(0, -kImageOriginHight, _scrollView.frame.size.width, kImageOriginHight);
    _scrollView.contentOffset=CGPointMake(0, -kImageOriginHight+100);
}
-(void)initScrollView
{
    
    
    UIView *_bigView=[[UIView alloc]initWithFrame:CGRectMake(0, _bigImg.frame.size.height+_bigImg.frame.origin.y-30, 320, 30)];
    _bigView.layer.borderWidth=1;
    _bigView.layer.borderColor=[UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1.0].CGColor;
    
    _bigView.backgroundColor=[UIColor whiteColor];
    [_scrollView addSubview:_bigView];
    
    UILabel *title_label=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 250, 30)];
    title_label.text=@"超甜美小香风蕾丝绣花连衣裙";
    title_label.font=[UIFont boldSystemFontOfSize:10];
    title_label.backgroundColor=[UIColor clearColor];
    title_label.textColor =[UIColor colorWithRed:.3 green:.3 blue:.3 alpha:1.0];
    title_label.textAlignment=0;
    [_bigView insertSubview:title_label atIndex:0];
    
    
    
    UILabel *title_money=[[UILabel alloc]initWithFrame:CGRectMake(title_label.frame.size.width+title_label.frame.origin.x,0, 65, 30)];
    title_money.text=@"$123.00";
    title_money.font=[UIFont systemFontOfSize:14];
    title_money.backgroundColor=[UIColor clearColor];
    title_money.textColor =hongShe;
    title_money.textAlignment=0;
    [_bigView insertSubview:title_money atIndex:0];
    
    
    //邮费销量库存
    UIView *_bigView1=[[UIView alloc]initWithFrame:CGRectMake(0, _bigView.frame.size.height+_bigView.frame.origin.y+10, 320, 50)];
    _bigView1.layer.borderWidth=1;
    _bigView1.layer.borderColor=[UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1.0].CGColor;
    _bigView1.backgroundColor=[UIColor whiteColor];
    [_scrollView addSubview:_bigView1];
    
    UILabel *title1=[[UILabel alloc]initWithFrame:CGRectMake(0, 10, 320/3, 15)];
    title1.text=@"邮费";
    title1.font=[UIFont systemFontOfSize:10];
    title1.backgroundColor=[UIColor clearColor];
    title1.textColor =[UIColor grayColor];
    title1.textAlignment=1;
    [_bigView1 addSubview:title1];
    
    UILabel *title2=[[UILabel alloc]initWithFrame:CGRectMake(0, title1.frame.size.height+10, 320/3, 15)];
    title2.text=@"包邮";
    title2.font=[UIFont systemFontOfSize:10];
    title2.backgroundColor=[UIColor clearColor];
    title2.textColor =hongShe;
    title2.textAlignment=1;
    [_bigView1 addSubview:title2];
    
    UIImageView*line1=[[UIImageView alloc]initWithFrame:CGRectMake(320/3,( _bigView1.frame.size.height-30)/2, 1, 30)];
    line1.image=BundleImage(@"line_01_.png");
    [_bigView1 addSubview:line1];
    
    UIImageView*line2=[[UIImageView alloc]initWithFrame:CGRectMake(320/3*2,( _bigView1.frame.size.height-30)/2, 1, 30)];
    line2.image=BundleImage(@"line_01_.png");
    [_bigView1 addSubview:line2];
    
    UILabel *title11=[[UILabel alloc]initWithFrame:CGRectMake(320/3, 10, 320/3, 15)];
    title11.text=@"销量";
    title11.font=[UIFont systemFontOfSize:10];
    title11.backgroundColor=[UIColor clearColor];
    title11.textColor =[UIColor grayColor];
    title11.textAlignment=1;
    [_bigView1 addSubview:title11];
    
    UILabel *title12=[[UILabel alloc]initWithFrame:CGRectMake(320/3, title1.frame.size.height+10, 320/3, 15)];
    title12.text=@"41件";
    title12.font=[UIFont systemFontOfSize:10];
    title12.backgroundColor=[UIColor clearColor];
    title12.textColor =hongShe;
    title12.textAlignment=1;
    [_bigView1 addSubview:title12];
    
    UILabel *title21=[[UILabel alloc]initWithFrame:CGRectMake(320/3*2, 10, 320/3, 15)];
    title21.text=@"库存";
    title21.font=[UIFont systemFontOfSize:10];
    title21.backgroundColor=[UIColor clearColor];
    title21.textColor =[UIColor grayColor];
    title21.textAlignment=1;
    [_bigView1 addSubview:title21];
    
    UILabel *title22=[[UILabel alloc]initWithFrame:CGRectMake(320/3*2, title1.frame.size.height+10, 320/3, 15)];
    title22.text=@"11件";
    title22.font=[UIFont systemFontOfSize:10];
    title22.backgroundColor=[UIColor clearColor];
    title22.textColor =hongShe;
    title22.textAlignment=1;
    [_bigView1 addSubview:title22];
    
    
    //头像，清新部落
    _bigView2=[[UrlImageButton alloc]initWithFrame:CGRectMake(0, _bigView1.frame.size.height+_bigView1.frame.origin.y+10, 320, 80)];
    _bigView2.userInteractionEnabled=YES;
    _bigView2.backgroundColor=[UIColor whiteColor];
    _bigView2.layer.borderWidth=1;
    [_bigView2 addTarget:self action:@selector(btnGo:) forControlEvents:UIControlEventTouchUpInside];
    _bigView2.layer.borderColor=[UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1.0].CGColor;
    [_scrollView addSubview:_bigView2];
    
    
    UrlImageView *headImg=[[UrlImageView alloc]initWithFrame:CGRectMake(15, 10, 60, 60)];
    headImg.image=BundleImage(@"df_03_.png");
    [_bigView2 addSubview:headImg];
    headImg.backgroundColor=[UIColor clearColor];
    
    UrlImageView *headImg1=[[UrlImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    headImg1.image=BundleImage(@"bg_01_.png");
    [headImg addSubview:headImg1];
    headImg1.backgroundColor=[UIColor clearColor];
    
    
    UILabel *title3=[[UILabel alloc]initWithFrame:CGRectMake(headImg.frame.size.width+headImg.frame.origin.x+10, 15,190, 20)];
    title3.text=@"清新部落";
    title3.font=[UIFont systemFontOfSize:12];
    title3.backgroundColor=[UIColor clearColor];
    title3.textColor =[UIColor colorWithRed:.2 green:.2 blue:.2 alpha:1.0];
    title3.textAlignment=0;
    [_bigView2 addSubview:title3];
    
    UILabel *title4=[[UILabel alloc]initWithFrame:CGRectMake(headImg.frame.size.width+headImg.frame.origin.x+10, 15+title3.frame.size.height,50, 20)];
    title4.text=@"店铺介绍：";
    title4.font=[UIFont systemFontOfSize:10];
    title4.backgroundColor=[UIColor clearColor];
    title4.textColor =[UIColor colorWithRed:.5 green:.5 blue:.5 alpha:1.0];
    title4.textAlignment=0;
    [_bigView2 addSubview:title4];
    
    UILabel *title5=[[UILabel alloc]initWithFrame:CGRectMake(title4.frame.size.width+title4.frame.origin.x, 15+title3.frame.size.height,130, 30)];
    title5.text=@"店铺介绍店铺介店铺介绍店铺介绍店铺介绍店铺介绍店铺介绍";
    
    title5.font=[UIFont systemFontOfSize:10];
    title5.numberOfLines=2;
    title5.backgroundColor=[UIColor clearColor];
    title5.textColor =[UIColor colorWithRed:.8 green:.8 blue:.8 alpha:1.0];
    title5.textAlignment=0;
    [_bigView2 addSubview:title5];
    
    
    UIImageView *imageJ=[[UIImageView alloc]initWithFrame:CGRectMake(_bigView2.frame.size.width-44, (_bigView2.frame.size.height-70)/2, 44, 70)];
    imageJ.image=BundleImage(@"bt_04_J.png");
    [_bigView2 addSubview:imageJ];
    
    threeButtonImg=[[UrlImageButton alloc]initWithFrame:CGRectMake(0, _bigView2.frame.size.height+_bigView2.frame.origin.y+10, self.view.frame.size.width,35 )];
    threeButtonImg.layer.borderColor=[UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1.0].CGColor;
    threeButtonImg.layer.borderWidth=1;
    [threeButtonImg addTarget:self action:@selector(btnComment:) forControlEvents:UIControlEventTouchUpInside];
    threeButtonImg.backgroundColor=[UIColor whiteColor];
    threeButtonImg.userInteractionEnabled=YES;
    [_scrollView addSubview:threeButtonImg];
    
    UILabel *title_label1=[[UILabel alloc]initWithFrame:CGRectMake(10, threeButtonImg.frame.size.height/2-20/2, 50, 20)];
    title_label1.text=@"评论";
    title_label1.font=[UIFont systemFontOfSize:12];
    title_label1.backgroundColor=[UIColor clearColor];
    title_label1.textColor =hui5;
    title_label1.textAlignment=0;
    [threeButtonImg addSubview:title_label1];
    
    
    UILabel *title_labelCount=[[UILabel alloc]initWithFrame:CGRectMake(title_label1.frame.size.width+title_label1.frame.origin.y, threeButtonImg.frame.size.height/2-20/2, 200, 20)];
    title_labelCount.text=@"123条";
    title_labelCount.font=[UIFont systemFontOfSize:12];
    title_labelCount.backgroundColor=[UIColor clearColor];
    title_labelCount.textColor =hongShe;
    title_labelCount.textAlignment=0;
    
    [threeButtonImg addSubview:title_labelCount];
    
    UIImageView *imageP=[[UIImageView alloc]initWithFrame:CGRectMake(threeButtonImg.frame.size.width-44, (threeButtonImg.frame.size.height-70)/2, 44, 70)];
    imageP.image=BundleImage(@"bt_04_J.png");
    [threeButtonImg addSubview:imageP];
    
    
    for (int i=0; i<8; i++)
    {
        btnNine=[[UrlImageButton alloc]initWithFrame:CGRectMake((i%4)*(320-10)/4+10, floor(i/4)*(320-10)/4+10+threeButtonImg.frame.size.height+threeButtonImg.frame.origin.y, (320-30-10)/4, (320-30-10)/4)];
        btnNine.backgroundColor=[UIColor whiteColor];
        [btnNine setImage:[UIImage imageNamed:@"df_01.png"] forState:0];
        btnNine.tag=i+1000;
        [btnNine addTarget:self action:@selector(btnImageText:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:btnNine];
        
    }
    if (IS_IPHONE_5)
    {
        _scrollView.contentSize=CGSizeMake(320, self.view.frame.size.height);
    }else{
        _scrollView.contentSize=CGSizeMake(320, self.view.frame.size.height+100);
    }
    UIView *view=[[UILabel alloc]initWithFrame:CGRectMake(10, btnNine.frame.size.height+btnNine.frame.origin.y+10, 300, 80)];
    view.layer.borderWidth=1;
    view.backgroundColor=[UIColor whiteColor];
    view.layer.borderColor=[UIColor colorWithRed:.95 green:.95 blue:.95 alpha:1.0].CGColor;
    [_scrollView addSubview:view];
    
    UILabel *labelDetail=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 290, 70)];
    
    labelDetail.backgroundColor=[UIColor whiteColor];
    labelDetail.font=[UIFont systemFontOfSize:10];
    labelDetail.textColor=[UIColor colorWithRed:.5 green:.5 blue:.5 alpha:1.0];
    labelDetail.text=@"蠛楞罗明的后1空产安5前类4蠛楞罗明的；后1空产安5前类46蠛；楞罗明的后1空产安5前类4665罗明的；后1空产安5前类4蠛；楞罗明的后1空产安5前类46蠛楞罗明的；后1空产安5前类4665";
    labelDetail.numberOfLines=0;
    [labelDetail sizeToFit];
    [view addSubview :labelDetail ];
    
    _scrollView.frame=CGRectMake(0, view_bar1.frame.size.height, 320, self.view.frame.size.height+140-view.frame.size.height-10);
    
    [title5 release];
    [title2 release];
    [title21 release];
    [title3 release];
    [title4 release];
    [title22 release];
    [title11 release];
    [title12 release];
    [_bigView2 release];

}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1000)
    {
        if (buttonIndex == 1)
            
        {
            TMShopStoreViewController *shopCar=[[TMShopStoreViewController alloc]init];
            TMAppDelegate *delegate=(TMAppDelegate*)[UIApplication sharedApplication].delegate;
            [delegate.navigationController pushViewController:shopCar animated:YES];

        }
    }
    if (alertView.tag==1001)
    {
        if (buttonIndex == 0)
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",@"13912345678"]]];
        }
    }
}

//立即购买消失按钮
-(void)SetViewDisappear:(id)sender
{
    UIButton*btn=(UIButton*)sender;
    
    if (_bgView)
    {
        [UIView animateWithDuration:.5
                         animations:^{
                             
                             //                             rulerView.frame=CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
                             //                            _bgView.frame=CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
                             _bgView.alpha=0.0;
                         }];
        [_bgView performSelector:@selector(removeFromSuperview)
                      withObject:nil
                      afterDelay:2];
        
        
    }
    //    if (btn.selected==NO)
    //    {
    //        [btn setImage:BundleImage(@"bt_close_n.png") forState:0];
    //        btn.selected=YES;
    //    }else{
    //        [btn setImage:BundleImage(@"bt_close_s.png") forState:0];
    //        btn.selected=NO;
    //    }
    
}
//分享
-(void)btnShare:(id)sender
{
    

}
//添加购物车
-(void)addShopCar:(id)sender
{

    
//    UIView* bgView = [[UIView alloc]initWithFrame:CGRectMake(0,0, 320,self.view.frame.size.height-49)];
//    [bgView setTag:99999];
//    [bgView setBackgroundColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5]];
//    [bgView setAlpha:0.8];
//    
//    [self.view addSubview:bgView];
//    UIView* firstLevelMenuView = [[UIView alloc]initWithFrame:CGRectMake(0, 100, 320,0)];
//    UIImageView*_imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
//    _imageView.image=BundleImage(@"bg_w_.png");
//    [firstLevelMenuView insertSubview:_imageView aboveSubview:firstLevelMenuView];
//    
//    firstLevelMenuView.tag = 100000;
////    firstLevelMenuView.menuDelegate = self;
//    firstLevelMenuView.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];
//    [bgView addSubview:firstLevelMenuView];
//    [UIView beginAnimations:@"animationID" context:nil];
//    [UIView setAnimationDuration:0.5];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
//    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:firstLevelMenuView cache:NO];
//    firstLevelMenuView.frame= CGRectMake(0, 150, 320, self.view.frame.size.height-200);
//
////    [_imageView release];
//    [UIView commitAnimations];
    
    

    showShareMessage(@"商品成功添加购物车！");
}
//联系卖家
-(void)call:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"13912345768" message:@"确认要拨打电话吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    alert.tag = 1001;
    [alert show];
    [alert release];

}
//去购物车
-(void)btnGoCar:(id)sender
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"加入购物车" message:@"商品己成功加入购物车！" delegate:self cancelButtonTitle:@"继续购物" otherButtonTitles:@"去购物车", nil];
    alert.tag = 1000;
    [alert show];
    [alert release];
    
}
    //返回首页
-(void)btnHome:(id)sender
{

    [[NSNotificationCenter defaultCenter] postNotificationName:@"backHome" object:nil];
}
//返回
-(void)btnBack:(id)sender
{
    TMAppDelegate *app=(TMAppDelegate*)[UIApplication sharedApplication].delegate;
    [app.navigationController popViewControllerAnimated:YES];
    
}
//立即购买
-(void)shopping:(id)sender
{
    _bgView = [[UIView alloc]initWithFrame:CGRectMake(0,0, 320,self.view.frame.size.height)];
    [_bgView setTag:99999];
    [_bgView setBackgroundColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.4]];
    [_bgView setAlpha:1.0];
    
    [self.view addSubview:_bgView];
    rulerView = [[TMRulerColor alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height, 320,0) ];
    rulerView.tag = 100000;
//    rulerView.menuDelegate = self;
    rulerView.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];
    [_bgView addSubview:rulerView];
    [UIView beginAnimations:@"animationID" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:rulerView cache:NO];
    rulerView.frame= CGRectMake(0, self.view.frame.size.height-420, 320, 420);
    UIImageView*_imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 6)];
    _imageView.image=BundleImage(@"ic_pull_shadow.png");
    [_bgView addSubview:_imageView];
    [_imageView release];
    [UIView commitAnimations];
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(_bgView.frame.size.width-36,0 , 36, 32);
    [button setImage:BundleImage(@"bt_clo_.png") forState:0];
    [button addTarget:self action:@selector(SetViewDisappear:) forControlEvents:UIControlEventTouchDown];
    [rulerView insertSubview:button aboveSubview:_bgView];
    button.backgroundColor=[UIColor clearColor];
   
}


-(void)btnNine:(id)sender
{
    //    UIButton *btn=(UIButton*)sender;
    //
//    FCImageTextViewController *imageText=[[FCImageTextViewController alloc] init];
//    TMAppDelegate *delegate=(TMAppDelegate*)[UIApplication sharedApplication].delegate;
//    [delegate.navigationController presentViewController:imageText animated:YES completion:nil];
    
}
-(void)btnGo:(id)sender
{
    TMShopStoreDetailScrollController *shop=[[TMShopStoreDetailScrollController alloc]init];
    TMAppDelegate *delegate=(TMAppDelegate*)[UIApplication sharedApplication].delegate;
    [delegate.navigationController pushViewController:shop animated:YES];
    
}
-(void)btnImageText:(NSArray*)sender
{
    FCImageTextViewController *imageText=[[FCImageTextViewController alloc] init];
    [self.navigationController pushViewController:imageText animated:YES];

}
-(void)btnComment:(id)sender
{

    TMCommentListViewController *commentV=[[TMCommentListViewController alloc]init];
    TMAppDelegate *delegate=(TMAppDelegate*)[UIApplication sharedApplication].delegate;
    [delegate.navigationController pushViewController:commentV animated:YES];

}



//八个小图按钮代理事件
-(void)detailSelectButtonIndex:(NSInteger)num
{

    [self btnImageText:[[NSArray alloc]init]];

}
#pragma mark红色线条动画

- (CGFloat) horizontalLocationFor:(NSUInteger)tabIndex
{
    CGFloat tabItemWidth = self.view.frame.size.width/2;
    return (tabIndex * tabItemWidth);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat yOffset  = scrollView.contentOffset.y;
    if (yOffset < -kImageOriginHight) {
        CGRect f = _bigImg.frame;
        f.origin.y = yOffset;
        f.size.height =  -yOffset;
        _bigImg.frame = f;
    }
}
-(void)dealloc{

    [_scrollView release];
    [super dealloc];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
