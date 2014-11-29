//
//  FCPaymentViewController.m
//  Flower&Cake
//  支付方式
//  Created by 呵呵 on 13-7-13.
//  Copyright (c) 2013年 呵呵. All rights reserved.
//

#import "FCPaymentViewController.h"

@interface FCPaymentViewController ()

@end

@implementation FCPaymentViewController

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
    title_label.text=@"支付方式";
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


//返回首页
-(void)btnHome:(id)sender
{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"backHome" object:nil];
}
//返回
-(void)btnBack:(id)sender
{
    TMAppDelegate *app=(TMAppDelegate*)[UIApplication sharedApplication].delegate;
    [app.navigationController popViewControllerAnimated:YES];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNavigationBar];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HideTabbar" object:nil];
    self.view.backgroundColor = [UIColor colorWithRed:.95 green:.95 blue:.95 alpha:1.0];
    [self initNavigationBar];
    _isPop=NO;
    _marrayTitle=[[NSMutableArray alloc]initWithObjects:@"货到付款", nil];
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, view_bar.frame.size.height+5, self.view.frame.size.width, self.view.frame.size.height-view_bar.frame.size.height)style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.backgroundView=nil;
    _tableView.separatorColor=[UIColor clearColor];
  
    [self.view addSubview:_tableView];
    [self initFooterView];
}

-(void)initFooterView
{

    _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, 80)];
    [_tableView addSubview: _tableView.tableFooterView];

    UIButton *button=[UIButton buttonWithType:0];
    button.frame=CGRectMake((self.view.frame.size.width-292)/2, 80/2-36/2, 292, 36);
    [button setImage:BundleImage(@"qd.png") forState:0];
    [button addTarget:self action:@selector(btnSubmit:) forControlEvents:UIControlEventTouchUpInside];
    [_tableView.tableFooterView addSubview:button];
    

}
#pragma mark tableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [_marrayTitle count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}
- (FCShoppingCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cate_cell";

    FCShoppingCell*   cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSMutableArray*_marrayImages=[[NSMutableArray alloc]initWithObjects:@"COD_icon.png",nil];

    if (cell == nil)
    {
        cell = [[[FCShoppingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType=UITableViewCellAccessoryNone;
        cell.selected=NO;
        cell.tag=1000+indexPath.row;
        cell.backgroundView=[[UIImageView alloc]initWithImage:BundleImage(@"hd_01.png")];
        cell.backgroundColor=[UIColor colorWithRed:.93 green:.93 blue:.93 alpha:1.0];
    }
            //图片ddqr_01
        UIImageView*imgView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 50/2-17/2+10, 19,17)];
        imgView.image=BundleImage(@"dd_icon01.png");
        [cell addSubview:imgView];

            //title
        UILabel*title=[[UILabel alloc]initWithFrame:CGRectMake(imgView.frame.size.width+20, imgView.frame.origin.y, 245, 20)];
        title.backgroundColor=[UIColor clearColor];
            //        title.text=[_marrayAll objectAtIndex:indexPath.row];
        title.textAlignment=0;
        title.text=[_marrayTitle objectAtIndex:indexPath.row];
        title.textColor=hui2;
        title.font=[UIFont systemFontOfSize:12];
        [cell addSubview:title];
        [title release];

            //checkbox@2x
        UIImageView *checkBtn=[[UIImageView alloc]init];
        checkBtn.frame=CGRectMake(cell.frame.size.width-50, 50/2-40/2+10, 40, 40);
        checkBtn.tag=100+indexPath.row;
        checkBtn.image=BundleImage(@"ic_01_n_.png");
        [cell addSubview:checkBtn];
        
        UIImageView*btn1=(UIImageView*)[self.view viewWithTag:100+indexPath.row ];
        if (_index == btn1.tag-100)
        {
            btn1.image= BundleImage(@"ic_01_h_.png");


        } else {
            btn1.image=BundleImage(@"ic_01_n_.png");

        }
        UIImageView *imageView1=(UIImageView*)[self.view viewWithTag:100];
        imageView1.image=BundleImage(@"checkbox_click.png");
        FCShoppingCell *cell1=(FCShoppingCell*)[self.view viewWithTag:1000];
        cell1.isTouch=YES;

//        [[NSUserDefaults standardUserDefaults]setObject:[_marrayTitle objectAtIndex:0] forKey:@"zhifufangshi"];
        [[NSUserDefaults standardUserDefaults]setObject:@"货到付款" forKey:@"zhifufangshi"];
        CGRect cellFrame = [cell frame];
        cellFrame.origin=CGPointMake(5, 5);
        cellFrame.size.width=320;
        cellFrame.size.height=5+imgView.frame.size.height;
        [cell setFrame:cellFrame];
        [imgView release];
//        //线条
//        UIImageView*lineTop2=[[UIImageView alloc]initWithFrame:CGRectMake(10, 50-1, self.view.frame.size.width-10, 1)];
//        lineTop2.image=BundleImage(@"line_01_.png");
//        [cell addSubview:lineTop2];
//        [lineTop2 release];

   
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return 56;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

        // 取消前一个选中的，就是单选啦

        NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:_index inSection:0];
        FCShoppingCell *lastCell = [tableView cellForRowAtIndexPath:lastIndex];
        UIImageView*btn1=(UIImageView*)[self.view viewWithTag:100+lastIndex.row];
        lastCell.accessoryType = UITableViewCellAccessoryNone;
        btn1.image=BundleImage(@"ic_01_n_.png");

        // 选中操作
    FCShoppingCell *cell = [tableView  cellForRowAtIndexPath:indexPath];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"zhifufangshi"];
    [[NSUserDefaults standardUserDefaults]setObject:[_marrayTitle objectAtIndex:cell.tag-1000] forKey:@"zhifufangshi"];
      cell.isTouch=YES;

    UIImageView*btn2=(UIImageView*)[self.view viewWithTag:100+indexPath.row];
    btn2.image=BundleImage(@"ic_01_h_.png");

        // 保存选中的
    _index = indexPath.row;
    [_tableView performSelector:@selector(deselectRowAtIndexPath:animated:) withObject:indexPath afterDelay:.5];

}

#pragma mark按钮事件



-(void)btnSubmit:(id)sender
{
    FCShoppingCell *cell;

    for (int i=0; i<[_marrayTitle count]; i++)
    {
        cell=(FCShoppingCell*)[self.view viewWithTag:i+1000];
        if (cell.isTouch==YES)
        {
            _isPop=YES;
        }
    }

    if (_isPop==NO)
    {
        ShowMessage(@"请选择支付方式！");
    }else{


        [self.navigationController popViewControllerAnimated:YES];
    }

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
 
}

@end
