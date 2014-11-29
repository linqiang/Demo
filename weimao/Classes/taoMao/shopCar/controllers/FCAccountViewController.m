//
//  FCAccountViewController.m
//  Flower&Cake
//
//  Created by 123 on 13-7-11.
//  Copyright (c) 2013年 . All rights reserved.
//

#import "FCAccountViewController.h"
//#import "FCSubmitViewController.h"//结算
//#import "FCdeliveryAddressViewController.h"//收货地址
#import "FCPaymentViewController.h"//支付方式
#import "TMAddAddressViewController.h"
//#import "FCDeliverTimeViewController.h"//送货时间
//#import "FCFreightViewController.h"//运费
//#import "FCGoodsDetailViewController.h" //  商品明细
//#import "FCSendWordViewController.h"//寄语
//#import "FCTicketViewController.h"//优惠券
#import "TMAccountWINViewController.h"
#import "TMAditAddressViewController.h"

@interface FCAccountViewController ()

@end

@implementation FCAccountViewController

-(void)dealloc
{
    [_payment release];
    [labelTitle release];
    [title_label1 release];
    [gradeLabel release];
    [_sendTime release];
    [_stringAddress release];
    [_stringFreight release];
    [_stringWish release];
    [_marrayTitleDetail release];
    [_marrayTitle release];
    [_stringWish release];
    [textView release];
    [_tableView release];
  
    [super dealloc];
}

