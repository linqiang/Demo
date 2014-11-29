//
//  FCLogonViewController.m
//  Flower&Cake
//
//  Created by 呵呵 on 13-7-14.
//  Copyright (c) 2013年 呵呵. All rights reserved.
//

#import "FCLogonViewController.h"
#import "FCRsgisterViewController.h"

#import "FCTabBarController.h"
@interface FCLogonViewController ()

@end

@implementation FCLogonViewController

-(id)initWithBool:(BOOL)isMine
{
    self=[super init];
    if (self)
    {
        _isMine=isMine;
    }
    return self;
}
-(UIView*)initNavigationBar
{
    UIView *view_bar =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    [view_bar addSubview:[[UIImageView alloc]initWithImage:BundleImage(@"navigation_bar.png")]];
//    view_bar.backgroundColor=[UIColor clearColor];
    [self.view addSubview: view_bar];
    UILabel *title_label=[[UILabel alloc]initWithFrame:CGRectMake(65, 0, self.view.frame.size.width-130, 44)];
    title_label.text=@"登录";
    title_label.font=[UIFont systemFontOfSize:20];
    title_label.backgroundColor=[UIColor clearColor];
    title_label.textColor =[UIColor whiteColor];
    title_label.textAlignment=0;
    title_label.shadowColor = [UIColor darkGrayColor];
    title_label.shadowOffset = CGSizeMake(1, 1);
    [view_bar addSubview:title_label];
    UIImageView*leftImageView=[[UIImageView alloc]initWithFrame:CGRectMake(60, (44-37)/2, 2,37)];
    leftImageView.image=BundleImage(@"navigation_bar_line.png");
    [view_bar addSubview:leftImageView];
    UIButton*btnBack=[UIButton buttonWithType:0];
    btnBack.frame=CGRectMake(0, 0, 59, 44);
    [btnBack setImage:BundleImage(@"nav_back_btn.png") forState:0];
    [btnBack addTarget:self action:@selector(btnBack:) forControlEvents:UIControlEventTouchUpInside];
    [view_bar addSubview:btnBack];

    [self.view addSubview:view_bar];
    [title_label release];
    [view_bar release];
    [leftImageView release];
    return view_bar;

}
-(void)viewWillAppear:(BOOL)animated
{
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"HideTabbar" object:nil];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNavigationBar];
    [self addImage];
    [self performSelector:@selector(chekOutCode) withObject:nil afterDelay:0.5];
