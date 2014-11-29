//
//  TMUpgradeViewController.m
//  weimao
//
//  Created by mac on 14-4-28.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "TMUpgradeViewController.h"

@interface TMUpgradeViewController ()

@end

@implementation TMUpgradeViewController



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
    title_label.text=@"升级";
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
    //
    //

    
    return view_bar;
}
-(void)btnBack:(id)sender
{

    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNavigationBar];
    UIImageView *loginBG=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-292/2, view_bar.frame.size.height+40, 292, 121)];
    loginBG.image=BundleImage(@"sj_textbox.png");
    loginBG.userInteractionEnabled=YES;
    [self.view addSubview:loginBG];
    
    UILabel *YAOLab=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    YAOLab.text=@" 邀请码:";
    YAOLab.backgroundColor=[UIColor clearColor];
    YAOLab.font=[UIFont systemFontOfSize:16];
    YAOLab.textColor=hui5;
    [loginBG addSubview:YAOLab];
    
    filedYAO=[[UITextField alloc]initWithFrame:CGRectMake(60, 0, 292-60, 40)];
    filedYAO.contentVerticalAlignment=0;
    filedYAO.placeholder=@"6-16个字符";
    filedYAO.clearsOnBeginEditing = YES;
    filedYAO.backgroundColor=[UIColor clearColor];
    filedYAO.clearButtonMode = UITextFieldViewModeWhileEditing;
    filedYAO.contentVerticalAlignment=0;
    filedYAO.delegate=self;
    filedYAO.tag=0;
    
    
    
    filedYAO.borderStyle=UITextBorderStyleNone;
    [filedYAO addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    [filedYAO addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
    filedYAO.returnKeyType = UIReturnKeyDefault;
    [loginBG addSubview:filedYAO];

    
    
    UILabel *nameLab=[[UILabel alloc] initWithFrame:CGRectMake(0, 40, 60, 40)];
    nameLab.text=@" 用户名:";
    nameLab.backgroundColor=[UIColor clearColor];
    nameLab.font=[UIFont systemFontOfSize:16];
    nameLab.textColor=hui5;
    [loginBG addSubview:nameLab];
    
    fieldName=[[UITextField alloc]initWithFrame:CGRectMake(60, 40, 292-60, 40)];
    fieldName.contentVerticalAlignment=0;
    fieldName.placeholder=@"6-16个字符";
    fieldName.clearsOnBeginEditing = YES;
    fieldName.backgroundColor=[UIColor clearColor];
    fieldName.clearButtonMode = UITextFieldViewModeWhileEditing;
    fieldName.contentVerticalAlignment=0;
    fieldName.delegate=self;
    fieldName.tag=1;
    
    
    
    fieldName.borderStyle=UITextBorderStyleNone;
    [fieldName addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    [fieldName addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
    fieldName.returnKeyType = UIReturnKeyDefault;
    [loginBG addSubview:fieldName];
    
    
    UILabel *pasLab=[[UILabel alloc] initWithFrame:CGRectMake(0, 80, 60, 40)];
    pasLab.text=@" 密   码:";
    pasLab.backgroundColor=[UIColor clearColor];
    pasLab.font=[UIFont systemFontOfSize:16];
    pasLab.textColor=hui5;
    [loginBG addSubview:pasLab];
    
    fieldPsw=[[UITextField alloc]initWithFrame:CGRectMake(60, 80, 292, 41)];
    fieldPsw.contentVerticalAlignment=0;
    fieldPsw.placeholder=@"6-16个字符";
    fieldPsw.textColor=hui2;
    fieldPsw.borderStyle=UITextBorderStyleNone;
    fieldPsw.tag=2;
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
    [btnLogin setImage:BundleImage(@"sj_button.png") forState:0];
    [btnLogin addTarget:self action:@selector(btnLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnLogin];
    
}
-(void)btnLogin:(id)sender
{


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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