-(id)initWithProduct:(NSArray*)arrayProduct  withSalesNumAndPrices:(NSDictionary*)salesAndPrices
{
    self=[super init];
    if (self)
    {
        _arrayProduct=[[NSArray alloc]init];
        _arrayProduct= [arrayProduct retain];
        _salesAndPrices =[NSDictionary dictionary];
        _salesAndPrices= [[NSDictionary dictionaryWithDictionary:salesAndPrices] retain];
    }
//    NSLog(@"%@",_salesAndPrices);
    NSArray*arraySales=  [_salesAndPrices objectForKey:@"salesNum"];
    NSArray*countPrice=  [_salesAndPrices objectForKey:@"countPrice"];
    
    for (int i=0; i<[arraySales count]; i++)
    {
        priceCount=[[countPrice objectAtIndex:i] floatValue]+priceCount ;
    }
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%f",priceCount] forKey:@"priceCount"];
    
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{

    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"dizhi"]);
    
    [self initHeaderView];
    [self initFooterView];
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    _marrayAll=[[NSMutableArray alloc]init];
    _freightAll=[[NSMutableArray alloc]init];
    [self initNavigationBar];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"freight"]; //运费
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"address"];//地址
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"wishWord"] ;//贺词
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"sendTime"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"payment"];
  
    
//    _marrayTitle=[[NSMutableArray alloc]initWithObjects:@"收货地址",@"支付方式",@"运费",@"送货时间",@"贺卡寄语",@"商品明细", nil];
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0,  view_bar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-view_bar.frame.size.height)style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.backgroundView=nil;
    _tableView.separatorColor=[UIColor clearColor];
    _tableView.backgroundColor=[UIColor colorWithRed:.96 green:.96 blue:.96 alpha:1.0];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.showsVerticalScrollIndicator=NO;
    
    [self.view addSubview:_tableView];
   
 
}
-(void)initHeaderView
{
    _tableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.height, 165)];
    _tableView.tableHeaderView.backgroundColor=[UIColor clearColor];
    //收货人信息
    btn1=[[UrlImageButton alloc]initWithFrame:CGRectMake(0, 15, self.view.frame.size.width, 40)];
    [btn1 addTarget:self action:@selector(payment:) forControlEvents:UIControlEventTouchUpInside];
    //    btn1.layer.borderWidth=1;
    //    btnNine1.layer.cornerRadius = 4;
    //    btnNine1.titleLabel.font=[UIFont systemFontOfSize:14];
    btn1.layer.borderColor=[UIColor colorWithRed:.8 green:.8 blue:.8 alpha:1.0].CGColor;
    btn1.backgroundColor=[UIColor clearColor];
    [btn1 setImage:BundleImage(@"ddqr_01.png") forState:0];
    [_tableView.tableHeaderView addSubview:btn1];
    
    UIImageView*imgv1=[[UIImageView alloc]initWithFrame:CGRectMake(10, 40/2-18/2, 18, 19)];
    imgv1.image=BundleImage(@"dd_card.png");
    [btn1 addSubview:imgv1];
    [imgv1 release];
    
    title_label1=[[UILabel alloc]initWithFrame:CGRectMake(imgv1.frame.size.width+imgv1.frame.origin.x+5, 40/2-20/2, 250, 20)];
    if ([[NSUserDefaults standardUserDefaults ]objectForKey:@"zhifufangshi"]==nil)
    {
        title_label1.text=@"请选择支付方式";
    }else{
        title_label1.text=[[NSUserDefaults standardUserDefaults ]objectForKey:@"zhifufangshi"];
    }
 
    title_label1.font=[UIFont systemFontOfSize:12];
    title_label1.backgroundColor=[UIColor clearColor];
    title_label1.textColor =hui2;
    title_label1.textAlignment=0;
    [btn1 addSubview:title_label1];
 

    UIImageView*imgvJT=[[UIImageView alloc]initWithFrame:CGRectMake(btn1.frame.size.width-45, 0, 45, 40)];
    imgvJT.image=BundleImage(@"gbt_04_.png");
    [btn1 addSubview:imgvJT];
    [imgvJT release];
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"dizhi"]isEqualToString:@"yes"])
    {
        [btn2 removeFromSuperview];
        btn2=[[UrlImageButton alloc]initWithFrame:CGRectMake(0, btn1.frame.size.height+btn1.frame.origin.y, self.view.frame.size.width, 70)];
        btn2.layer.borderColor=[UIColor colorWithRed:.8 green:.8 blue:.8 alpha:1.0].CGColor;
        
        [btn2 addTarget:self action:@selector(address:) forControlEvents:UIControlEventTouchUpInside];
        btn2.backgroundColor=[UIColor clearColor];
        [btn2 setImage:BundleImage(@"fhdd_bg.png") forState:0];
        
        [_tableView.tableHeaderView addSubview:btn2];
        
        
        UIImageView *imgSJR=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 15, 15)];
        imgSJR.image=BundleImage(@"dicon_02.png");
        [btn2 addSubview:imgSJR];
        UILabel *labelSJR=[[UILabel alloc]initWithFrame:CGRectMake(imgSJR.frame.origin.x+imgSJR.frame.size.width+5, imgSJR.frame.origin.y, 130, 15)];
        
        labelSJR.text=[NSString stringWithFormat:@"收件人:%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"shoujianren"]];
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"shoujianren"]);
        
        labelSJR.font=[UIFont systemFontOfSize:12];
        labelSJR.backgroundColor=[UIColor clearColor];
        labelSJR.textColor =hui3;
        labelSJR.textAlignment=0;

        [btn2 addSubview:labelSJR];
        
        UIImageView *imgDH=[[UIImageView alloc]initWithFrame:CGRectMake(labelSJR.frame.size.width+labelSJR.frame.origin.x+5, 10, 10, 15)];
        imgDH.image=BundleImage(@"dicon_03.png");
        [btn2 addSubview:imgDH];
        
        UILabel *labelDH=[[UILabel alloc]initWithFrame:CGRectMake(imgDH.frame.origin.x+imgDH.frame.size.width+5, imgDH.frame.origin.y, 110, 15)];
        
        labelDH.text=[NSString stringWithFormat:@"电话:%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"lianxidianhua"]];
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"lianxidianhua"]);
        
        labelDH.font=[UIFont systemFontOfSize:12];
        labelDH.backgroundColor=[UIColor clearColor];
        labelDH.textColor =hui3;
        labelDH.textAlignment=0;
        
        [btn2 addSubview:labelDH];
        
        UIImageView *imgDZ=[[UIImageView alloc]initWithFrame:CGRectMake(imgSJR.frame.origin.x, imgSJR.frame.origin.y+imgSJR.frame.size.height+10, 15, 15)];
        imgDZ.image=BundleImage(@"dicon_04.png");
        [btn2 addSubview:imgDZ];
        
        UILabel *labelDZ=[[UILabel alloc]initWithFrame:CGRectMake(imgDZ.frame.origin.x+imgDZ.frame.size.width+5, imgDZ.frame.origin.y, 260, 30)];
        
        labelDZ.text=[NSString stringWithFormat:@"收件地址：%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"shoujiandizhi"]];
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"shoujiandizhi"]);
        
        labelDZ.font=[UIFont systemFontOfSize:12];
        labelDZ.backgroundColor=[UIColor clearColor];
        labelDZ.textColor =hui3;
        labelDZ.textAlignment=0;
        labelDZ.numberOfLines=2;
        [labelDZ sizeToFit];
        [btn2 addSubview:labelDZ];

        UIImageView*imgvJT1=[[UIImageView alloc]initWithFrame:CGRectMake(btn2.frame.size.width-45, (btn2.frame.size.height-40)/2, 45, 40)];
        imgvJT1.image=BundleImage(@"gbt_04_.png");
        [btn2 addSubview:imgvJT1];
        [imgvJT1 release];
        
        UIImageView *_line=[[UIImageView alloc]initWithFrame:CGRectMake(0, btn2.frame.size.height-1, 320, 1)];
        _line.image=[UIImage imageNamed:@"line_01_.png"];
        [btn2 addSubview:_line];
        [_line release];
        
    }else{
    

    
        btn2=[[UrlImageButton alloc]initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, 40)];
        btn2.layer.borderColor=[UIColor colorWithRed:.8 green:.8 blue:.8 alpha:1.0].CGColor;
        [btn2 addTarget:self action:@selector(address:) forControlEvents:UIControlEventTouchUpInside];
        btn2.backgroundColor=[UIColor clearColor];
        [btn2 setImage:BundleImage(@"ddqr_01.png") forState:0];
        [_tableView.tableHeaderView addSubview:btn2];
        
        imgv2=[[UIImageView alloc]initWithFrame:CGRectMake(10, 40/2-18/2, 18, 19)];
        imgv2.image=BundleImage(@"dd_address.png");
        [btn2 addSubview:imgv2];
        [imgv2 release];
        UILabel *title_label2=[[UILabel alloc]initWithFrame:CGRectMake(imgv2.frame.size.width+imgv2.frame.origin.x+5, 40/2-20/2, 250, 20)];
        title_label2.text=@"请填写收货人信息";
        title_label2.font=[UIFont systemFontOfSize:12];
        title_label2.backgroundColor=[UIColor clearColor];
        title_label2.textColor =hui2;
        title_label2.textAlignment=0;
        [btn2 addSubview:title_label2];
        
        UIImageView*imgvJT1=[[UIImageView alloc]initWithFrame:CGRectMake(btn1.frame.size.width-45, 0, 45, 40)];
        imgvJT1.image=BundleImage(@"gbt_04_.png");
        [btn2 addSubview:imgvJT1];
        [imgvJT1 release];

    }
        UrlImageButton*btn3=[[UrlImageButton alloc]initWithFrame:CGRectMake(0, 125, self.view.frame.size.width, 40)];
    btn3.layer.borderColor=[UIColor colorWithRed:.8 green:.8 blue:.8 alpha:1.0].CGColor;
    btn3.backgroundColor=[UIColor clearColor];
    [btn3 setImage:BundleImage(@"ddqr_01.png") forState:0];
    [_tableView.tableHeaderView addSubview:btn3];
    
    
    UIImageView*imgv3=[[UIImageView alloc]initWithFrame:CGRectMake(10, 40/2-18/2, 18, 19)];
    imgv3.image=BundleImage(@"dd_store.png");
    [btn3 addSubview:imgv3];
    [imgv3 release];
    
    UILabel *title_label3=[[UILabel alloc]initWithFrame:CGRectMake(imgv3.frame.size.width+imgv3.frame.origin.x+5, 40/2-20/2, 30, 20)];
    title_label3.text=@"商家";
    title_label3.font=[UIFont systemFontOfSize:12];
    title_label3.backgroundColor=[UIColor clearColor];
    title_label3.textColor =hui2;
    title_label3.textAlignment=0;
    [btn3 addSubview:title_label3];
    
    UILabel *title_label4=[[UILabel alloc]initWithFrame:CGRectMake(title_label3.frame.size.width+title_label3.frame.origin.x+5, 40/2-20/2, 120, 20)];
    title_label4.text=@"莎儿家";
    title_label4.font=[UIFont systemFontOfSize:14];
    title_label4.backgroundColor=[UIColor clearColor];
    title_label4.textColor =hongShe;
    title_label4.textAlignment=0;
    [btn3 addSubview:title_label4];
    
    UILabel *title_label5=[[UILabel alloc]initWithFrame:CGRectMake(title_label4.frame.size.width+title_label4.frame.origin.x+50, 40/2-20/2, 80, 20)];
    title_label5.text=@"共:3件";
    title_label5.font=[UIFont systemFontOfSize:12];
    title_label5.backgroundColor=[UIColor clearColor];
    title_label5.textColor =hui2;
    title_label5.textAlignment=0;
    [btn3 addSubview:title_label5];
    

    [_tableView addSubview:_tableView.tableHeaderView];
    
}
-(void)initFooterView
{
    
    _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 240)];
    _tableView.tableFooterView.backgroundColor=[UIColor whiteColor];
    [_tableView addSubview:_tableView.tableFooterView];
    
    UILabel *labelYF=[[UILabel alloc]initWithFrame:CGRectMake(20, 15, 40, 15)];
    labelYF.text=@"运费：";
    labelYF.font=[UIFont systemFontOfSize:12];
    labelYF.backgroundColor=[UIColor clearColor];
    labelYF.textColor =hui2;
    labelYF.textAlignment=0;
    [ _tableView.tableFooterView addSubview:labelYF];
    [labelYF release];
    
    UILabel *labelYFDetail=[[UILabel alloc]initWithFrame:CGRectMake(labelYF.frame.size.width+labelYF.frame.origin.x, labelYF.frame.origin.y, 150, 15)];
    labelYFDetail.text=@"免运费";
    labelYFDetail.font=[UIFont systemFontOfSize:12];
    labelYFDetail.backgroundColor=[UIColor clearColor];
    labelYFDetail.textColor =hongShe;
    labelYFDetail.textAlignment=0;
    [ _tableView.tableFooterView addSubview:labelYFDetail];
    [labelYFDetail release];
    
    UIImageView *_line=[[UIImageView alloc]initWithFrame:CGRectMake(10, labelYF.frame.size.height+labelYF.frame.origin.y+15, 310, 1)];
    _line.image=[UIImage imageNamed:@"line_01_.png"];
    [_tableView.tableFooterView addSubview:_line];
    [_line release];
    
    UILabel *title_label5=[[UILabel alloc]initWithFrame:CGRectMake(labelYFDetail.frame.size.width+labelYFDetail.frame.origin.x+5, labelYF.frame.origin.y, 30, 20)];
    title_label5.text=@"合计:";
    title_label5.font=[UIFont systemFontOfSize:12];
    title_label5.backgroundColor=[UIColor clearColor];
    title_label5.textColor =hui2;
    title_label5.textAlignment=0;
    [_tableView.tableFooterView addSubview:title_label5];
    [title_label5 release];
    
    UILabel *title_label6=[[UILabel alloc]initWithFrame:CGRectMake(title_label5.frame.size.width+title_label5.frame.origin.x, labelYF.frame.origin.y, 60, 20)];
    title_label6.text=@"￥97.70";
    title_label6.font=[UIFont systemFontOfSize:14];
    title_label6.backgroundColor=[UIColor clearColor];
    title_label6.textColor =hongShe;
    title_label6.textAlignment=0;
    [_tableView.tableFooterView addSubview:title_label6];
    [title_label6 release];

    UILabel *labelYH=[[UILabel alloc]initWithFrame:CGRectMake(20,_line.frame.size.height+_line.frame.origin.y+15, 60, 15)];
    labelYH.text=@"本店优惠：";
    labelYH.font=[UIFont systemFontOfSize:12];
    labelYH.backgroundColor=[UIColor clearColor];
    labelYH.textColor =hui2;
    labelYH.textAlignment=0;
    [ _tableView.tableFooterView addSubview:labelYH];
    [labelYH release];
    
    UILabel *labelYHDetail=[[UILabel alloc]initWithFrame:CGRectMake(labelYH.frame.size.width+labelYH.frame.origin.x,_line.frame.size.height+_line.frame.origin.y+15, 225, 15)];
    labelYHDetail.text=@"暂无可用优惠券";
    labelYHDetail.font=[UIFont systemFontOfSize:12];
    labelYHDetail.backgroundColor=[UIColor clearColor];
    labelYHDetail.textColor =hui2;
    labelYHDetail.textAlignment=2;
    [ _tableView.tableFooterView addSubview:labelYHDetail];
    [labelYHDetail release];
    
    UILabel *labelLY=[[UILabel alloc]initWithFrame:CGRectMake(20,labelYH.frame.size.height+labelYH.frame.origin.y+15, 300,15)];
    labelLY.text=@"给卖家留言：";
    labelLY.font=[UIFont boldSystemFontOfSize:12];
    labelLY.backgroundColor=[UIColor clearColor];
    labelLY.textColor =hui5;
    labelLY.textAlignment=0;
    [_tableView.tableFooterView addSubview:labelLY];
    [labelLY release];
    
    textView=[[UITextView alloc]initWithFrame:CGRectMake(10,labelLY.frame.size.height+labelLY.frame.origin.y+5, 300,100)];
    textView.backgroundColor=[UIColor clearColor];
    textView.alpha=1.0;
    textView.layer.borderColor=hui8Cg;
    textView.layer.borderWidth=1;
    textView.layer.cornerRadius=4;
    textView.font=[UIFont systemFontOfSize:12];
    textView.textColor=hui5;
    textView.showsVerticalScrollIndicator=YES;
    textView.showsHorizontalScrollIndicator=YES;
    textView.scrollEnabled=YES;
    textView.bouncesZoom=YES;
    textView.canCancelContentTouches=YES;
    textView.clearsContextBeforeDrawing=YES;
    textView.userInteractionEnabled=YES;
    textView.delegate=self;
    [_tableView.tableFooterView addSubview:textView];
    
    UILabel *labelTS=[[UILabel alloc]initWithFrame:CGRectMake(_tableView.tableFooterView.frame.size.width-90,textView.frame.size.height+textView.frame.origin.y+2, 80,15)];
    labelTS.text=@"最多300个文字";
    labelTS.font=[UIFont boldSystemFontOfSize:10];
    labelTS.backgroundColor=[UIColor clearColor];
    labelTS.textColor =hui8;
    labelTS.textAlignment=2;
    [_tableView.tableFooterView addSubview:labelTS];
    
