//
//  FCLoginViewController.m
//  Flower&Cake
//
//  Created by 呵呵 on 13-7-14.
//  Copyright (c) 2013年 呵呵. All rights reserved.
//

#import "FCLoginViewController.h"
#import "GuideViewController.h"
#import "FCRsgisterViewController.h"
#import "TMUpgradeViewController.h"

@interface FCLoginViewController ()

@end

@implementation FCLoginViewController
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;

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
    title_label.text=@"登录";
    title_label.font=[UIFont boldSystemFontOfSize:20];
    title_label.backgroundColor=[UIColor clearColor];
    title_label.textColor =[UIColor whiteColor];
    title_label.textAlignment=1;
    [view_bar addSubview:title_label];
    
//    UIButton*btnBack=[UIButton buttonWithType:0];
//    btnBack.frame=CGRectMake(0, view_bar.frame.size.height-34, 47, 34);
//    [btnBack setImage:BundleImage(@"ret_01.png") forState:0];
//    [btnBack addTarget:self action:@selector(btnBack:) forControlEvents:UIControlEventTouchUpInside];
//    [view_bar addSubview:btnBack];
//    
//    
    UIButton*btnSJ=[UIButton buttonWithType:0];
    btnSJ.frame=CGRectMake(view_bar.frame.size.width-55, view_bar.frame.size.height-40, 47, 34);
    
    [btnSJ setTitle:@"升级" forState:0];
    [btnSJ addTarget:self action:@selector(btnSJ:) forControlEvents:UIControlEventTouchUpInside];
    [view_bar addSubview:btnSJ];
    
    return view_bar;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    [self initNavigationBar];
     NSUserDefaults *default1 = [NSUserDefaults standardUserDefaults];
    if (![default1 objectForKey:@"applicationVersion"]||![[default1 objectForKey:@"applicationVersion"] isEqualToString:@"1.0"]) {
    
        [self presentViewController:[[[GuideViewController alloc] init] autorelease] animated:NO completion:nil];
        [default1 setObject:@"1.0" forKey:@"applicationVersion"];
    }

    
    UIImageView *loginBG=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-292/2, view_bar.frame.size.height+40, 292, 81)];
    loginBG.image=BundleImage(@"dl_textbox_02.png");
    loginBG.userInteractionEnabled=YES;
    [self.view addSubview:loginBG];
    
    UILabel *nameLab=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    nameLab.text=@" 用户名:";
    nameLab.backgroundColor=[UIColor clearColor];
    nameLab.font=[UIFont systemFontOfSize:16];
    nameLab.textColor=hui5;
    [loginBG addSubview:nameLab];
    
    fieldName=[[UITextField alloc]initWithFrame:CGRectMake(60, 0, 292-60, 40)];
    fieldName.contentVerticalAlignment=0;
    fieldName.placeholder=@"6-16个字符";
    fieldName.clearsOnBeginEditing = YES;
    fieldName.backgroundColor=[UIColor clearColor];
    fieldName.clearButtonMode = UITextFieldViewModeWhileEditing;
    fieldName.contentVerticalAlignment=0;
    fieldName.delegate=self;
    fieldName.tag=0;
    fieldName.borderStyle=UITextBorderStyleNone;
    [fieldName addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    [fieldName addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
    fieldName.returnKeyType = UIReturnKeyDefault;
    [loginBG addSubview:fieldName];
    
    
    UILabel *pasLab=[[UILabel alloc] initWithFrame:CGRectMake(0, 40, 60, 40)];
    pasLab.text=@" 密   码:";
    pasLab.backgroundColor=[UIColor clearColor];
    pasLab.font=[UIFont systemFontOfSize:16];
    pasLab.textColor=hui5;
    [loginBG addSubview:pasLab];
    
    fieldPsw=[[UITextField alloc]initWithFrame:CGRectMake(60, 40, 292-60, 41)];
    fieldPsw.contentVerticalAlignment=0;
    fieldPsw.placeholder=@"6-16个字符";
    fieldPsw.textColor=hui2;
    fieldPsw.borderStyle=UITextBorderStyleNone;
    fieldPsw.tag=1;
    fieldPsw.clearsOnBeginEditing = YES;
    fieldPsw.backgroundColor=[UIColor clearColor];
    fieldPsw.secureTextEntry=YES;
    fieldPsw.delegate=self;
    fieldPsw.clearButtonMode = UITextFieldViewModeWhileEditing;
    [[NSUserDefaults standardUserDefaults]setObject:fieldPsw.text forKey:@"passWord"];
    [fieldPsw addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    [fieldPsw addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
    fieldName.returnKeyType = UIReturnKeyDefault;
    [loginBG addSubview:fieldPsw];
    
    UIButton *btnLogin=[UIButton buttonWithType:0];
    btnLogin.frame=CGRectMake(320/2-292/2, loginBG.frame.size.height+loginBG.frame.origin.y+35, 292, 36);
    [btnLogin setImage:BundleImage(@"dl_button_02.png") forState:0];
    [btnLogin addTarget:self action:@selector(btnLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnLogin];
    
    UIButton *registerBtn=[UIButton buttonWithType:0];
    registerBtn.frame=CGRectMake(320-85, btnLogin.frame.size.height+btnLogin.frame.origin.y+5, 70, 15);
    registerBtn.backgroundColor=[UIColor clearColor];
    registerBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    [registerBtn setTitle:@"注册新用户" forState:0];
    [registerBtn setTitleColor:[UIColor colorWithRed:1.0 green:.23 blue:.49 alpha:1.0] forState:0];
    [registerBtn addTarget:self action:@selector(registerBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];

    
}
-(void)btnLogin:(id)sender
{

  
    [fieldName resignFirstResponder];
    [fieldPsw resignFirstResponder];
    [self keyboardWillHide:nil];
    
    
    
    if ([fieldName.text length]<=0)
    {
        ShowMessage(@"用户名为空！");
        
    }else if([fieldPsw.text length]<=0)
    {
        
        ShowMessage(@"密码为空！");
   
    }else if([self isUserName:fieldName.text ]==NO)
    {
    
        ShowMessage(@"用户名为6-16字符");
    
    }else if([self isUserName:fieldPsw.text ]==NO)
    {
        
         ShowMessage(@"密码为6-16字符");
        
    }

    else{
        [[NSUserDefaults standardUserDefaults]setObject:@"islogin" forKey:@"islogin"];
        FCTabBarController *view1 = [[FCTabBarController alloc] init];
        [self.navigationController pushViewController:view1 animated:YES];
    
    }
    
}

//(\w{6,16})
-(BOOL)isUserName:(NSString*)name
{
    NSString *nameRegex = @"(\\w{6,16})";
    NSPredicate *nameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nameRegex];
    return [nameTest evaluateWithObject:name];
    
}
-(void)btnSJ:(id)sender
{
    TMUpgradeViewController *upgrade=[[TMUpgradeViewController alloc]init];
    [self.navigationController pushViewController:upgrade animated:YES];

}
//注册按钮
-(void)registerBtn:(id)sender
{
//    [fieldCheck resignFirstResponder];
    [fieldName resignFirstResponder];
    [fieldPsw resignFirstResponder];
    
    FCRsgisterViewController *Vc=[[FCRsgisterViewController alloc]init];
    [self.navigationController pushViewController:Vc animated:YES];
    
}
//文本框事件
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self keyboardWillHide:nil];
}

#pragma mark keyboard methods
//- (void) textFieldBegin:(id)sender
//{
//    UITextField *t = (UITextField*)sender;
//    NSLog(@"%i",t.tag);
//    NSTimeInterval animationDuration = 0.30f;
//    CGRect frame = self.view.frame;
//    frame.origin.y = -50;
//    [UIView beginAnimations:@"ResizeView" context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    self.view.frame = frame;
//    [UIView commitAnimations];
//
//}

- (void) textFieldDone:(id)sender
{
    [self keyboardWillHide:nil];
    [sender resignFirstResponder];
}
- (void)keyboardWillShow:(NSNotification *)notification
{
    //        //
    //        //    NSTimeInterval animationDuration = 0.30f;
    //        //    CGRect frame = self.view.frame;
    //        //    frame.origin.y = -50;
    //        //    [UIView beginAnimations:@"ResizeView" context:nil];
    //        //    [UIView setAnimationDuration:animationDuration];
    //        //    self.view.frame = frame;
    //        //    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    NSTimeInterval animationDuration = 0.30f;
    CGRect frame = self.view.frame;
    
    UITextView *text1=(UITextView*)[self.view viewWithTag:0];
    UITextView *text2=(UITextView*)[self.view viewWithTag:1];
    UITextView *text3=(UITextView*)[self.view viewWithTag:2];
    if (text1.isFirstResponder==YES||text2.isFirstResponder==YES||text3.isFirstResponder==YES)
    {
        frame.origin.y = 0;
    }else{
        frame.origin.y = 0;
    }
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = frame;
    [UIView commitAnimations];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    NSLog(@"%d",textField.tag);
    int count = textField.tag;
    switch (count)
    {
            
        case 0:
        {
            
            break;
        }
        case 1:
        {
            
            break;
        }
        case 2:
        {
            NSTimeInterval animationDuration = 0.30f;
            CGRect frame = self.view.frame;
            frame.origin.y =-50;
            [UIView beginAnimations:@"ResizeView" context:nil];
            [UIView setAnimationDuration:animationDuration];
            self.view.frame = frame;
            [UIView commitAnimations];
            
        }
        case 3:
        {
            NSTimeInterval animationDuration = 0.30f;
            CGRect frame = self.view.frame;
            frame.origin.y = -50;
            [UIView beginAnimations:@"ResizeView" context:nil];
            [UIView setAnimationDuration:animationDuration];
            self.view.frame = frame;
            [UIView commitAnimations];
            
        }
            
        default:
            break;
    }
    
}
-(void)btnBack:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
