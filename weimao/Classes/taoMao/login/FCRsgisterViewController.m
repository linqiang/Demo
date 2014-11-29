//
//  FCRsgisterViewController.m
//  Flower&Cake

//

#import "FCRsgisterViewController.h"

@interface FCRsgisterViewController ()

@end

@implementation FCRsgisterViewController

-(void)viewWillAppear:(BOOL)animated
{
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"HideTabbar" object:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNavigationBar];
    [self addImage];
    [self checkOut];
    
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
    title_label.text=@"注册";
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


- (void)viewDidLoad
{
    [super viewDidLoad];  
    _array=[[NSMutableArray alloc]initWithObjects:@"邀  请  码:",@"用  户  名:",@"密       码:",@"确认密码:", nil];
}
-(void)addImage
{

    UIImageView *registBG=[[UIImageView alloc]initWithFrame:CGRectMake(320/2-292/2, 40+view_bar.frame.size.height, 292, 161)];
    registBG.userInteractionEnabled=YES;
    registBG.image=BundleImage(@"zc_textbox_01.png");
    [self.view addSubview:registBG];
    
    NSArray*arrayTitle=[[NSArray alloc]initWithObjects:@"输入邀请码",@"6-16个字符",@"输入密码",@"再次输入密码", nil];
    for (int i =0; i<[_array count]; i++)
    {
        UILabel*label1=(UILabel*)[self.view viewWithTag:10000+i];
        if (label1)
        {
            [label1 removeFromSuperview];
         
        }
        label=[[UILabel alloc]initWithFrame:CGRectMake(10,i*40, 80, 40)];
        label.text=[_array objectAtIndex:i];
        label.textAlignment=0;
        label.tag=10000+i;
        label.textColor=hui5;
        label.backgroundColor=[UIColor clearColor];
        label.font=[UIFont systemFontOfSize:16];
        [registBG addSubview:label];
//        imageView=[[UIImageView alloc]initWithFrame:CGRectMake(label.frame.size.width+label.frame.origin.x+5 , label.frame.origin.y, 208, 34)];
//        imageView.tag=1000+i;
//        imageView.userInteractionEnabled=YES;
//        imageView.image=BundleImage(@"frame.png");
        field=[[UITextField alloc]initWithFrame:CGRectMake(83, i*40, 292-83, 40)];
        field.tag=100+i;
        field.contentVerticalAlignment=0;
        field.clearsOnBeginEditing = YES;
        field.textAlignment=0;
        field.placeholder=[arrayTitle objectAtIndex:i];
        field.returnKeyType =UIReturnKeyDefault;
        field.clearButtonMode = UITextFieldViewModeWhileEditing;
        field.delegate=self;
        field.borderStyle=UITextBorderStyleNone;
        if (i==1)
        {
            field.keyboardType=UIKeyboardTypeEmailAddress;
        }
        if (i==2||i==3)
        {
            field.secureTextEntry =YES;
        }
        [field addTarget:self action:@selector(textFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
        [field addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
        [field resignFirstResponder];
        [registBG addSubview:field];
//        [registBG addSubview:imageView];
        
    }
    checkImage=[[UIImageView alloc]initWithFrame:CGRectMake(label.frame.size.width+label.frame.origin.x-10, label.frame.size.height+label.frame.origin.y+30, 80, 25)];
    checkImage.backgroundColor=[UIColor clearColor];
    checkImage.image=_image;
    [registBG addSubview:checkImage];
    [checkImage release];
    
//    UIButton*checkBtn=[UIButton buttonWithType:0];
//    checkBtn.titleLabel.font=[UIFont systemFontOfSize:12];
//    checkBtn.frame=CGRectMake(self.view.frame.size.width-(label.frame.size.width+label.frame.origin.x+70), checkImage.frame.origin.y, 100, 25);
//    
//    [checkBtn addTarget:self action:@selector(checkOut) forControlEvents:UIControlEventTouchUpInside];
//    [checkBtn setTitle:@"看不清?换一张" forState:0];
//    checkBtn.backgroundColor=[UIColor clearColor];
//    [checkBtn setTitleColor:[UIColor colorWithRed:0.11 green:0.776 blue:1.0 alpha:1.0] forState:0];
//    [self.view addSubview:checkBtn];
//    
//    UILabel *labelLine=[[UILabel alloc]initWithFrame:CGRectMake(checkBtn.frame.origin.x, checkBtn.frame.origin.y+checkBtn.frame.size.height-1, 100, 1)];
//    labelLine.backgroundColor=[UIColor colorWithRed:0.11 green:0.776 blue:1.0 alpha:1.0];
//    [self.view addSubview:labelLine];
//    [labelLine release];


    //注册
    UIButton *registerBtn=[UIButton buttonWithType:0];
    registerBtn.frame=CGRectMake((320-292)/2, registBG.frame.size.height+registBG.frame.origin.y+30, 293, 35);
    [registerBtn setBackgroundImage:BundleImage( @"zc_button_01.png") forState:0];
    [registerBtn addTarget:self action:@selector(registerBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [registerBtn setTitle:@"注册" forState:0];
    [registerBtn setTitleColor:[UIColor whiteColor] forState:0];
    [self.view addSubview:registerBtn];

}
//[a-zA-Z\xa0-\xff_][0-9a-zA-Z\xa0-\xff_]{3,15}
-(BOOL)isValidateName:(NSString*)name
{
    NSString *emailRegex = @"^([\u4E00-\uFA29]|[\uE7C7-\uE7F3]|[a-zA-Z0-9])*$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:name];



}
    //利用正则表达式验证
-(BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

-(void)registerBtn:(id)sender
{
    UITextField*field0=(UITextField*)[self.view viewWithTag:100];
    UITextField*field1=(UITextField*)[self.view viewWithTag:101];
    UITextField*field2=(UITextField*)[self.view viewWithTag:102];
    UITextField*field3=(UITextField*)[self.view viewWithTag:103];
    
    if ([field1.text length]<=0) {
        ShowMessage(@"用户名不能为空！");
    }
    else if ([self isValidateName:field1.text]==NO){

        ShowMessage(@"用户名格式不对！");
    }
    else if ([field0.text length]<=0) {
        ShowMessage(@"邮箱不能为空！");
    }
    else if ([field2.text length]<=0) {
        ShowMessage(@"密码不能为空！");
    }
    else if ([field3.text length]<=0) {
        ShowMessage(@"确认密码不能为空！");
    }
//    else if ([field4.text length]<=0) {
//        ShowMessage(@"验证码不能为空！");
//    }
    else if ([self isValidateEmail:field1.text]==NO)
        {
        ShowMessage(@"邮箱格式错误！");
    }
    else if ([field2.text length]<6) {
        ShowMessage(@"密码不能少于6位！");
    }
    else if ([field2.text length]>16) {
        ShowMessage(@"密码不能超过16位！");
    }
    else if ([field2.text isEqualToString:field3.text]==NO)
        {
        ShowMessage(@"密码不一致！");
    }
    else {
//        [[GlobalTool sharedGlobalTool] getAppData];
//        
//        NSArray *array=[[NSArray alloc] initWithObjects:
//                        [NSString stringWithFormat:@"deviceid=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"deviceid"]],
//                        [NSString stringWithFormat:@"appid=%@",[GlobalTool sharedGlobalTool].apkid],
//                        [NSString stringWithFormat:@"bussnessid=%@",[GlobalTool sharedGlobalTool].bussesid],
//                        [NSString stringWithFormat:@"username=%@",field0.text],
//                        [NSString stringWithFormat:@"mail=%@",field1.text],
//                        [NSString stringWithFormat:@"password=%@",field2.text],
//                        [NSString stringWithFormat:@"checkcode=%@",field4.text],
//                        nil];
//        UpdateOne*upda=[[UpdateOne alloc]init:@"FWRegister" :array delegate:self];
//        [DataManager loadData:[[NSArray alloc]initWithObjects:upda, nil] delegate:self];
    }
}

//-(void)disposMessage:(Son *)son
//{
//    if ([son.getMethod isEqualToString:@"FWRegister"])
//        {
//        Msg_Fw_User_Builder*  user=(Msg_Fw_User_Builder*)[son getBuild];
//        if ([son getError]==0)
//        {
//            showShareMessage(@"注册成功");
//            if ([[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]==nil) {
//                
//            }else{
//                [[NSUserDefaults standardUserDefaults]setObject:user.userid forKey:@"userid"];
//            }
//            [self.navigationController popViewControllerAnimated:YES];
//            
//            
//        }else {
////            ShowMessage([son getMsg]);
//            
//        }
//
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
//
//    }
//    serverUrl = [serverUrl stringByAppendingString:[NSString stringWithFormat:@"/writeCode_us.do?deviceid=%@",myMacAddress]];
//    
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",serverUrl]];
//    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
//    // 组织报文头
//    [request setRequestMethod:@"GET"];
//    [request setTimeOutSeconds:30];
//    NSDictionary* userInfo = [NSDictionary dictionaryWithObjectsAndKeys:self,@"delegate",nil];
//    [request setUserInfo:userInfo];
//    [request setUseCookiePersistence:YES];
//    [request setDelegate:self];
//    [request setDidFinishSelector:@selector(messageDidFinish:)];
//    [request setDidFailSelector:@selector(didFailed:)];
//    [request setDidReceiveDataSelector:nil];
//    [request startSynchronous];
//    
//    //返回数据
//    _image=[UIImage imageWithData:[request responseData]];
//    
//    [self.view addSubview:checkImage];
//    checkImage.image=_image;
  
}

#pragma mark keyboard methods
- (void) textFieldBegin:(id)sender
{
    UITextField *t = (UITextField*)sender;
    NSLog(@"%i",t.tag);
    
}

- (void)textFieldDone:(id)sender
{
    [sender resignFirstResponder];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    NSTimeInterval animationDuration = 0.30f;
    CGRect frame = self.view.frame;

    frame.origin.y = -150;
    
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = frame;
    [UIView commitAnimations];
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
    
    for (int i=0; i<[_array count]; i++)
    {
        UITextField*field1=(UITextField*)[self.view viewWithTag:100+i];
        UIImageView*_imageView=(UIImageView*)[self.view viewWithTag:1000+i ];
        if (field1.tag==textField.tag)
        {
      
            _imageView.image=BundleImage(@"frame_click.png");

        }else{
        
            _imageView.image=BundleImage(@"frame.png");

        }
      
        if (textField.tag==102)
        {
            NSTimeInterval animationDuration = 0.30f;
            CGRect frame = self.view.frame;
            
            frame.origin.y = -50;
            
            [UIView beginAnimations:@"ResizeView" context:nil];
            [UIView setAnimationDuration:animationDuration];
            self.view.frame = frame;
            [UIView commitAnimations];
        }
        else if(textField.tag==103)
        {
            NSTimeInterval animationDuration = 0.30f;
             CGRect frame = self.view.frame;
             
             frame.origin.y = -100;
             
             [UIView beginAnimations:@"ResizeView" context:nil];
             [UIView setAnimationDuration:animationDuration];
             self.view.frame = frame;
             [UIView commitAnimations];
            
        }else if(textField.tag==104)
        {
            NSTimeInterval animationDuration = 0.30f;
            CGRect frame = self.view.frame;
            
            frame.origin.y = -150;
            
            [UIView beginAnimations:@"ResizeView" context:nil];
            [UIView setAnimationDuration:animationDuration];
            self.view.frame = frame;
            [UIView commitAnimations];
            
        }else if(textField.tag==100)
        {
        
            NSTimeInterval animationDuration = 0.30f;
            CGRect frame = self.view.frame;
            
            frame.origin.y = 0;
            
            [UIView beginAnimations:@"ResizeView" context:nil];
            [UIView setAnimationDuration:animationDuration];
            self.view.frame = frame;
            [UIView commitAnimations];


        }


    }
    
}
    
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self keyboardWillHide:nil];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(void)btnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)dealloc
{
    [_array release];
    [fieldCheck release];
    [responseData release];
    [_url release];
    [field release];
    [super dealloc];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