//    UIButton *subBnt=[UIButton buttonWithType:0];
//    subBnt.frame=CGRectMake(_tableView.tableFooterView.frame.size.width-84, labelTS.frame.size.height+labelTS.frame.origin.y+5, 74, 29);
//    [subBnt addTarget:self action:@selector(btnSubmit:) forControlEvents:UIControlEventTouchUpInside];
//    [subBnt setImage:BundleImage(@"dd_Submit.png") forState:0];
//    [_tableView.tableFooterView addSubview:subBnt];
    
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
    title_label.text=@"确认订单";
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
    
    
    UIButton*btnTJ=[UIButton buttonWithType:0];
    btnTJ.frame=CGRectMake(view_bar.frame.size.width-55, view_bar.frame.size.height-40, 47, 34);

    [btnTJ setTitle:@"提交" forState:0];
    [btnTJ addTarget:self action:@selector(btnTJ:) forControlEvents:UIControlEventTouchUpInside];
    [view_bar addSubview:btnTJ];
    
    return view_bar;
}


//返回首页
-(void)btnTJ:(id)sender
{
    UIButton*btn=(UIButton*)sender;
    
    if (btn.selected)
    {
        [btn setBackgroundImage:BundleImage(@"yellow_btn_click.png") forState:0];
    }
    TMAccountWINViewController *win=[[TMAccountWINViewController alloc]init];
    TMAppDelegate *delegate=(TMAppDelegate*)[UIApplication sharedApplication].delegate;
    [delegate.navigationController pushViewController:win animated:YES];

   
}
//返回
-(void)btnBack:(id)sender
{
    TMAppDelegate *app=(TMAppDelegate*)[UIApplication sharedApplication].delegate;
    [app.navigationController popViewControllerAnimated:YES];
    
}

