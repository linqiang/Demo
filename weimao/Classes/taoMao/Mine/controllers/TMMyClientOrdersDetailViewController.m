//
//  TMMyClientOrdersDetailViewController.m
//  TaoMao
//
//  Created by mac on 14-4-25.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "TMMyClientOrdersDetailViewController.h"

@interface TMMyClientOrdersDetailViewController ()

@end

@implementation TMMyClientOrdersDetailViewController

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
    title_label.text=@"客户订单详情";
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



//返回
-(void)btnBack:(id)sender
{
    TMAppDelegate *app=(TMAppDelegate*)[UIApplication sharedApplication].delegate;
    [app.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    selectCount=0;
    self.view.backgroundColor=[UIColor colorWithRed:.98 green:.98 blue:.98 alpha:1.0];
    [self initNavigationBar];
    
    
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0,  view_bar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-view_bar.frame.size.height)style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.backgroundView=nil;
    _tableView.separatorColor=[UIColor clearColor];
    _tableView.backgroundColor=[UIColor colorWithRed:.98 green:.98 blue:.98 alpha:1.0];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:_tableView];
    
    
    [self initHeaderView];
    [self initFooterView];
}
-(void)initHeaderView
{
    _tableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.height, 165)];
    _tableView.tableHeaderView.backgroundColor=[UIColor clearColor];
    
    [_tableView addSubview:_tableView.tableHeaderView];
    
    UIImageView *headImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 41)];
    headImg.image=BundleImage(@"ddqr_01.png");
    [_tableView.tableHeaderView addSubview:headImg];
    
    UIImageView *imageVG=[[UIImageView alloc]initWithFrame:CGRectMake(80, 41/2-14/2, 12, 14)];
    imageVG.image=BundleImage(@"dicon_01.png");
    [headImg addSubview:imageVG];
    
    UILabel *title_label=[[UILabel alloc]initWithFrame:CGRectMake(92+5, 41/2-20/2, 200, 20)];
    title_label.text=@"订单状态：己完成订单";
    title_label.font=[UIFont systemFontOfSize:12];
    title_label.backgroundColor=[UIColor clearColor];
    title_label.textColor =hui2;
    title_label.textAlignment=0;
    [headImg addSubview:title_label];
    
    UIImageView*upImg=[[UIImageView alloc]initWithFrame:CGRectMake(320/2-297/2, headImg.frame.size.height+headImg.frame.origin.y+10, 297, 72)];
    upImg.image=BundleImage(@"adressbg.png");
    
    [_tableView.tableHeaderView addSubview:upImg];
    
    
    UIImageView *imgSJR=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 15, 15)];
    imgSJR.image=BundleImage(@"dicon_02.png");
    [upImg addSubview:imgSJR];
    UILabel *labelSJR=[[UILabel alloc]initWithFrame:CGRectMake(imgSJR.frame.origin.x+imgSJR.frame.size.width+5, imgSJR.frame.origin.y, 130, 15)];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"shoujianren"]!=nil&&[[NSUserDefaults standardUserDefaults] objectForKey:@"shoujianren"]!=NULL)
    {
        labelSJR.text=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"shoujianren"]];
        
        
        
    }else{
        labelSJR.text=@"收件人";
        
    }
    
    labelSJR.font=[UIFont systemFontOfSize:12];
    labelSJR.backgroundColor=[UIColor clearColor];
    labelSJR.textColor =hui2;
    labelSJR.textAlignment=0;
    
    [upImg addSubview:labelSJR];
    
    UIImageView *imgDH=[[UIImageView alloc]initWithFrame:CGRectMake(labelSJR.frame.size.width+labelSJR.frame.origin.x+5, 10, 10, 15)];
    imgDH.image=BundleImage(@"dicon_03.png");
    [upImg addSubview:imgDH];
    
    UILabel *labelDH=[[UILabel alloc]initWithFrame:CGRectMake(imgDH.frame.origin.x+imgDH.frame.size.width+5, imgDH.frame.origin.y, 110, 15)];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"lianxidianhua"]!=nil&&[[NSUserDefaults standardUserDefaults] objectForKey:@"lianxidianhua"]!=NULL) {
        labelDH.text=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"lianxidianhua"]];
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"lianxidianhua"]);
        
        
    }else{
        labelDH.text=@"电话";
        
    }
    labelDH.font=[UIFont systemFontOfSize:12];
    labelDH.backgroundColor=[UIColor clearColor];
    labelDH.textColor =hui2;
    labelDH.textAlignment=0;
    
    [upImg addSubview:labelDH];
    
    UIImageView *imgDZ=[[UIImageView alloc]initWithFrame:CGRectMake(imgSJR.frame.origin.x, imgSJR.frame.origin.y+imgSJR.frame.size.height+17, 15, 15)];
    imgDZ.image=BundleImage(@"dicon_04.png");
    [upImg addSubview:imgDZ];
    
    UILabel *labelDZ=[[UILabel alloc]initWithFrame:CGRectMake(imgDZ.frame.origin.x+imgDZ.frame.size.width+5, imgDZ.frame.origin.y, 270, 15)];
    
    labelDZ.text=[NSString stringWithFormat:@"%@",@"址收件地址"];
    labelDZ.font=[UIFont systemFontOfSize:12];
    labelDZ.backgroundColor=[UIColor clearColor];
    labelDZ.textColor =hui2;
    labelDZ.textAlignment=0;
    labelDZ.numberOfLines=0;
    [labelDZ sizeToFit];
    [upImg addSubview:labelDZ];
    
    UIImageView*downImg=[[UIImageView alloc]initWithFrame:CGRectMake(320/2-297/2, upImg.frame.size.height+upImg.frame.origin.y+10, 297, 32)];
    downImg.image=BundleImage(@"ddmj_1.png");
    
    [_tableView.tableHeaderView addSubview:downImg];
    
    UIImageView*imgv3=[[UIImageView alloc]initWithFrame:CGRectMake(10, 32/2-18/2, 18, 19)];
    imgv3.image=BundleImage(@"dd_store.png");
    [downImg addSubview:imgv3];
    [imgv3 release];
    
    
    UILabel *title_label4=[[UILabel alloc]initWithFrame:CGRectMake(imgv3.frame.size.width+imgv3.frame.origin.x+5, 32/2-20/2, 150, 20)];
    title_label4.text=@"莎儿家";
    title_label4.font=[UIFont systemFontOfSize:14];
    title_label4.backgroundColor=[UIColor clearColor];
    title_label4.textColor =hui6;
    title_label4.textAlignment=0;
    [downImg addSubview:title_label4];
    
    UILabel *title_label5=[[UILabel alloc]initWithFrame:CGRectMake(title_label4.frame.size.width+title_label4.frame.origin.x+10, 32/2-20/2, 30, 20)];
    title_label5.text=@"合计:";
    title_label5.font=[UIFont systemFontOfSize:12];
    title_label5.backgroundColor=[UIColor clearColor];
    title_label5.textColor =hui2;
    title_label5.textAlignment=0;
    [downImg addSubview:title_label5];
    
    UILabel *title_label6=[[UILabel alloc]initWithFrame:CGRectMake(title_label5.frame.size.width+title_label5.frame.origin.x, 32/2-20/2, 60, 20)];
    title_label6.text=@"$123.0";
    title_label6.font=[UIFont systemFontOfSize:12];
    title_label6.backgroundColor=[UIColor clearColor];
    title_label6.textColor =hongShe;
    title_label6.textAlignment=0;
    [downImg addSubview:title_label6];
}

