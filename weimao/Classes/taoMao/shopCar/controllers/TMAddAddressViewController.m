//
//  TMAddAddressViewController.m
//  TaoMao
//
//  Created by mac on 14-4-22.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "TMAddAddressViewController.h"

@interface TMAddAddressViewController ()

@end

@implementation TMAddAddressViewController

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
    title_label.text=@"我的收货地址";
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
    
    [btnHome setTitle:@"保存" forState:0];
    [btnHome setTitleColor:[UIColor whiteColor] forState:0];
    btnHome.titleLabel.font=[UIFont systemFontOfSize:16];
    [btnHome addTarget:self action:@selector(btnSave:) forControlEvents:UIControlEventTouchUpInside];
    [view_bar addSubview:btnHome];
    
    return view_bar;
}


//返回
-(void)btnBack:(id)sender
{
    TMAppDelegate *app=(TMAppDelegate*)[UIApplication sharedApplication].delegate;
    [app.navigationController popViewControllerAnimated:NO];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNavigationBar];
     dataPickIsShow = NO;
    
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-296)/2, 15+view_bar.frame.size.height, 296, 221)];
    image.userInteractionEnabled=YES;
    image.image=BundleImage(@"bg.png");
    [self.view addSubview:image];
    
    fieldXM=[[UITextField alloc]initWithFrame:CGRectMake(10, 10, 270, 22)];
    fieldXM.placeholder=@"收货人姓名";
    fieldXM.textColor=hui2;
    fieldXM.tag=10000;
    fieldXM.font=[UIFont systemFontOfSize:14];
    [fieldXM addTarget:self action:@selector(textFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [fieldXM addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [image addSubview:fieldXM];
    
    fieldSJ=[[UITextField alloc]initWithFrame:CGRectMake(10, 10+44, 270, 22)];
    fieldSJ.placeholder=@"手机号码";
    fieldSJ.textColor=hui2;
    fieldSJ.tag=10001;
    fieldSJ.font=[UIFont systemFontOfSize:14];
    [fieldSJ addTarget:self action:@selector(textFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [fieldSJ addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [image addSubview:fieldSJ];
    
    fieldYB=[[UITextField alloc]initWithFrame:CGRectMake(10, 10+44*2, 270, 22)];
    fieldYB.placeholder=@"邮政编码";
    fieldYB.textColor=hui2;
    fieldYB.tag=10002;
    fieldYB.font=[UIFont systemFontOfSize:14];
    [fieldYB addTarget:self action:@selector(textFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [fieldYB addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [image addSubview:fieldYB];
    
    fieldDQ=[[UITextField alloc]initWithFrame:CGRectMake(10, 10+44*3, 270, 22)];
    fieldDQ.text=@"所在地区";
    fieldDQ.textColor=hongShe;
    fieldDQ.font=[UIFont systemFontOfSize:14];
    [image addSubview:fieldDQ];
    
    UIButton*btnDQ=[UIButton buttonWithType:0];
    btnDQ.frame=CGRectMake(0, 0, 270, 22);
    [btnDQ addTarget:self action:@selector(buttonProvince:) forControlEvents:UIControlEventTouchUpInside];
     btnDQ.titleLabel.font=[UIFont systemFontOfSize:14];
    [fieldDQ addSubview:btnDQ];
    
    fieldJD=[[UITextField alloc]initWithFrame:CGRectMake(10, 10+44*4, 270, 22)];
    fieldJD.placeholder=@"街道地址";
    fieldJD.textColor=hui2;
    fieldJD.tag=10003;
    fieldJD.font=[UIFont systemFontOfSize:14];
    [fieldJD addTarget:self action:@selector(textFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [fieldJD addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [image addSubview:fieldJD];
 
}



//接口
-(void)btnSave:(id)sender
{
    UIButton*btn=(UIButton*)sender;
    if (btn.selected)
    {
        [btn setBackgroundImage: BundleImage( @"nav_saving_icon_click.png")forState:0];
    }
    else
    {
        [btn setBackgroundImage: BundleImage( @"nav_saving_icon.png")forState:0];
    }
    
    if (fieldJD.text==nil||
        fieldYB.text==nil||
        fieldXM.text==nil||
        fieldDQ.text==nil
        ||fieldSJ.text==nil)
    {
        ShowMessage(@"内容填写不完整！");
    }else{
        if ([self isValidateCode:fieldYB
             .text]==NO)
        {
            ShowMessage(@"邮政编码格式错误！");
        }else{
            if ([self isValidatePhone:fieldSJ.text]==NO)
            {
                ShowMessage(@"手机号码格式或长度错误！");
            }else{
//                [self alterColection];
                TMAppDelegate *delegate=(TMAppDelegate*)[UIApplication sharedApplication].delegate;
                [delegate.navigationController popViewControllerAnimated:YES];
                [[NSUserDefaults standardUserDefaults]setObject:@"yes" forKey:@"dizhi"];
                 [[NSUserDefaults standardUserDefaults]setObject:fieldXM.text forKey:@"shoujianren"];
//                shoujianren
                [[NSUserDefaults standardUserDefaults]setObject:fieldSJ.text forKey:@"lianxidianhua"];
                
                 [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@%@",fieldDQ.text,fieldJD.text] forKey:@"shoujiandizhi"];
                
            }
            
        }
    }
}

#pragma mark 区域选择
//-(void)setProvinceValue:(NSString *)ProvinceValue
//{
//    if (![_ProvinceValue isEqualToString:ProvinceValue]) {
//        fieldProvince.text=[NSString stringWithFormat:@"  %@",ProvinceValue];
//    }
//}
//-(void)setCityValue:(NSString *)cityValue
//{
//    if (![_cityValue isEqualToString:cityValue]) {
//        _fieldCity.text=[NSString stringWithFormat:@"  %@",cityValue];
//    }
//    
//}
//-(void)setStreetValus:(NSString *)streetValus
//{
//    if (![_streetValus isEqualToString:streetValus]) {
//        fieldStreet.text=[NSString stringWithFormat:@"  %@",streetValus];
//    }
//    
//}
#pragma mark keyboard methods
- (void) textFieldBegin:(id)sender
{
    UITextField *t = (UITextField*)sender;
    NSLog(@"%i",t.tag);
    textFieldTag=t.tag;
    
    HZAreaPickerView *pick=(HZAreaPickerView*)[self.view viewWithTag:-1000];
    [pick cancelPicker];
    
}
- (void) textFieldDone:(id)sender
{
    [sender resignFirstResponder];
}
- (void)keyboardWillShow:(NSNotification *)notification
{
    NSTimeInterval animationDuration = 0.30f;
    CGRect frame = self.view.frame;
    frame.origin.y = -120;
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
    if (dataPickIsShow==YES)
    {
        [self cancelLocatePicker];
    }
    
 
    dataPickIsShow=NO;
//    if (textField==fieldAddress||textField==fieldCode)
//    {
//        
//        [self keyboardWillShow:nil];
//    }
//    else {
        [self keyboardWillHide:nil];
//    }
//    for (int i=0; i<4; i++)
//    {
//        UITextField*field=(UITextField*)[self.view viewWithTag:10000+i];
//        UIImageView*_imageView=(UIImageView*)[self.view viewWithTag:1000+i ];
//        if (field.tag==textField.tag) {
//            
//            _imageView.image=BundleImage(@"frame_click.png");
//            
//        }else{
//            
//            _imageView.image=BundleImage(@"frame.png");
//            
//        }
//        
//    }
    
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self keyboardWillHide:nil];
}

#pragma mark按钮事件
-(void)buttonProvince:(id)sender
{
    UITextField *tf=(UITextField*)[self.view viewWithTag:textFieldTag];
//    for (int i=0; i<4; i++)
//    {
//        field=(UITextField*)[self.view viewWithTag:10000+i];
        if (dataPickIsShow==YES) {
            [tf resignFirstResponder];
        }
//    }
//    if (!self.locatePicker)
//    {
        self.locatePicker = [[[HZAreaPickerView alloc] initWithStyle:HZAreaPickerWithStateAndCityAndDistrict delegate:self] autorelease];
        self.locatePicker.tag=-1000;
        self.locatePicker.backgroundColor=[UIColor clearColor];
        self.locatePicker.tintColor=[UIColor clearColor];
        self.locatePicker.layer.backgroundColor=[UIColor whiteColor].CGColor;
        [self.locatePicker showInView:self.view];
        dataPickIsShow=YES;
//    }
    [self textFieldDone:sender];
    [self keyboardWillHide:nil];
    

    

}

#pragma mark - HZAreaPicker delegate
-(void)pickerDidChaneStatus:(HZAreaPickerView *)picker
{
    if (picker.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
        self.areaValue = [NSString stringWithFormat:@"%@ %@ %@", picker.locate.state, picker.locate.city, picker.locate.district];
        
        fieldDQ.text=[NSString stringWithFormat:@"%@ %@ %@", picker.locate.state, picker.locate.city, picker.locate.district];
        self.ProvinceValue=[NSString stringWithFormat:@"%@", picker.locate.state];
        self.cityValue=[NSString stringWithFormat:@"%@", picker.locate.city];
        self.streetValus=[NSString stringWithFormat:@"%@", picker.locate.district];
        
    } else{
        self.cityValue = [NSString stringWithFormat:@"%@ %@", picker.locate.state, picker.locate.city];
    }
}

-(void)cancelLocatePicker
{
    UITextField*field;
    
    for (int i=0; i<4; i++)
    {
        field=(UITextField*)[self.view viewWithTag:10000+i];
        if (dataPickIsShow==NO)
        {
            [field resignFirstResponder];
        }
        
    }
    [self.locatePicker cancelPicker];
    self.locatePicker.delegate = nil;
    self.locatePicker = nil;
}
//利用正则表达式验证
-(BOOL)isValidateCode:(NSString *)code
{
    NSString *codeRegex = @"[0-9]{6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", codeRegex];
    return [emailTest evaluateWithObject:code];
}
-(BOOL)isValidatePhone:(NSString*)phone
{
    NSString *codeRegex = @"^(1(([35][0-9])|(47)|[8][0126789]))\\d{8}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", codeRegex];
    return [emailTest evaluateWithObject:phone];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