//    [self chekOutCode];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  
       
}
-(void)addImage
{
    UIImageView*nameImageView=[[UIImageView alloc]initWithFrame:CGRectMake(40, 44+25, 24, 24)];
    nameImageView.image=BundleImage(@"user.png");
    [self.view addSubview:nameImageView];
    [nameImageView release];
    UIImageView*imageName=[[UIImageView alloc]initWithFrame:CGRectMake(nameImageView.frame.origin.x+nameImageView.frame.size.width+10, nameImageView.frame.origin.y-5, 208, 34)];
    imageName.image=BundleImage(@"frame.png");
    imageName.tag=10;
    imageName.userInteractionEnabled=YES;
    fieldName=[[UITextField alloc]initWithFrame:CGRectMake(10, 0, 208-10, 34)];
    fieldName.contentVerticalAlignment=0;
    fieldName.placeholder=@"用户名";
    fieldName.clearsOnBeginEditing = YES;
    fieldName.backgroundColor=[UIColor clearColor];
    fieldName.clearButtonMode = UITextFieldViewModeWhileEditing;
    fieldName.contentVerticalAlignment=0;
    fieldName.delegate=self;
    fieldName.tag=0;
    fieldName.borderStyle=UITextBorderStyleNone;
    [fieldName addTarget:self action:@selector(textFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [fieldName addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
    fieldName.returnKeyType = UIReturnKeyDefault;
    [imageName addSubview:fieldName];
    [self.view addSubview:imageName];
    [imageName release];
    
    UIImageView*pswImageView=[[UIImageView alloc]initWithFrame:CGRectMake(40, nameImageView.frame.size.height+nameImageView.frame.origin.y+25, 24, 24)];
    pswImageView.image=BundleImage(@"password.png");
    [self.view addSubview:pswImageView];
    [pswImageView release];
    
    UIImageView*imagePsw=[[UIImageView alloc]initWithFrame:CGRectMake(pswImageView.frame.origin.x+pswImageView.frame.size.width+10, pswImageView.frame.origin.y-5, 208, 34)];
    imagePsw.image=BundleImage(@"frame.png");
    imagePsw.tag=11;
    imagePsw.userInteractionEnabled=YES;
    fieldPsw=[[UITextField alloc]initWithFrame:CGRectMake(10, 0, 208-10, 34)];
    fieldPsw.contentVerticalAlignment=0;
    fieldPsw.placeholder=@"请输入密码";
    fieldPsw.borderStyle=UITextBorderStyleNone;
    fieldPsw.tag=1;
    fieldPsw.secureTextEntry=YES;
    fieldPsw.delegate=self;
    fieldPsw.clearButtonMode = UITextFieldViewModeWhileEditing;
    [[NSUserDefaults standardUserDefaults]setObject:fieldPsw.text forKey:@"passWord"];
    [fieldPsw addTarget:self action:@selector(textFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [fieldPsw addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
    fieldName.returnKeyType = UIReturnKeyDefault;
    [self.view addSubview:imagePsw];
    [imagePsw addSubview:fieldPsw];
    [imagePsw release];
    
    if (checkLabel)
    {
        [checkLabel removeFromSuperview];
    }
    checkLabel=[[UILabel alloc]init];
    labelFrameWithFont(checkLabel, 30, imagePsw.frame.size.height+imagePsw.frame.origin.y+20, @"验证码");
    checkLabel.frame=CGRectMake(20,  imagePsw.frame.size.height+imagePsw.frame.origin.y+20, 50, 20);
    checkLabel.font=[UIFont systemFontOfSize:16];
    checkLabel.textAlignment=2;
    [self.view addSubview:checkLabel];
    [checkLabel release];
    UIImageView*imageCheck=[[UIImageView alloc]initWithFrame:CGRectMake(checkLabel.frame.origin.x+checkLabel.frame.size.width+5, checkLabel.frame.origin.y-5, 208, 34)];
    imageCheck.image=BundleImage(@"frame.png");
    imageCheck.tag=12;
    imageCheck.userInteractionEnabled=YES;
    fieldCheck=[[UITextField alloc]initWithFrame:CGRectMake(10, 0, 208-10, 34)];
    fieldCheck.placeholder=@"请输入验证码";
    fieldCheck.contentVerticalAlignment=0;
    fieldCheck.borderStyle=UITextBorderStyleNone;
    fieldCheck.tag=2;
    fieldCheck.delegate=self;
    fieldCheck.clearButtonMode = UITextFieldViewModeWhileEditing;
    [fieldCheck addTarget:self action:@selector(textFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [fieldCheck addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
    fieldCheck.returnKeyType = UIReturnKeyDefault;
    [self.view addSubview:imageCheck];
    [imageCheck addSubview:fieldCheck];
    [imageCheck release];
    
    //验证图片
    checkImage=[[UIImageView alloc]initWithFrame:CGRectMake(checkLabel.frame.size.width+checkLabel.frame.origin.x, checkLabel.frame.size.height+checkLabel.frame.origin.y+30, 80, 25)];
    checkImage.backgroundColor=[UIColor clearColor];
 
  

    UIButton*checkBtn=[UIButton buttonWithType:0];
    checkBtn.frame=CGRectMake(self.view.frame.size.width-(checkLabel.frame.size.width+checkLabel.frame.origin.x+80), checkImage.frame.origin.y, 100, 25);
    checkBtn.backgroundColor=[UIColor clearColor];
    [checkBtn setTitle:@"看不清?换一张" forState:0];
    [checkBtn setTitleColor:[UIColor colorWithRed:0.11 green:0.776 blue:1.0 alpha:1.0] forState:0];
    checkBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    checkBtn.titleLabel.textAlignment=0;
    [checkBtn addTarget:self action:@selector(checkOut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checkBtn];
    
    UILabel *labelLine=[[UILabel alloc]initWithFrame:CGRectMake(checkBtn.frame.origin.x, checkBtn.frame.origin.y+checkBtn.frame.size.height-1, 100, 1)];
    labelLine.backgroundColor=[UIColor colorWithRed:0.11 green:0.776 blue:1.0 alpha:1.0];
    [self.view addSubview:labelLine];
    [labelLine release];
    //注册
    UIButton*registerBtn=[UIButton buttonWithType:0];
    registerBtn.frame=CGRectMake(30, checkBtn.frame.size.height+checkBtn.frame.origin.y+30, 109, 41);
    [registerBtn setBackgroundImage:BundleImage(@"blue_btn.png") forState:0];
    [registerBtn setTitle:@"注册" forState:0];
    [registerBtn addTarget:self action:@selector(registerBtn:) forControlEvents:UIControlEventTouchUpInside];
    [registerBtn setTitleColor:[UIColor whiteColor] forState:0];
    [self.view addSubview:registerBtn];
    //  登录
    UIButton*loginBtn=[UIButton buttonWithType:0];
    loginBtn.frame=CGRectMake(self.view.frame.size.width-30-109, registerBtn.frame.origin.y, 109, 41);
    [loginBtn setBackgroundImage:BundleImage(@"peach_btn.png") forState:0];
    [loginBtn addTarget:self action:@selector(loginBtn:) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn setTitle:@"登录" forState:0];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:0];
    [self.view addSubview:loginBtn];

}
#pragma mark keyboard methods
- (void) textFieldBegin:(id)sender
{
    UITextField *t = (UITextField*)sender;
    NSLog(@"%i",t.tag);
    
}

- (void) textFieldDone:(id)sender
{
    [sender resignFirstResponder];
}
- (void)keyboardWillShow:(NSNotification *)notification
{
// 
//    NSTimeInterval animationDuration = 0.30f;
//    CGRect frame = self.view.frame;
//    frame.origin.y = -50;
//    [UIView beginAnimations:@"ResizeView" context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    self.view.frame = frame;
//    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    NSTimeInterval animationDuration = 0.30f;
    CGRect frame = self.view.frame;
    frame.origin.y = 0;
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = frame;
    [UIView commitAnimations];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{

    for (int i=0; i<3; i++)
    {
        UITextField*field1=(UITextField*)[self.view viewWithTag:i];
        UIImageView*_imageView1=(UIImageView*)[self.view viewWithTag:10+i];
   

        if (textField.tag==field1.tag)
        {
            
            _imageView1.image=BundleImage(@"frame_click.png");
            
        }else{
            
            _imageView1.image=BundleImage(@"frame.png");
            
        }
        
        if (textField.tag==2)
        {
            NSTimeInterval animationDuration = 0.30f;
            CGRect frame = self.view.frame;
            frame.origin.y = -70;
            [UIView beginAnimations:@"ResizeView" context:nil];
            [UIView setAnimationDuration:animationDuration];
            self.view.frame = frame;
            [UIView commitAnimations];
            

        }
        
    }

}
#pragma mark获取校验码，首先得到url再get请求得到字节流
-(void)chekOutCode
{
    
//    [[GlobalTool sharedGlobalTool] getAppData];
//    NSArray *array=[[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"deviceid=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"deviceid"]],[NSString stringWithFormat:@"appid=%@",[GlobalTool sharedGlobalTool].apkid],nil];
//    UpdateOne*upda=[[UpdateOne alloc]init:@"FWCheckOutCodeGet" :array delegate:self];
//    [DataManager loadData:[[NSArray alloc]initWithObjects:upda, nil] delegate:self];
    
}


//-(void)disposMessage:(Son *)son
//{
//    if ([son.getMethod isEqualToString:@"FWCheckOutCodeGet"])
//    {
//   
//       Msg_FW_CheckOutCode_Builder*  checkOut=(Msg_FW_CheckOutCode_Builder*)[son getBuild];
//        _url=checkOut.codeUrl;
//        [self checkOut];
//    }
//    [self.view addSubview:checkImage];
//
//
//    if ([son.getMethod isEqualToString:@"FWLogin"])
//    {
//        Msg_Fw_User_Builder*user=(Msg_Fw_User_Builder*)[son getBuild];
//        if ([son getError]==0)
//        {
//            [[NSUserDefaults standardUserDefaults]setObject:user.userid forKey:@"userid"];
//            [[NSUserDefaults standardUserDefaults]setObject:user.name forKey:@"username"];
//            [[NSUserDefaults standardUserDefaults]setObject:user.gender forKey:@"gender"];
//            [[NSUserDefaults standardUserDefaults]setObject:user.birthday forKey:@"birthday"];
//            [[NSUserDefaults standardUserDefaults]setObject:user.email forKey:@"email"];
//            [[NSUserDefaults standardUserDefaults]setObject:user.verify forKey:@"verify"];
//            [[NSUserDefaults standardUserDefaults]setObject:user.area forKey:@"area"];
//            [[NSUserDefaults standardUserDefaults]setObject:user.usericon forKey:@"usericon"];
//            [[NSUserDefaults standardUserDefaults]setObject:user.qq forKey:@"qq"];
//           
//            [[GlobalData sharedGlobalData] setIsLogin:YES];
//
//            [self btnBack:nil];
//        } else {
//
//        }
//    }
//
//}

-(BOOL)showLoading{
    return YES;
}

-(BOOL)closeLoading{
    return YES;
}
-(void)checkOut
{
//    NSUserDefaults *server = [NSUserDefaults standardUserDefaults];
//    
//    NSString *serverUrl = [server objectForKey:@"currentUrl"];
//    if (serverUrl == nil) {
//        
//        serverUrl=current_uurl;
//    }
//    serverUrl = [serverUrl stringByAppendingString:[NSString stringWithFormat:@"/writeCode_us.do?deviceid=%@",myMacAddress]];
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",serverUrl]];
//    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
//    // 组织报文头
//    [request setRequestMethod:@"GET"];
//    [request setTimeOutSeconds:30];
//    NSDictionary* userInfo = [NSDictionary dictionaryWithObjectsAndKeys:self,@"delegate",nil];
//    [request setUserInfo:userInfo];
//    [request setUseCookiePersistence:YES];
//    [request setDelegate:self];
//    [request setDidReceiveDataSelector:nil];
//    [request startSynchronous];
//    //返回数据
//    _image=[UIImage imageWithData:[request responseData]];
//    checkImage.image=_image;
//    [self.view addSubview:checkImage];

  
}
#pragma mark 登陆接口
-(void)loginBtn:(id)sender
{

    if ([fieldCheck.text length]<=0)
    {
        ShowMessage(@"验证码为空！");
    }else {

        if ([fieldName.text length]<=0)
        {
            ShowMessage(@"用户名为空！");
        }else{
            if ([fieldPsw.text length]<=0)
            {
                ShowMessage(@"密码为空！");
            }else{

//                [[GlobalTool sharedGlobalTool] getAppData];
//                NSArray *array=[[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"deviceid=%@",
//                                                                 [[NSUserDefaults standardUserDefaults]objectForKey:@"deviceid"]],
//                                [NSString stringWithFormat:@"bussnessid=%@",[GlobalTool sharedGlobalTool].bussesid],
//                                [NSString stringWithFormat:@"username=%@",fieldName.text],
//                                [NSString stringWithFormat:@"password=%@",fieldPsw.text],
//                                [NSString stringWithFormat:@"checkcode=%@",fieldCheck.text],
//                                [NSString stringWithFormat:@"appid=%@",[GlobalTool sharedGlobalTool].apkid],
//                                [NSString stringWithFormat:@"userid=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userid"]],nil];
//
//                UpdateOne*upda=[[UpdateOne alloc]init:@"FWLogin" :array delegate:self];
//                [DataManager loadData:[[NSArray alloc]initWithObjects:upda, nil] delegate:self];
//                
//                [[NSUserDefaults standardUserDefaults]setObject:fieldName.text forKey:@"username"];
//                [[NSUserDefaults standardUserDefaults]setObject:fieldPsw.text forKey:@"passWord"];
//

            }

        }

    }


}
//注册按钮
-(void)registerBtn:(id)sender
{
    FCRsgisterViewController *Vc=[[FCRsgisterViewController alloc]init];
    [self.navigationController pushViewController:Vc animated:YES];


}
//文本框事件
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self keyboardWillHide:nil];
}
//返回
-(void)btnBack:(id)sender
{

    if ([[self.navigationController.viewControllers objectAtIndex:0] isKindOfClass:[FCLogonViewController class]])
    {
        
        if (_isMine==YES)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowTabbar" object:nil];
            [self.delegate startRemoveLoginVC];

            _isMine=NO;
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowTabbar" object:nil];
            [self.delegate startRemoveLoginVC];
            
            _isMine=YES;
        }
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }

}
-(void)dealloc
{
    [checkImage release];
    [fieldCheck release];
    [responseData release];
    [_url release];
    [super dealloc];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