-(void)payment:(id)sender
{
    
    FCPaymentViewController *payment=[[FCPaymentViewController alloc]init];
    TMAppDelegate *delegate=(TMAppDelegate*)[UIApplication sharedApplication].delegate;
    [delegate.navigationController pushViewController:payment animated:YES];
    

}
-(void)address:(id)sender
{
    TMAppDelegate *delegate=(TMAppDelegate*)[UIApplication sharedApplication].delegate;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"shoujiandizhi"]!=nil)
    {
        
        TMAditAddressViewController *adit=[[TMAditAddressViewController alloc]init];
        
        [delegate.navigationController pushViewController:adit animated:NO];

    }else{
        TMAddAddressViewController *address=[[TMAddAddressViewController alloc]init];
        
        [delegate.navigationController pushViewController:address animated:NO];
    }
}

#pragma mark keyboard methods
- (void)textViewDidBeginEditing:(UITextView *)textView
{

    [self keyboardWillShow:nil];
}
- (void)textViewDidEndEditing:(UITextView *)textView
{

    [self keyboardWillHide:nil];

}

- (void)keyboardWillShow:(NSNotification *)notification
{
    //    if ([_confirmPwdTextfield isFirstResponder]) {
    NSTimeInterval animationDuration = 0.30f;
    CGRect frame = self.view.frame;
    frame.origin.y = -280;
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = frame;
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    NSTimeInterval animationDuration = 0.30f;
    CGRect frame = self.view.frame;
    frame.origin.y =0;
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = frame;
    [UIView commitAnimations];
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    else if (textView.text.length>300 && range.length == 0)
    {
        ShowMessage(@"超过最大字数300!");
        return NO;
    }
    else {
        return YES;
    }
}



