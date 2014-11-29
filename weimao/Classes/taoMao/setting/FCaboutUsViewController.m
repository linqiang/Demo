//
//  FCaboutUsViewController.m
//  FCset
//
//  Created by Skyler on 13-6-24.
//  Copyright (c) 2013年 SK. All rights reserved.
//

#import "FCaboutUsViewController.h"

@interface FCaboutUsViewController ()

@end

@implementation FCaboutUsViewController


-(UIView*)initNavigationBar
{
    
    UIView *view_bar =[[UIView alloc]init];
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
        [imageV release];
    }
    view_bar.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview: view_bar];
    UILabel *title_label=[[UILabel alloc]initWithFrame:CGRectMake(65, view_bar.frame.size.height-44, self.view.frame.size.width-130, 44)];
    title_label.text=@"关于我们";
    title_label.font=[UIFont systemFontOfSize:20];
    title_label.backgroundColor=[UIColor clearColor];
    title_label.textColor =[UIColor whiteColor];
    title_label.textAlignment=1;
    [view_bar addSubview:title_label];
//    UIImageView *_line=[[UIImageView alloc]initWithFrame:CGRectMake(0, view_bar.frame.size.height-1, 320, 1)];
//    _line.image=[UIImage imageNamed:@"xianxain.png"];
//    [view_bar addSubview:_line];
    UIButton*btnBack=[UIButton buttonWithType:0];
    btnBack.frame=CGRectMake(0, view_bar.frame.size.height-44, 47, 44);
    [btnBack setImage:BundleImage(@"ret_01.png") forState:0];
    [btnBack addTarget:self action:@selector(btnBack:) forControlEvents:UIControlEventTouchUpInside];
    [view_bar addSubview:btnBack];
    
    [self.view addSubview:view_bar];
    [title_label release];
    [view_bar release];
    
    return view_bar;
}

- (void)btnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.view setBackgroundColor:[UIColor colorWithRed:.98 green:.98 blue:.98 alpha:1.0]];
    [self initNavigationBar];
    TMAppDelegate *app = (TMAppDelegate *)[UIApplication sharedApplication].delegate;
    [app startLoading];
    
    NSString *parmeters1=[NSString stringWithFormat:@"company=%@",COMPANY_NAME];
//    [[RequestServer instance] doActionAsync:0 withAction:@"/mobile/aboutus/mlist?" withParameters:parmeters1 withDelegate:self];
    
//    [self colection];
}

-(void)requestFinished:(NSNumber *)code withMessage:(NSString *)message withData:(id)data
{
    if([message isEqualToString:@""] || message == nil)
    {
        ShowMessage(@"网络连接错误!");
        return;
    }
    UIWebView *webView = [[UIWebView alloc] init];
    if([[[UIDevice currentDevice]systemVersion]floatValue]>6.1)
    {
        webView.frame = CGRectMake(0, 64, 320, self.view.frame.size.height-64);
    }
    else
    {
        webView.frame = CGRectMake(0, 64, 320, self.view.frame.size.height-44);
    }
    [self.view addSubview:webView];
    [webView sizeToFit];
    if(data&&data!=nil )
    {
        NSString *str = [data objectForKey:@"content"];
        [webView loadHTMLString:str baseURL:nil];
    }
    [webView release];
    TMAppDelegate *app = (TMAppDelegate *)[UIApplication sharedApplication].delegate;
    [app stopLoading];
}

-(void)colection
{
//    [[GlobalTool sharedGlobalTool] getAppData];
//    
//    NSArray *array=[[NSArray alloc] initWithObjects:
//                    [NSString stringWithFormat:@"deviceid=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"deviceid"]],
//                    [NSString stringWithFormat:@"bussnessid=%@",[GlobalTool sharedGlobalTool].bussesid],
//                    [NSString stringWithFormat:@"verify=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"verify"]],
//                    [NSString stringWithFormat:@"appid=%@",[GlobalTool sharedGlobalTool].apkid],
//                    [NSString stringWithFormat:@"userid=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userid"]],nil];
//
//    UpdateOne*upda=[[UpdateOne alloc]init:@"FWMerchant":array delegate:self];
//    [DataManager loadData:[[NSArray alloc]initWithObjects:upda, nil] delegate:self];
    
}

