//
//  TMMyOrderViewController.m
//  TaoMao
//
//  Created by mac on 14-4-23.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "TMMyOrderViewController.h"
#import "TMMyOrderDetailViewController.h"

@interface TMMyOrderViewController ()

@end

@implementation TMMyOrderViewController

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
    title_label.text=@"我的订单";
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

- (CGFloat) horizontalLocationFor:(NSUInteger)tabIndex
{
    CGFloat tabItemWidth = self.view.frame.size.width/2;
    return (tabIndex * tabItemWidth);
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNavigationBar];
    [self initToolBar];
    
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0,  view_bar.frame.size.height+35, self.view.frame.size.width, self.view.frame.size.height-view_bar.frame.size.height-35)style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.backgroundView=nil;
    _tableView.separatorColor=[UIColor clearColor];
    _tableView.backgroundColor=[UIColor colorWithRed:.98 green:.98 blue:.98 alpha:1.0];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:_tableView];
    
    
}

-(UIView*)initToolBar
{
    UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, view_bar.frame.size.height, self.view.frame.size.width,35 )];
    imageView.backgroundColor=[UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1.0];
    imageView.userInteractionEnabled=YES;
    [self.view addSubview:imageView];
    
    
    BtnItem1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [BtnItem1 setFrame:CGRectMake(0, 0, 320/2, 35)];
    BtnItem1.exclusiveTouch=YES;
    BtnItem1.tag = 100;
    [BtnItem1 setTitle:@"己付款" forState:0];
    BtnItem1.titleLabel.font=[UIFont systemFontOfSize:14];
    BtnItem1.titleLabel.textAlignment=1;
    BtnItem1.titleLabel.textColor=   hongShe;
    BtnItem1.layer.borderColor=[UIColor colorWithRed:.95 green:.95 blue:.95 alpha:1.0].CGColor;
    BtnItem1.backgroundColor=[UIColor whiteColor];
    [BtnItem1 addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:BtnItem1];
    
    
    BtnItem2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [BtnItem2 setFrame:CGRectMake(320/2*1+1, 0, 320/2, 35)];
    BtnItem2.exclusiveTouch=YES;
    BtnItem2.tag = 101;
    BtnItem2.backgroundColor=[UIColor colorWithRed:.95 green:.95 blue:.95 alpha:1.0];
    [BtnItem2 setTitle:@"己完成" forState:0];
    [BtnItem2 setTitleColor:[UIColor colorWithRed:.5 green:.5 blue:.5 alpha:1.0] forState:0];
     BtnItem2.titleLabel.font=[UIFont systemFontOfSize:14];
    [BtnItem2 addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:BtnItem2];
    
    
    UIImageView *line=[[UIImageView alloc]initWithFrame:CGRectMake(0, 34, 320, 1)];
    line.image=BundleImage(@"line_01_.png");
    [imageView addSubview:line];
    [line release];
    
    tabBarArrow=[[UIImageView alloc]init];
    tabBarArrow.frame = CGRectMake([self horizontalLocationFor:0], 34, 320/2, 2);
    tabBarArrow.image=BundleImage(@"line_p_.png");
    [imageView addSubview:tabBarArrow];
    [tabBarArrow release];
    
    return  imageView;
}
//三个按钮事件
-(void)change:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    
    [UIView beginAnimations:Nil context:Nil];
    [UIView setAnimationDuration:0.2];
    CGRect frame=tabBarArrow.frame;
    frame.origin.x=[self horizontalLocationFor:btn.tag-100];
    tabBarArrow.frame=frame;
    [UIView commitAnimations];
    
    if (btn.tag==100)
    {
        [BtnItem1 setTitleColor:[UIColor colorWithRed:1.0 green:.23 blue:.49 alpha:1.0] forState:0]   ;
        [BtnItem2 setTitleColor:[UIColor colorWithRed:.5 green:.5 blue:.5 alpha:1.0] forState:0]   ;
        BtnItem1.backgroundColor=[UIColor whiteColor];
        BtnItem2.backgroundColor=[UIColor colorWithRed:.95 green:.95 blue:.95 alpha:1.0];
    
        
    }else if(btn.tag==101)
    {
        [BtnItem2 setTitleColor:[UIColor colorWithRed:1.0 green:.23 blue:.49 alpha:1.0] forState:0]   ;
        [BtnItem1 setTitleColor:[UIColor colorWithRed:.5 green:.5 blue:.5 alpha:1.0] forState:0]   ;
        BtnItem1.backgroundColor=[UIColor colorWithRed:.95 green:.95 blue:.95 alpha:1.0];
        BtnItem2.backgroundColor=[UIColor whiteColor];
        
    
    }
    
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
        cell.backgroundColor=[UIColor colorWithRed:.98 green:.98 blue:.98 alpha:1.0];
        
        
    }

    
    UIImageView*imgBG=[[UIImageView alloc]initWithFrame:CGRectMake(320/2-297/2, 10, 297, 154)];
    imgBG.image=BundleImage(@"dd_bgtextbox.png");
    [cell addSubview: imgBG];
    
