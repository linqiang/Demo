//
//  FCImageTextViewController.m
//  Flower&Cake
//图文详情
//  Created by 呵呵 on 13-7-7.
//  Copyright (c) 2013年 呵呵. All rights reserved.
//

#import "FCImageTextViewController.h"
#import "FCTabBarController.h"
#import "FCLogonViewController.h"
@interface FCImageTextViewController ()

@end

@implementation FCImageTextViewController

-(id)initWithImages:(NSArray *)urlArray
           addPrice:(NSString*)price
         addExplain:(NSString *)expain
       addProductID:(NSString*)productid
     addpromptPrice:(NSString *)promptPrice
     addmemberPrice:(NSString *)memberPrice
         addProduct:(id)product
{
    self=[super init];
    if (self) {
//        _urlArray=[[NSArray alloc]initWithArray:urlArray];
//        _price=[[NSString alloc]initWithString:price];
//        _expain=[[NSString alloc] initWithString:expain];
//        _productid=[[NSString alloc]initWithString:productid];
//        _promptPrice=[[NSString alloc]initWithString:promptPrice];
//        _memberPrice=[[NSString alloc]initWithString:memberPrice];
     
        
    }
    return self;
    
}-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HideTabbar" object:nil];
    self.navigationController.navigationBarHidden=YES;
    self.view.backgroundColor = [UIColor whiteColor];
}

-(UIView*)initNavigationBar
{
    self.navigationController.navigationBarHidden = YES;
    view_bar =[[UIView alloc]init];
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
    view_bar.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:view_bar];
    UILabel *title_label=[[UILabel alloc]initWithFrame:CGRectMake(65, view_bar.frame.size.height-44, self.view.frame.size.width-130, 44)];
    title_label.text=@"图片";
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
    
    
    UIButton*btnHome=[UIButton buttonWithType:0];
    btnHome.frame=CGRectMake(view_bar.frame.size.width-55, view_bar.frame.size.height-40, 47, 34);
    [btnHome setImage:BundleImage(@"shop_zy_.png") forState:0];
    [btnHome addTarget:self action:@selector(btnHome:) forControlEvents:UIControlEventTouchUpInside];
    [view_bar addSubview:btnHome];
    
    
    
    return view_bar;
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
-(void)initScrollView
{
    arrayImages=[[NSMutableArray alloc]init];
    arrayTitle=[[NSArray alloc]initWithObjects:_expain, nil];
//    for (int i =0; i<[_urlArray count]; i++)
//    {
//        NSString*url1=[NSString stringWithFormat:@"%@/%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"currentUrl"],[_urlArray objectAtIndex:i ]];
//        [arrayImages addObject:[NSURL URLWithString:url1]];
//    }
//    pageCount=[arrayImages count];
      pageCount=3;
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0,view_bar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-view_bar.frame.size.height)];
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * pageCount,_scrollView.frame.size.height);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.scrollsToTop = NO;
    _scrollView.delegate = self;
    _scrollView.backgroundColor=[UIColor whiteColor];
    _scrollView.userInteractionEnabled=YES;
    textView=[[UITextView alloc]initWithFrame:CGRectMake(5,10, 320-80, 60)];
    textView.backgroundColor=[UIColor clearColor];
    textView.alpha=1.0;
    textView.font=[UIFont systemFontOfSize:14];
    textView.textColor=[UIColor whiteColor];
    textView.showsVerticalScrollIndicator=YES;
    textView.showsHorizontalScrollIndicator=YES;
    textView.scrollEnabled=YES;
    textView.bouncesZoom=YES;
    textView.canCancelContentTouches=YES;
    textView.clearsContextBeforeDrawing=YES;
    textView.userInteractionEnabled=YES;
    textView.delegate=self;
    textView.editable=NO;