#pragma mark submitInfo
- (void)submitFeedBack:(id)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        [self.view setFrame:CGRectMake(0, 0 ,320, self.view.frame.size.height)];
    }];
    [self hideKeyBoard:nil];
//    NSString * str_linkWay = tf_LinkWay.text;
    NSString * str_FeedBackContent = textView.text;
//    if ([tf_LinkWay.text length]==0)
//    {
//        ShowMessage(@"联系方式为空，请填写！");
//    }
    if([textView.text length]==0)
    {
        ShowMessage(@"反馈内容为空，请填写！");
    }
//    else if ([self isValidateQQ:tf_LinkWay.text]==NO&&[self isValidateEmail:tf_LinkWay.text]==NO)
//    {
//        ShowMessage(@"QQ或邮箱格式不对！");
//    }
    else
    {
//        [self colectionContact:str_linkWay Content:str_FeedBackContent];
    }
    
}
-(void)hideKeyBoard:(id)sender
{
    [textView resignFirstResponder];
//    [tf_LinkWay resignFirstResponder];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = nil;
    
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier: SimpleTableIdentifier] autorelease];
        cell.textLabel.font = [UIFont fontWithName:@"楷体" size:6];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor whiteColor];
    }
//    if(self.newsArray.count == 0 || indexPath.row>self.newsArray.count)
  
    
    
    UIImageView *bImageV=[[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 66, 66)];
    bImageV.image=BundleImage(@"bg_01_l.png");
    bImageV.backgroundColor=[UIColor clearColor];
    [cell addSubview:bImageV];

    
    UrlImageView * imgvw = [[UrlImageView alloc]initWithFrame:CGRectMake(5, 4, 56, 56)];