-(void)initFooterView
{
    _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.height, 97)];
    _tableView.tableFooterView.backgroundColor=[UIColor clearColor];
    [_tableView addSubview:_tableView.tableFooterView];
    
    UIImageView *bottomImg=[[UIImageView alloc]initWithFrame:CGRectMake(320/2-297/2, 0,297, 97)];
    bottomImg.userInteractionEnabled=YES;
    bottomImg.image=BundleImage(@"ddmj_3.png");
    [_tableView.tableFooterView addSubview:bottomImg];
    
    UILabel *labelDDBH=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 300, 15)];
    labelDDBH.text=@"订单编号：12345678";
    labelDDBH.textColor=hui5;
    labelDDBH.textAlignment=0;
    labelDDBH.font=[UIFont systemFontOfSize:12];
    [bottomImg addSubview:labelDDBH];
    
    UILabel *labelCJSJ=[[UILabel alloc]initWithFrame:CGRectMake(10, labelDDBH.frame.size.height+labelDDBH.frame.origin.y+5, 300, 15)];
    labelCJSJ.text=@"成交时间：2014-04-20 19：34：34";
    labelCJSJ.textColor=hui5;
    labelCJSJ.textAlignment=0;
    labelCJSJ.font=[UIFont systemFontOfSize:12];
    [bottomImg addSubview:labelCJSJ];
    
    UILabel *labelFKSJ=[[UILabel alloc]initWithFrame:CGRectMake(10, labelCJSJ.frame.size.height+labelCJSJ.frame.origin.y+5, 300, 15)];
    labelFKSJ.text=@"付款时间：2014-04-20 19：34：34";
    labelFKSJ.textColor=hui5;
    labelFKSJ.textAlignment=0;
    labelFKSJ.font=[UIFont systemFontOfSize:12];
    [bottomImg addSubview:labelFKSJ];
    
    UILabel *labelHJ=[[UILabel alloc]initWithFrame:CGRectMake(10, labelFKSJ.frame.size.height+labelFKSJ.frame.origin.y+5, 40, 15)];
    labelHJ.text=@"合计：";
    labelHJ.textColor=hui5;
    labelHJ.textAlignment=0;
    labelHJ.font=[UIFont systemFontOfSize:12];
    [bottomImg addSubview:labelHJ];
    
    UILabel *labelHJ_detail=[[UILabel alloc]initWithFrame:CGRectMake(labelHJ.frame.size.width+labelHJ.frame.origin.x, labelHJ.frame.origin.y, 100, 15)];
    labelHJ_detail.text=@"￥200.00";
    labelHJ_detail.textColor=hongShe;
    labelHJ_detail.textAlignment=0;
    labelHJ_detail.font=[UIFont systemFontOfSize:12];
    [bottomImg addSubview:labelHJ_detail];
    
    UIButton *btnLXMJ=[UIButton buttonWithType:0];
    btnLXMJ.frame=CGRectMake(bottomImg.frame.size.width-84, labelHJ_detail.frame.origin.y-8, 74, 29);
    [btnLXMJ setImage:BundleImage(@"contactbutton.png") forState:0];
    [btnLXMJ addTarget:self action:@selector(btnLXMJ:) forControlEvents:UIControlEventTouchUpInside];
    [bottomImg addSubview:btnLXMJ];
    
    
}