//    textView.text=[arrayTitle objectAtIndex:0];
    UIView *view=[[UIScrollView alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height-90,320 , 180)];
    [ view addSubview:[[UIImageView alloc]initWithImage:BundleImage(@"black_transparentbg.png")]];
    [view addSubview:textView];
    view.userInteractionEnabled=YES;
    label=[[UILabel alloc]initWithFrame:CGRectMake(view.frame.size.width-65, 50, 50, 20)];
    
    label.textAlignment=1;
    label.backgroundColor=[UIColor clearColor];
    label.textColor=[UIColor whiteColor];
    label.text=[NSString stringWithFormat:@"%d/%d",1 ,pageCount];
    [view  addSubview:label];
    priceLabel=[[UILabel alloc]init];
    priceLabel.frame=CGRectMake(320-75, 10, 70, 20);
    priceLabel.backgroundColor=[UIColor clearColor];
    priceLabel.textAlignment=1;
    priceLabel.font=[UIFont systemFontOfSize:14];
    priceLabel.textColor=[UIColor redColor];
    priceLabel.text=[NSString stringWithFormat:@"¥%.2f",[_price floatValue]];
    
    [view addSubview:priceLabel];
    
    for (int i =0; i<pageCount; i++)
    {
        imageView=[[[UrlImageView alloc]init] autorelease];
        imageView.frame=CGRectMake(_scrollView.frame.size.width*i, 0,_scrollView.frame.size.width, _scrollView.frame.size.height);
        imageView.userInteractionEnabled =YES;
//        [imageView setImageWithURL:[arrayImages objectAtIndex:i]];
        imageView.tag=100+i;
        [imageView setContentMode:UIViewContentModeTop];
        [_scrollView addSubview:imageView];
    }
    [self.view addSubview:_scrollView];
    [self.view insertSubview:view aboveSubview: _scrollView];
    
    [view release];
    
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    
    if (floor((scrollView.contentOffset.x - 320/2) / 320) + 1)
    {
        label.text=[NSString stringWithFormat:@"%.0f/%d",(floor((scrollView.contentOffset.x) / 320)+1) ,pageCount];
        
        
    }
    
}
//-(void)addShopCar
//{
//    
//    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"verify"]==nil)
//    {
//        //        [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowLoginVC" object:nil];
//        FCLogonViewController *viewController;
//        viewController = [[FCLogonViewController alloc] initWithBool:NO];
//        [self.navigationController pushViewController:viewController animated:YES];
//        
//    }
//    else {
//        
//        [[GlobalTool sharedGlobalTool] getAppData];
//        NSArray *array=[[NSArray alloc] initWithObjects:
//                        [NSString stringWithFormat:@"deviceid=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"deviceid"]],
//                        [NSString stringWithFormat:@"bussnessid=%@",[GlobalTool sharedGlobalTool].bussesid],
//                        [NSString stringWithFormat:@"verify=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"verify"]],
//                        [NSString stringWithFormat:@"appid=%@",[GlobalTool sharedGlobalTool].apkid],
//                        [NSString stringWithFormat:@"productid=%@",_productid ],
//                        [NSString stringWithFormat:@"number=1"],
//                        [NSString stringWithFormat:@"userid=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userid"]],nil];
//        UpdateOne*upda=[[UpdateOne alloc]init:@"FWShopCarInsert" :array delegate:self];
//        [DataManager loadData:[[NSArray alloc]initWithObjects:upda, nil] delegate:self];
//    }
//}
//-(void)disposMessage:(Son *)son
//{
//    if ([son.getMethod isEqualToString:@"FWShopCarInsert"])
//    {
//        if (son.getError==0)
//        {
//            
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"加入购物车" message:@"商品己成功加入购物车！" delegate:self cancelButtonTitle:@"继续购物" otherButtonTitles:@"去购物车", nil];
//            alert.tag = 1000;
//            [alert show];
//            [alert release];
//        }
//    }
//}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1000)
    {
        if (buttonIndex == 1)
        {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowTabbar" object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ShopCar" object:nil];
            
        }
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor blackColor];
	[self initNavigationBar];
    [self initScrollView];
    
}

#pragma mark按钮事件
-(void)btnPress:(id)sender
{
    
    
}
-(void)btnCar:(id)sender
{
//    [self addShopCar];
    //    FCShoppingCarViewController *rootViewController =[[FCShoppingCarViewController   alloc]init];
    //
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowTabbar" object:nil];
    //    [self.navigationController pushViewController:rootViewController animated:YES];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