//    dicon_01@2x
    UIImageView *imageVG=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 12, 14)];
    imageVG.image=BundleImage(@"dicon_01.png");
    [imgBG addSubview:imageVG];
    
    UILabel *labelDD=[[UILabel alloc]initWithFrame:CGRectMake(imageVG.frame.size.height+imageVG.frame.origin.x+5, imageVG.frame.origin.y-1, 250, 15)];
    labelDD.text=@"订单状态：等待付款";
    labelDD.font=[UIFont systemFontOfSize:14];
    labelDD.backgroundColor=[UIColor clearColor];
    labelDD.textColor =hui5;
    labelDD.textAlignment=0;
    [imgBG addSubview:labelDD];

    
    UIImageView *bImageV=[[UIImageView alloc]initWithFrame:CGRectMake(10, 45, 66, 66)];
    bImageV.image=BundleImage(@"bg_01_l.png");
    bImageV.backgroundColor=[UIColor clearColor];
    [imgBG addSubview:bImageV];
    
    
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
    [imgBG addSubview:label];
    
    UILabel *labelKS=[[UILabel alloc]initWithFrame:CGRectMake(label.frame.origin.x, label.frame.origin.y+label.frame.size.height+5, 130, 15)];
    //    labelDetail.text=[[self.newsArray objectAtIndex:indexPath.row] objectForKey:@"subHeading"];
    labelKS.text=@"款式：灰色";
    labelKS.backgroundColor=[UIColor clearColor];
    labelKS.font=[UIFont systemFontOfSize:12];
    labelKS.numberOfLines=0;
    labelKS.textColor=hui5;
    [imgBG addSubview:labelKS];
    
    
    UILabel *labelCM=[[UILabel alloc]initWithFrame:CGRectMake(labelKS.frame.size.width+labelKS.frame.origin.x+5, labelKS.frame.origin.y, 70, 15)];
    labelCM.text=@"尺码：M";
    labelCM.font=[UIFont systemFontOfSize:12];
    labelCM.backgroundColor=[UIColor clearColor];
    labelCM.textColor =hui5;
    labelCM.textAlignment=0;
    [imgBG addSubview:labelCM];
    
    
    UILabel *labelJG=[[UILabel alloc]initWithFrame:CGRectMake(labelKS.frame.origin.x, labelKS.frame.size.height+labelKS.frame.origin.y+5, 130, 15)];
    labelJG.backgroundColor=[UIColor clearColor];
    labelJG.font=[UIFont systemFontOfSize:12];
    labelJG.text=@"价格：￥88.00";
    labelJG.textColor=hui5;
    [imgBG addSubview:labelJG];
    
    
    UILabel *labelSL=[[UILabel alloc]initWithFrame:CGRectMake(labelJG.frame.size.width+labelJG.frame.origin.x+5, labelJG.frame.origin.y, 70, 15)];
    labelSL.text=@"数量：1";
    labelSL.font=[UIFont systemFontOfSize:12];
    labelSL.backgroundColor=[UIColor clearColor];
    labelSL.textColor =hui5;
    labelSL.textAlignment=0;
    [imgBG addSubview:labelSL];
    
    
    UILabel *labelZJE=[[UILabel alloc]initWithFrame:CGRectMake(bImageV.frame.origin.x, bImageV.frame.size.height+bImageV.frame.origin.y+10, 60, 15)];
    labelZJE.text=@"总金额：";
    labelZJE.font=[UIFont systemFontOfSize:14];
    labelZJE.backgroundColor=[UIColor clearColor];
    labelZJE.textColor =hui5;
    labelZJE.textAlignment=0;

    [imgBG addSubview:labelZJE];

    UILabel *labelZJE_detail=[[UILabel alloc]initWithFrame:CGRectMake(labelZJE.frame.size.width+labelZJE.frame.origin.x, labelZJE.frame.origin.y, 160, 15)];
    labelZJE_detail.text=@"￥198.00";
    labelZJE_detail.font=[UIFont systemFontOfSize:16];
    labelZJE_detail.backgroundColor=[UIColor clearColor];
    labelZJE_detail.textColor =hongShe;
    labelZJE_detail.textAlignment=0;
    [imgBG addSubview:labelZJE_detail];
    
    UIButton *btnFK=[UIButton buttonWithType:0];
    btnFK.frame=CGRectMake(imgBG.frame.size.width-82, imgBG.frame.size.height-40, 72, 29);
    btnFK.hidden=YES;
    [btnFK setImage:BundleImage(@"dd_payicon.png") forState:0];
    [imgBG addSubview:btnFK];
    
    //箭头
    UIImageView *imageP=[[UIImageView alloc]initWithFrame:CGRectMake(cell.frame.size.width-44, (165-70)/2+10, 44, 70)];
    imageP.image=BundleImage(@"bt_04_J.png");
    [cell addSubview:imageP];
    
    CGRect cellFrame = [cell frame];
    cellFrame.origin=CGPointMake(5, 5);
    cellFrame.size.width=320;
    cellFrame.size.height=imgvw.frame.size.height+15;
    [cell setFrame:cellFrame];
    
//    UIImageView *_line=[[UIImageView alloc]initWithFrame:CGRectMake(10, 90-2, 310, 1)];
//    _line.image=[UIImage imageNamed:@"line_01_.png"];
//    [cell addSubview:_line];
    
    
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1 ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return 165;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return self._marray_updateDate.count;
    return 3;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TMMyOrderDetailViewController *VC =[[TMMyOrderDetailViewController alloc]init];
    TMAppDelegate *appDelegate=(TMAppDelegate*)[[UIApplication sharedApplication]delegate];
    [appDelegate.navigationController pushViewController:VC animated:YES];
    
}


@end
