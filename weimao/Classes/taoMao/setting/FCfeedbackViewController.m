//
//  FCfeedbackViewController.m
//  FCset
//
//  Created by Skyler on 13-6-24.
//  Copyright (c) 2013年 SK. All rights reserved.
//

#import "FCfeedbackViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface FCfeedbackViewController ()

@end

@implementation FCfeedbackViewController

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
    title_label.text=@"用户反馈";
    title_label.font=[UIFont systemFontOfSize:20];
    title_label.backgroundColor=[UIColor clearColor];
    title_label.textColor =[UIColor whiteColor];
    title_label.textAlignment=1;
    //    title_label.shadowColor = [UIColor darkGrayColor];
    //    title_label.shadowOffset = CGSizeMake(1, 1);
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
    [self buildContent];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(hideKeyBoard:)];
    [self.view addGestureRecognizer:tap];
}
    //利用正则表达式验证
-(BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

-(BOOL)isValidateQQ:(NSString *)qq
{
    NSString *emailRegex = @"[1-9][0-9]{4,12}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:qq];
}
- (void)buildContent
{
    [self addLabel:CGRectMake(25, 85, 260, 16) view:self.view font:16 text:@"联系方式（Email或者QQ)" backgroudcolor:[UIColor clearColor] textcolor:[UIColor blackColor]];
    
    tf_LinkWay = [self addTextField:CGRectMake(25, 115, 270, 45) withPlaceholder:nil withview:self.view withtag:21110];
    [self.view addSubview:tf_LinkWay];
    
    [self addLabel:CGRectMake(25, 175, 260, 16) view:self.view font:16 text:@"反馈内容" backgroudcolor:[UIColor clearColor] textcolor:[UIColor blackColor]];
    
    tv_FeedBackContent = [self addTextView:CGRectMake(25, 205, 270, 120) view:self.view];
    [self.view addSubview:tv_FeedBackContent];
    
    
    UIButton * submitFeedBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitFeedBack setFrame:CGRectMake(25, 335, 93, 34)];
    [submitFeedBack setBackgroundImage:[UIImage imageNamed:@"red_btn.png"] forState:UIControlStateNormal];
    [submitFeedBack setTitle:@"提交反馈" forState:UIControlStateNormal];
    [submitFeedBack setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitFeedBack.titleLabel.font = [UIFont systemFontOfSize:16];
    [submitFeedBack addTarget:self action:@selector(submitFeedBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitFeedBack];
    
    UILabel *tishiLabel = [[UILabel alloc] initWithFrame:CGRectMake(240, 330, 70, 34)];
    tishiLabel.font = [UIFont systemFontOfSize:15];
    tishiLabel.textColor = [UIColor colorWithRed:0.58 green:0.58 blue:0.58 alpha:1];
    tishiLabel.text = @"限200字";
    [self.view addSubview:tishiLabel];
    [tishiLabel release];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    else if (textView.text.length>10 && range.length == 0)
    {
//        ShowMessage(@"超过最大字数10!");
        return NO;
    }
    else {
        return YES;
    }
}

//影藏键盘
-(IBAction)hideKeyBoard:(id)sender
{
    [tv_FeedBackContent resignFirstResponder];
    [tf_LinkWay resignFirstResponder];
}

#pragma mark submitInfo
- (void)submitFeedBack:(id)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        [self.view setFrame:CGRectMake(0, 0 ,320, self.view.frame.size.height)];
    }];
    [self hideKeyBoard:nil];
    NSString * str_linkWay = tf_LinkWay.text;
    NSString * str_FeedBackContent = tv_FeedBackContent.text;
    if ([tf_LinkWay.text length]==0)
    {
        ShowMessage(@"联系方式为空，请填写！");
    }
    else if([tv_FeedBackContent.text length]==0)
    {
        ShowMessage(@"反馈内容为空，请填写！");
    }
    else if ([self isValidateQQ:tf_LinkWay.text]==NO&&[self isValidateEmail:tf_LinkWay.text]==NO)
    {
        ShowMessage(@"QQ或邮箱格式不对！");
    }
    else
    {
        [self colectionContact:str_linkWay Content:str_FeedBackContent];
    }

}

-(void)colectionContact:(NSString *)linkWay Content:(NSString *)FeedBackContent
{
    NSString *parmeters1=[NSString stringWithFormat:@"phone=%@&content=%@&company=%@",tf_LinkWay.text,tv_FeedBackContent.text,COMPANY_NAME];
//    [[RequestServer instance] doActionAsync:0 withAction:@"/mobile/feedback/mupload?" withParameters:parmeters1 withDelegate:self];

}