//-(void)disposMessage:(Son *)son
//{
//    
//    if ([son.getMethod isEqualToString:@"FWMerchant"])
//    {
//        Msg_FW_Merchant_Builder*  checkOut=(Msg_FW_Merchant_Builder*)[son getBuild];
//        [self buildContent:checkOut];
//    }
//}
-(BOOL)showLoading{
    return YES;
}

-(BOOL)closeLoading{
    return YES;
}
//- (void)buildContent:(Msg_FW_Merchant_Builder *)sender
//{
//    UrlImageView * img_logo = [[UrlImageView alloc]initWithFrame:CGRectMake(100, 50, 120, 120)];
//    NSString * str = [NSString stringWithFormat:@"%@/%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"currentUrl"],sender.logo];
//    NSURL * url = [NSURL URLWithString:str];
//    if (url==nil)
//    {
//        [img_logo setImage:BundleImage(@"pic_message.png")];
//    }else{
//    
//        [img_logo setImageWithURL:url];
//    }
//
// 
//    [self.view addSubview:img_logo];
// 
//    [self addLabel:@"相守是一种承诺，人世轮回中，怎样才能拥有一份温柔的情意。"];
//
//    [self addLabel:CGRectMake(17, 250, 100, 17) view:self.view font:17 text:@"联系我们" backgroudcolor:[UIColor clearColor] textcolor:[UIColor blackColor]];
//    [self addLabel:CGRectMake(17, 277, 70, 16) view:self.view font:16 text:@"联系人：" backgroudcolor:[UIColor clearColor] textcolor:[UIColor blackColor]];
//    [self addLabel:CGRectMake(17, 302, 90, 16) view:self.view font:16 text:@"联系电话：" backgroudcolor:[UIColor clearColor] textcolor:[UIColor blackColor]];
//    [self addLabel:CGRectMake(17, 327, 70, 16) view:self.view font:16 text:@"地址：" backgroudcolor:[UIColor clearColor] textcolor:[UIColor blackColor]];
//    
//    
//    [self addLabel:CGRectMake(80, 277, 170, 16) view:self.view font:16 text:sender.linkman backgroudcolor:[UIColor clearColor] textcolor:[UIColor blackColor]];
//    [self addLabel:CGRectMake(95, 302, 190, 16) view:self.view font:16 text:sender.phone backgroudcolor:[UIColor clearColor] textcolor:[UIColor blackColor]];
//    [self addLabel:CGRectMake(65, 327, 230, 16) view:self.view font:16 text:sender.address backgroudcolor:[UIColor clearColor] textcolor:[UIColor blackColor]];
//    
//    
//    
//
//}

- (UILabel *)addLabel:(CGRect)frame view:(UIView*)view font:(CGFloat)font text:(NSString *)text backgroudcolor:(UIColor *)bcolor textcolor:(UIColor*)tcolor
{
    UILabel * lb = [[UILabel alloc]initWithFrame:frame];
    [lb setFont:[UIFont systemFontOfSize:font]];
    [lb setTextColor:tcolor];
    [lb setText:text];
    lb.numberOfLines=0;
    [lb sizeToFit];
    [lb setBackgroundColor:bcolor];
    [view addSubview:lb];
    return lb;
}

- (void)addLabel:(NSString *)text
{
    //标题的大小由传过来的信息的大小决定
    UILabel * lb_title = [[[UILabel alloc] init]autorelease];
    lb_title.text = text;
    lb_title.numberOfLines = 0;
    lb_title.backgroundColor = [UIColor clearColor];
    lb_title.font = [UIFont fontWithName:@"Helvetica" size:15.0];
    CGRect rect = CGRectInset(CGRectMake(10, 180, 300, 120), 8, 8);
    lb_title.frame = rect;
    [lb_title adjustsFontSizeToFitWidth];
    [lb_title sizeToFit];
    lb_title.textAlignment = 0;
    [self.view addSubview:lb_title];
}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