//    NSString *imagePath = [[self.newsArray objectAtIndex:indexPath.row] objectForKey:@"ititle"];
//    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@/mobile/attachment/download/%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"current_imgUrl"],imagePath]];
//    if (imagePath == nil)
//    {
//        [imgvw setImage:[UIImage imageNamed:@"temp_Icon.png"]];
//    }else{
//        [imgvw setImageWithURL:url];
//        
//    }
    //    btn1.layer.borderWidth=1;
   imgvw.layer.cornerRadius = 4;
    imgvw.image=BundleImage(@"df_01_.png");
   [bImageV addSubview:imgvw];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(bImageV.frame.size.width+bImageV.frame.origin.x+8, bImageV.frame.origin.y, 200, 20)];
//    NSString *headStr = [[self.newsArray objectAtIndex:indexPath.row] objectForKey:@"mainHeading"];
//    label.text=headStr;
    label.text=@"韩版钩花蕾丝衫";
    label.textColor=hui2;
    label.font=[UIFont systemFontOfSize:12];
    label.backgroundColor=[UIColor clearColor];
    [cell addSubview:label];
    
    UILabel *labelKS=[[UILabel alloc]initWithFrame:CGRectMake(label.frame.origin.x, label.frame.origin.y+label.frame.size.height+5, 130, 15)];