-(void)requestFinished:(NSNumber *)code withMessage:(NSString *)message withData:(id)data
{
    if(code == 0)
    {
        ShowMessage(@"上传成功!");
        tv_FeedBackContent.text = @"";
        tf_LinkWay.text = @"";
    }
    else
        ShowMessage(@"上传失败!");
}

//-(void)disposMessage:(Son *)son
//{
//    if ([[son getMethod] isEqualToString:@"FWSuggestion"]) {
//        if ([son getError]==0) {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"提交成功！" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
//            [alert show];
//            [alert release];
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//    }
//}
//
-(BOOL)showLoading{
    return YES;
}

-(BOOL)closeLoading{
    return YES;
}

- (UILabel *)addLabel:(CGRect)frame view:(UIView*)view font:(CGFloat)font text:(NSString *)text backgroudcolor:(UIColor *)bcolor textcolor:(UIColor*)tcolor
{
    UILabel * lb = [[UILabel alloc]initWithFrame:frame];
    [lb setFont:[UIFont systemFontOfSize:font]];
    [lb setTextColor:tcolor];
    [lb setText:text];
    [lb setBackgroundColor:bcolor];
    [view addSubview:lb];
    return lb;
}

- (UITextView*)addTextView:(CGRect)frame view:(UIView *)view
{
    UITextView * textView = [[[UITextView alloc] initWithFrame:frame] autorelease]; //初始化大小并自动释放
    textView.textColor = [UIColor blackColor];//设置textview里面的字体颜色
    textView.font = [UIFont fontWithName:@"Arial"size:16.0];//设置字体名字和字体大小
    textView.delegate = self;//设置它的委托方法
    textView.backgroundColor = [UIColor clearColor];//设置它的背景颜色
    //    self.textView.text = @"Now is the time for all good developers to come to serve their country.\n\nNow is the time for all good developers to come to serve their country.";//设置它显示的内容
    textView.returnKeyType = UIReturnKeyDefault;//返回键的类型
    textView.keyboardType = UIKeyboardTypeDefault;//键盘类型
    textView.scrollEnabled = YES;//是否可以拖动
    textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
    textView.userInteractionEnabled=YES;
    //给UITextView加上边框，用时记得加<QuartzCore/QuartzCore.h>
    textView.layer.cornerRadius = 1;
    textView.layer.masksToBounds = YES;
    textView.layer.borderWidth = 1;
    textView.layer.borderColor = [[UIColor grayColor] CGColor];
    //    self.view.layer.contents = (id)[UIImage imageNamed:@"31"].CGImage; //给图层添加背景图片
   // [view addSubview: textView];//加入到整个页面中
    return textView;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
//    [textView setFrame:CGRectMake(textView.frame.origin.x, textView.frame.origin.y - 100, textView.frame.size.width, textView.frame.size.height)];
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.view setFrame:CGRectMake(0, 0 - 100,320, self.view.frame.size.height)];
    }];
    
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
//    [self.view setFrame:CGRectMake(textView.frame.origin.x, textView.frame.origin.y + 100, textView.frame.size.width, textView.frame.size.height)];
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.view setFrame:CGRectMake(0, 0 ,320, self.view.frame.size.height)];
    }];
}


- (UITextField*)addTextField:(CGRect)frame withPlaceholder:(NSString*)aText withview:(UIView *)vw withtag:(NSInteger)tg
{
    //    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"登陆框@2x.png"]];
    //    //    imgView.frame = CGRectMake(frame.origin.x, frame.origin.y - 30, frame.size.width + 15, frame.size.height + 7);
    //    imgView.frame = CGRectMake(25, frame.origin.y - 20, 242, 30);
    //    [self.view addSubview:imgView];
    //    [self.view sendSubviewToBack:imgView];
    //    [imgView release];
    
    UITextField *field = [[UITextField alloc] initWithFrame:frame];
    field.delegate = self;
    [field setBackgroundColor:[UIColor clearColor]];
    field.clearsOnBeginEditing = NO;
    field.returnKeyType = UIReturnKeyDefault;
    field.textColor = [UIColor colorWithRed:0.282 green:0.341 blue:0.455 alpha:1];
    field.layer.cornerRadius = 1;
    field.layer.masksToBounds = YES;
    field.layer.borderWidth = 1;
    field.layer.borderColor = [[UIColor grayColor] CGColor];
    field.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    field.clearButtonMode = UITextFieldViewModeWhileEditing;
    field.font = [UIFont boldSystemFontOfSize:18.0];
    field.placeholder = aText;
    //    [field resignFirstResponder];
    //field.backgroundColor = [UIColor redColor];
    
    //[vw addSubview:field];
    [vw setUserInteractionEnabled:YES];
    field.tag = tg;
    return field;
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
