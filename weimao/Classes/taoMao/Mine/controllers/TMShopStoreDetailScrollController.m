//
//  TMShopStoreDetailScrollController.m
//  TaoMao
//
//  Created by mac on 14-4-18.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "TMShopStoreDetailScrollController.h"
#import "TMGoodsDetailsViewController.h"
@interface TMShopStoreDetailScrollController ()
{
    UIView*naviView;
    UIView *headView;
}
@end

@implementation TMShopStoreDetailScrollController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(UIView*)initNavigationBar
{
    self.navigationController.navigationBarHidden = YES;
    UIView *view_bar =[[UIView alloc]init];
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
    title_label.text=@"清新部落";
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
-(void)call:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"13910000000" message:@"确认要拨打电话吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    alert.tag = 1001;
    [alert show];
    [alert release];
    
    
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1000)
    {
        if (buttonIndex == 1)
            
        {
   
        }
    }
    if (alertView.tag==1001)
    {
        if (buttonIndex == 0)
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",@"13910000000"]]];
        }
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    naviView=(UIView*)[self initNavigationBar];
    UrlImageButton *btnTow;
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, naviView.frame.size.height, 320, self.view.frame.size.height)];
    _scrollView.delegate = self;
    _scrollView.userInteractionEnabled=YES;
    _scrollView.contentSize=CGSizeMake(320, self.view.frame.size.height);
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.backgroundColor=[UIColor whiteColor];
    _scrollView.contentInset=UIEdgeInsetsMake(0, 0, 0, 0);
    [self.view addSubview:_scrollView];


    [self initHeadView];
    
    UrlImageView *imageV;   //底图为了描边
    for (int i =0; i<11; i++)
    {
        imageV=[[UrlImageView alloc]initWithFrame:CGRectMake((i%2)*153+13, floor(i/2)*200+13+headView.frame.size.height, 140, 140)];
        imageV.backgroundColor=[UIColor redColor];
        imageV.userInteractionEnabled=YES;
        //            btn.layer.shadowOffset = CGSizeMake(1,1);
        //            btn.layer.shadowOpacity = 0.2f;
        //            btn.layer.shadowRadius = 3.0;
        imageV.layer.borderWidth=1;//描边
        imageV.layer.cornerRadius=4;//圆角
        imageV.layer.borderColor=[UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1.0].CGColor;
        imageV.backgroundColor=[UIColor whiteColor];
        
        [_scrollView addSubview:imageV];
        
        UrlImageButton*btn=[[UrlImageButton alloc]initWithFrame:CGRectMake(2, 2, 140-4, 140-4)];
        btn.userInteractionEnabled=YES;
        btn.layer.borderWidth=1;//描边
        btn.layer.cornerRadius=4;//圆角
        btn.layer.borderColor=[UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1.0].CGColor;
        btn.backgroundColor=[UIColor whiteColor];
        [btn setBackgroundImage:BundleImage(@"df_04_.png") forState:0];
        [btn addTarget:self action:@selector(btnGoShop:) forControlEvents:UIControlEventTouchUpInside];
        //            [imageV addSubview:btn];
        [imageV insertSubview:btn aboveSubview:imageV];
        
        UILabel *_label=[[UILabel alloc]initWithFrame:CGRectMake((i%2)*153+13, floor(i/2)*200+10+140+headView.frame.size.height, 140, 40)];
        _label.text=@"原创春夏新款/立体清新花片欧根纱拼接双层波浪领衬衫";
        _label.font=[UIFont boldSystemFontOfSize:14];
        _label.backgroundColor=[UIColor clearColor];
        _label.textColor =[UIColor colorWithRed:.5 green:.5 blue:.5 alpha:1.0];
        _label.numberOfLines=2;
        _label.textAlignment=0;
        
        [_scrollView addSubview:_label];
        
        
        //            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 20, 15)];
        //            label.font = [UIFont boldSystemFontOfSize:10.0f];  //UILabel的字体大小
        //            label.numberOfLines = 0;  //必须定义这个属性，否则UILabel不会换行
        //            label.textColor = [UIColor grayColor];
        //            label.textAlignment = NSTextAlignmentCenter;  //文本对齐方式
        //            [label setBackgroundColor:[UIColor whiteColor]];
        //
        //            //高度固定不折行，根据字的多少计算label的宽度
        //            NSString *str = @"高度";
        //            CGSize size = [str sizeWithFont:label.font constrainedToSize:CGSizeMake(MAXFLOAT, label.frame.size.height)];
        //            //        NSLog(@"size.width=%f, size.height=%f", size.width, size.height);
        //            //根据计算结果重新设置UILabel的尺寸
        //            [label setFrame:CGRectMake((70-size.width)/2, 52, size.width+4, 15)];
        //            label.text = str;
        
        
        UILabel *title_label=[[UILabel alloc]initWithFrame:CGRectMake((i%2)*153+13, floor(i/2)*200+140+10+_label.frame.size.height+headView.frame.size.height, 65, 20)];
        title_label.text=@"￥199.00";
        title_label.font=[UIFont systemFontOfSize:12];
        title_label.backgroundColor=[UIColor clearColor];
        title_label.textColor =hongShe;
        title_label.textAlignment=0;
        
        //
        [_scrollView addSubview:title_label];
        
        UILabel *title_label1=[[UILabel alloc]initWithFrame:CGRectMake((i%2)*153+13+title_label.frame.size.width, floor(i/2)*200+140+10+_label.frame.size.height+headView.frame.size.height, 65, 20)];
        title_label1.text=@"199.70";
        title_label1.font=[UIFont systemFontOfSize:10];
        title_label1.backgroundColor=[UIColor clearColor];
        title_label1.textColor =[UIColor colorWithRed:.7 green:.7 blue:.7 alpha:1.0];
        title_label1.textAlignment=0;
        
        [_scrollView addSubview:title_label1];
        
        //高度固定不折行，根据字的多少计算label的宽度
        NSString *str = title_label1.text;
        CGSize size = [str sizeWithFont:title_label.font constrainedToSize:CGSizeMake(MAXFLOAT, title_label.frame.size.height)];
        //                     NSLog(@"size.width=%f, size.height=%f", size.width, size.height);
        //根据计算结果重新设置UILabel的尺寸
        
        
        UIImageView *line=[[UIImageView alloc]initWithFrame:CGRectMake(0, title_label1.frame.size.height/2, size.width, 1)];
        line.image=BundleImage(@"line_01_.png");
        [title_label1 addSubview:line];
        [line release];
        
    }
    [_scrollView setContentSize:CGSizeMake(320, (floor(11/2)+1)*200+90+headView.frame.size.height)];

}
-(void)btnGo:(id)sender
{
    
    
    
}
-(void)initHeadView
{
    headView=[[UIView alloc]initWithFrame:CGRectMake(0,0 , self.view.frame.size.width, 130)];
    headView.backgroundColor=[UIColor clearColor];
    [_scrollView addSubview:headView];
    //title_label是中间分隔阴影
    UILabel *title_label=[[UILabel alloc]initWithFrame:CGRectMake(-2, headView.frame.size.height-15, self.view.frame.size.width+4, 15)];

    title_label.textAlignment=1;
    title_label.backgroundColor=[UIColor colorWithRed:1.0 green:.998 blue:.998 alpha:1.0 ];
    title_label.layer.borderWidth=1;
    title_label.layer.borderColor=[UIColor colorWithRed:.8 green:.8 blue:.8 alpha:1.0].CGColor;
 
    [headView addSubview:title_label];
    
    
    UrlImageView*imageV=[[UrlImageView alloc]initWithFrame:CGRectMake(13, 13, 25, 25)];
    imageV.image=BundleImage(@"ic_shop_.png");
    [headView addSubview:imageV];
    
    UIButton *callBtn=[UIButton buttonWithType:0];
    callBtn.frame=CGRectMake(self.view.frame.size.width-90, 13,75 , 25);
    [callBtn addTarget:self action:@selector(call:) forControlEvents:UIControlEventTouchUpInside];
    [callBtn setImage:BundleImage(@"bt_01_n.png") forState:0];
    [headView addSubview:callBtn];
    
    
    UILabel *title_label2=[[UILabel alloc]initWithFrame:CGRectMake(13, imageV.frame.size.height+imageV.frame.origin.y+10, 80, 15)];
    title_label2.text=@"宝贝数量:";
    title_label2.font=[UIFont systemFontOfSize:16];
    title_label2.backgroundColor=[UIColor clearColor];
    title_label2.textColor =[UIColor colorWithRed:.6 green:.6 blue:.6 alpha:1.0];
    title_label2.textAlignment=0;

    [headView addSubview:title_label2];

    
    UILabel *title_label3=[[UILabel alloc]initWithFrame:CGRectMake(title_label2.frame.size.width+title_label2.frame.origin.x, title_label2.frame.origin.y, 70, 15)];
    title_label3.text=@"318";
    
    title_label3.font=[UIFont systemFontOfSize:16];
    title_label3.backgroundColor=[UIColor clearColor];
    title_label3.textColor =hongShe;
    title_label3.textAlignment=0;
    
    [headView addSubview:title_label3];
    
    UILabel *title_label4=[[UILabel alloc]initWithFrame:CGRectMake(title_label3.frame.size.width+title_label3.frame.origin.x+5,title_label2.frame.origin.y,80, 15)];
    title_label4.text=@"销售数量:";
    title_label4.font=[UIFont systemFontOfSize:16];
    title_label4.backgroundColor=[UIColor clearColor];
    title_label4.textColor =[UIColor colorWithRed:.6 green:.6 blue:.6 alpha:1.0];
    title_label4.textAlignment=0;
    
    [headView addSubview:title_label4];
    
    UILabel *title_label5=[[UILabel alloc]initWithFrame:CGRectMake(title_label4.frame.size.width+title_label4.frame.origin.x, title_label2.frame.origin.y,70, 15)];
    title_label5.text=@"12345";
    title_label5.font=[UIFont systemFontOfSize:16];
    title_label5.backgroundColor=[UIColor clearColor];
    title_label5.textColor =hongShe;
    title_label5.textAlignment=0;
    
    [headView addSubview:title_label5];
    
    
    UILabel *title_label6=[[UILabel alloc]initWithFrame:CGRectMake(13, title_label2.frame.size.height+title_label2.frame.origin.y+10, 200, 15)];
    title_label6.text=@"主营时装女装";
    title_label6.font=[UIFont systemFontOfSize:16];
    title_label6.backgroundColor=[UIColor clearColor];
    title_label6.textColor =[UIColor colorWithRed:.6 green:.6 blue:.6 alpha:1.0];
    title_label6.textAlignment=0;
    
    [headView addSubview:title_label6];

    
}

-(void)btnHome:(id)sender
{

    [[NSNotificationCenter defaultCenter] postNotificationName:@"backHome" object:nil];
}
-(void)btnGoShop:(id)sender
{
    TMGoodsDetailsViewController *shop=[[TMGoodsDetailsViewController alloc]init];
    TMAppDelegate *delegate=(TMAppDelegate*)[UIApplication sharedApplication].delegate;
    [delegate.navigationController pushViewController:shop animated:YES];
    
}
-(void)btnBack:(id)sender
{
    TMAppDelegate *app=(TMAppDelegate*)[UIApplication sharedApplication].delegate;
    [app.navigationController popViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