-(void)btnLXMJ:(id)sender
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"确定要联系卖家吗？" message:@"13921345678" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    alert.tag=-1000;
    [alert show];
    
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==-1000&&buttonIndex==1)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",@"13912345678"]]];
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
        cell.backgroundColor=[UIColor clearColor];
    }
    //    if(self.newsArray.count == 0 || indexPath.row>self.newsArray.count)
    
    UIImageView *bgImg=[[UIImageView alloc]initWithFrame:CGRectMake(320/2-297/2, 0, 297, 85)];
    bgImg.image=BundleImage(@"ddmj_2.png");
    [cell addSubview:bgImg];
    
    UIImageView *bImageV=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 66, 66)];
    bImageV.image=BundleImage(@"bg_01_l.png");
    bImageV.backgroundColor=[UIColor clearColor];
    [bgImg addSubview:bImageV];
    
    
    UrlImageView * imgvw = [[UrlImageView alloc]initWithFrame:CGRectMake(5, 4, 56, 56)];
    imgvw.layer.cornerRadius = 4;
    imgvw.image=BundleImage(@"df_01_.png");
    [bImageV addSubview:imgvw];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(bImageV.frame.size.width+bImageV.frame.origin.x+8, bImageV.frame.origin.y, 160, 20)];
    //    NSString *headStr = [[self.newsArray objectAtIndex:indexPath.row] objectForKey:@"mainHeading"];
    //    label.text=headStr;
    label.text=@"韩版钩花蕾丝衫";
    label.textColor=hui2;
    label.font=[UIFont systemFontOfSize:12];
    label.backgroundColor=[UIColor clearColor];
    [bgImg addSubview:label];
    
    
    //    gbt_04_@2x
    imgv_arrow=[[UIImageView alloc]initWithFrame:CGRectMake(label.frame.size.width+label.frame.origin.x+5, label.frame.origin.y-10, 45, 40)];
    imgv_arrow.image=BundleImage(@"gbt_04_.png");
    [bgImg addSubview:imgv_arrow];
    
    if (selectCount%2!=0/*&&[_marrayAll count]>1*/)
    {
        if (indexPath.row==0)
        {
            imgv_arrow.transform = CGAffineTransformMakeRotation(M_PI*1.5);
            [imgv_arrow setAnimationDuration:2.0];
            //        [lb_goods setHidden:YES];
            //        lb_total.frame=CGRectMake(90, 50, 180, 14);
            
        }else {
            imgv_arrow.hidden=YES;
            
        }
        
    }
    else if(selectCount%2==0)
    {
        imgv_arrow.transform = CGAffineTransformMakeRotation(M_PI*0.5);
        
    }else{
        
        if (indexPath.row==0)
        {
            imgv_arrow.transform = CGAffineTransformMakeRotation(M_PI*1.5);
            
        }else{
            
            imgv_arrow.hidden=YES;
            
        }
        
    }
    
    
    UILabel *labelKS=[[UILabel alloc]initWithFrame:CGRectMake(label.frame.origin.x, label.frame.origin.y+label.frame.size.height+5, 130, 15)];
    //    labelDetail.text=[[self.newsArray objectAtIndex:indexPath.row] objectForKey:@"subHeading"];
    labelKS.text=@"款式：灰色";
    labelKS.backgroundColor=[UIColor clearColor];
    labelKS.font=[UIFont systemFontOfSize:12];
    labelKS.numberOfLines=0;
    labelKS.textColor=hui5;
    [bgImg addSubview:labelKS];
    
    
    UILabel *labelCM=[[UILabel alloc]initWithFrame:CGRectMake(labelKS.frame.size.width+labelKS.frame.origin.x+5, labelKS.frame.origin.y, 70, 15)];
    labelCM.text=@"尺码：M";
    labelCM.font=[UIFont systemFontOfSize:12];
    labelCM.backgroundColor=[UIColor clearColor];
    labelCM.textColor =hui5;
    labelCM.textAlignment=0;
    [bgImg addSubview:labelCM];
    
    
    UILabel *labelJG=[[UILabel alloc]initWithFrame:CGRectMake(labelKS.frame.origin.x, labelKS.frame.size.height+labelKS.frame.origin.y+5, 130, 15)];
    
    labelJG.backgroundColor=[UIColor clearColor];
    labelJG.font=[UIFont systemFontOfSize:12];
    labelJG.text=@"价格：￥88.00";
    labelJG.textColor=hui5;
    [bgImg addSubview:labelJG];
    
    
    UILabel *labelSL=[[UILabel alloc]initWithFrame:CGRectMake(labelJG.frame.size.width+labelJG.frame.origin.x+5, labelJG.frame.origin.y, 70, 15)];
    labelSL.text=@"数量：1";
    labelSL.font=[UIFont systemFontOfSize:12];
    labelSL.backgroundColor=[UIColor clearColor];
    labelSL.textColor =hui5;
    labelSL.textAlignment=0;
    [bgImg addSubview:labelSL];
    
    
    
    CGRect cellFrame = [cell frame];
    cellFrame.origin=CGPointMake(5, 5);
    cellFrame.size.width=320;
    cellFrame.size.height=imgvw.frame.size.height+15;
    [cell setFrame:cellFrame];
    
    UIImageView *_line=[[UIImageView alloc]initWithFrame:CGRectMake(10, 85-1, 300, 1)];
    _line.image=[UIImage imageNamed:@"gwc_line_.png"];
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
    return 85;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (selectCount%2==0)
    {
        
        return 1;
        
    }else{
        
        return 4;
        
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    [self viewWillAppear:YES];
    selectCount+=1;
    imgv_arrow.transform = CGAffineTransformMakeRotation(M_PI*1.5);
    [imgv_arrow setAnimationDuration:2.0];
    [_tableView reloadData];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
