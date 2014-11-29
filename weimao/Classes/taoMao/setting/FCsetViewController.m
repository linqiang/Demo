//
//  FCsetViewController.m
//  FCset
//
//  Created by Skyler on 13-6-24.
//  Copyright (c) 2013年 SK. All rights reserved.
//

#import "FCsetViewController.h"
#import "FCfeedbackViewController.h"
#import "FCaboutUsViewController.h"
#import "SDImageCache.h"

@interface FCsetViewController ()

@end

@implementation FCsetViewController

-(UIView*)initNavigationBar
{
    self.navigationController.navigationBarHidden = YES;
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
    title_label.text=@"设置";
    title_label.font=[UIFont boldSystemFontOfSize:20];
    title_label.backgroundColor=[UIColor clearColor];
    title_label.textColor =[UIColor whiteColor];
    title_label.textAlignment=1;
    //    title_label.shadowColor = [UIColor darkGrayColor];
    //    title_label.shadowOffset = CGSizeMake(1, 1);
    [view_bar addSubview:title_label];
    
    UIButton*btnBack=[UIButton buttonWithType:0];
    btnBack.frame=CGRectMake(0, view_bar.frame.size.height-34, 47, 34);
    [btnBack setImage:BundleImage(@"ret_01.png") forState:0];
    [btnBack addTarget:self action:@selector(btnBack:) forControlEvents:UIControlEventTouchUpInside];
    [view_bar addSubview:btnBack];

    return view_bar;
}
-(void)btnSet:(id)sender
{
    FCsetViewController *set=[[FCsetViewController alloc]init];
    TMAppDelegate *appDelegate = (TMAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController pushViewController:set animated:YES];
    
    
}

- (void)btnBack:(id)sender
{
    TMAppDelegate *app=(TMAppDelegate*)[UIApplication sharedApplication].delegate;
    [app.navigationController popToRootViewControllerAnimated:YES];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationController.navigationBarHidden = YES;
    [self initNavigationBar];
    
    NSString *callStr=[NSString stringWithFormat:@"/mobile/company/phone?company=%@",COMPANY_NAME];
//    [[RequestServer instance] doActionAsync:0 withAction:callStr withParameters:nil withDelegate:self];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"HideTabBar" object:nil];
    [self buildTableView];
}

-(void)requestFinished:(NSNumber *)code withMessage:(NSString *)message withData:(id)data
{
  
    phoneNo=(NSString*)data;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = indexPath.row;
    static NSString *CellIdentifier = @"cate_cell";
    
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.selected=NO;
//        cell.showsReorderControl=NO;
        [cell setBackgroundColor:[UIColor whiteColor]];
        cell.textLabel.textColor=hui2;
        
        switch (row)
        {
            case 0:
            {
                cell.accessoryType=UITableViewCellAccessoryNone;
                cell.textLabel.text = @" 清除缓存";
                break;
            }
            case 1:
            {
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.text = @" 用户反馈";
                break;
            }
            case 2:
            {
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.text = @" 关于我们";
                break;
            }
            case 3:
            {
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.text = @" 联系电话";
                break;
            }
            case 4:
            {
                cell.accessoryType=UITableViewCellAccessoryNone;
                cell.textLabel.text = @" 注销";
                break;
            }
                
            default:
                break;
        }
        
        
        
    }
    
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
}
- (void)buildTableView
{
    float Y = 0;
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>7.0)
    {
        Y = 44+20;
    }
    else
    {
        Y = 44;
    }
    UITableView * tb =[[UITableView alloc]initWithFrame:CGRectMake(0, Y, 320, 48*5) style:UITableViewStylePlain];
    tb.bounces = NO;
    [tb setShowsHorizontalScrollIndicator:NO];
    [tb setShowsVerticalScrollIndicator:NO];
    tb.delegate = self;
    tb.dataSource = self;
    [self.view addSubview:tb];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 5;
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1) {
        if (buttonIndex==1)
        {
            [self cleanCache];
            ShowMessage(@"清除缓存成功！");
        }
    }
    if (alertView.tag==2) {
        if (buttonIndex==1)
        {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"islogin"];
            ShowMessage(@"注销成功！");
            [self btnBack:nil];
        }
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TMAppDelegate *appDelegate=(TMAppDelegate*)[[UIApplication sharedApplication]delegate];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSUInteger row = indexPath.row;
    switch (row)
    {
        case 0:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定要清除所有缓存文件吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            [alert show];
            alert.tag = 1;
            [alert release];
            break;
        }
        case 1:
        {
            FCfeedbackViewController * feedbackViewController = [[FCfeedbackViewController alloc]init];
            [appDelegate.navigationController pushViewController:feedbackViewController animated:YES];
            break;
        }
        case 2:
        {
            FCaboutUsViewController * aboutUsViewController = [[FCaboutUsViewController alloc]init];
            [appDelegate.navigationController pushViewController:aboutUsViewController animated:YES];
            break;
        }
        case 3:
        {
            [self callMe];
            break;
        }
        case 4:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定要注销吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            [alert show];
            alert.tag = 2;
            [alert release];
            break;
        }
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)callMe
{
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://15962213526"]];
//    NSLog(@"%@",phoneNo);
    UIWebView*callWebview =[[UIWebView alloc] init];
    NSURL *telURL =[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNo]];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    [self.view addSubview:callWebview];
    [callWebview release];
}

-(void)cleanCache
{
    SDImageCache *cache = [[SDImageCache alloc] init];
    [cache clearMemory];
    [cache clearDisk];
    [cache cleanDisk];
}

@end