//    labelDetail.text=[[self.newsArray objectAtIndex:indexPath.row] objectForKey:@"subHeading"];
    labelKS.text=@"款式：灰色";
    labelKS.backgroundColor=[UIColor clearColor];
    labelKS.font=[UIFont systemFontOfSize:12];
    labelKS.numberOfLines=0;
    labelKS.textColor=hui5;
    [cell addSubview:labelKS];
    
    
    UILabel *labelCM=[[UILabel alloc]initWithFrame:CGRectMake(labelKS.frame.size.width+labelKS.frame.origin.x+5, labelKS.frame.origin.y, 70, 15)];
    labelCM.text=@"尺码：M";
    labelCM.font=[UIFont systemFontOfSize:12];
    labelCM.backgroundColor=[UIColor clearColor];
    labelCM.textColor =hui5;
    labelCM.textAlignment=0;
    [cell addSubview:labelCM];

    
    UILabel *labelJG=[[UILabel alloc]initWithFrame:CGRectMake(labelKS.frame.origin.x, labelKS.frame.size.height+labelKS.frame.origin.y+5, 130, 15)];
//    NSString *timeStr = [[self.newsArray objectAtIndex:indexPath.row] objectForKey:@"updateDate"];
//    labelTime.text= [timeStr substringWithRange:NSMakeRange(0, 10)];
    
    labelJG.backgroundColor=[UIColor clearColor];
    labelJG.font=[UIFont systemFontOfSize:12];
    labelJG.text=@"价格：￥88.00";
    labelJG.textColor=hui5;
    [cell addSubview:labelJG];
    
    
    UILabel *labelSL=[[UILabel alloc]initWithFrame:CGRectMake(labelJG.frame.size.width+labelJG.frame.origin.x+5, labelJG.frame.origin.y, 70, 15)];
    labelSL.text=@"数量：1";
    labelSL.font=[UIFont systemFontOfSize:12];
    labelSL.backgroundColor=[UIColor clearColor];
    labelSL.textColor =hui5;
    labelSL.textAlignment=0;
    [cell addSubview:labelSL];
    
    
    CGRect cellFrame = [cell frame];
    cellFrame.origin=CGPointMake(5, 5);
    cellFrame.size.width=320;
    cellFrame.size.height=imgvw.frame.size.height+15;
    [cell setFrame:cellFrame];
    
    UIImageView *_line=[[UIImageView alloc]initWithFrame:CGRectMake(10, 90-2, 310, 1)];
    _line.image=[UIImage imageNamed:@"line_01_.png"];
    [cell addSubview:_line];
    
    
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1 ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return 90;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return self._marray_updateDate.count;
    return 3;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSTDetailHomeViewController *VC =[[NSTDetailHomeViewController alloc]initWithNews:[self.newsArray objectAtIndex:indexPath.row]];
    //    TMAppDelegate *appDelegate=(TMAppDelegate*)[[UIApplication sharedApplication]delegate];
    //    [appDelegate.navigationController pushViewController:VC animated:YES];
    
}




-(BOOL)showLoading{
    return YES;
}

-(BOOL)closeLoading{
    return YES;
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
