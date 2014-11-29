//
//  TMMySotreViewController.m
//  TaoMao
//
//  Created by mac on 14-4-24.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "TMMySotreViewController.h"
#import "TMGoodsDetailsViewController.h"
#import "TMAddGoodsViewController.h"
#import "TMMyClientOrdersViewController.h"

@interface TMMySotreViewController ()

@end

@implementation TMMySotreViewController

-(id)initWithTabbar:(BOOL)tabbar
{
    self=[super init];
    if (self) {
        _isTabbar=tabbar;
    }
    return self;
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
    
    [self.view addSubview: view_bar];
    UILabel *title_label=[[UILabel alloc]initWithFrame:CGRectMake(65, view_bar.frame.size.height-44, self.view.frame.size.width-130, 44)];
    title_label.text=@"我的店铺";
    title_label.font=[UIFont boldSystemFontOfSize:20];
    title_label.backgroundColor=[UIColor clearColor];
    title_label.textColor =[UIColor whiteColor];
    title_label.textAlignment=1;
    [view_bar addSubview:title_label];
    
    UIButton*btnAdd=[UIButton buttonWithType:0];
    btnAdd.frame=CGRectMake(10, view_bar.frame.size.height-34, 47, 34);
    [btnAdd setTitle:@"添加" forState:0];
    [btnAdd addTarget:self action:@selector(btnAdd:) forControlEvents:UIControlEventTouchUpInside];
    [view_bar addSubview:btnAdd];
    
    
    UIButton*btnDD=[UIButton buttonWithType:0];
    btnDD.frame=CGRectMake(view_bar.frame.size.width-55, view_bar.frame.size.height-40, 47, 34);
    
    [btnDD setTitle:@"订单" forState:0];
    [btnDD addTarget:self action:@selector(btnDD:) forControlEvents:UIControlEventTouchUpInside];
    [view_bar addSubview:btnDD];
    
    
    [title_label release];
    
    return view_bar;
}
-(void)initHeaderView
{

//300*75
    _tableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(10, 0, 320, 140)];
    _tableView.tableHeaderView.userInteractionEnabled=YES;
    _tableView.tableHeaderView.backgroundColor=[UIColor clearColor];
    [_tableView addSubview:_tableView.tableHeaderView];
    
    UIImageView *headView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 300, 75)];
    headView.image=BundleImage(@"cjdp_bg_02_.png");
    headView.userInteractionEnabled=YES;
    [_tableView.tableHeaderView addSubview:headView];
//    df_01
    
    img_headSculpture=[[UrlImageButton alloc]initWithFrame:CGRectMake(10, 10, 51, 51)];
//    imageHead.image=BundleImage(@"tt_tutu_01.png");
    [img_headSculpture addTarget:self action:@selector(popActionSheet) forControlEvents:UIControlEventTouchUpInside];
    [img_headSculpture setImage:BundleImage(@"tt_tutu_01.png") forState:0];
    [headView addSubview:img_headSculpture];
    
    UILabel *title_label=[[UILabel alloc]initWithFrame:CGRectMake(img_headSculpture.frame.size.width+img_headSculpture.frame.origin.x+10, img_headSculpture.frame.origin.y, self.view.frame.size.width-130, 20)];
    title_label.text=@"哈小妮";
    title_label.font=[UIFont systemFontOfSize:14];
    title_label.backgroundColor=[UIColor clearColor];
    title_label.textColor =hui2;
    title_label.textAlignment=0;
    [headView addSubview:title_label];

//    UIButton *labelDM=[[UIButton alloc]initWithFrame:CGRectMake(title_label.frame.origin.x, title_label.frame.origin.y+title_label.frame.size.height+10, 20, 15)];
//    [labelDM addTarget:self action:@selector(labelDM:) forControlEvents:UIControlEventTouchUpInside];
//    labelDM.titleLabel.font=[UIFont systemFontOfSize:12];
//    labelDM.backgroundColor=[UIColor clearColor];
//    [labelDM setTitleColor:[UIColor blueColor] forState:0];
//    labelDM.titleLabel.textAlignment=0;
//     NSString *string=@"微店：http//wd.haeqtrqetqtqtqertqrtxiaomi.com";
//    [labelDM setTitle:string forState:0];
    
    UILabel *labelDM=[[UILabel alloc]initWithFrame:CGRectMake(65, title_label.frame.size.height+title_label.frame.origin.y, self.view.frame.size.width-130, 30)];
    labelDM.text=@"微店微店微店微店微店微店微店微店微店微店微店微店微店微店微店微店";
    labelDM.font=[UIFont boldSystemFontOfSize:12];

    labelDM.textColor =hui5
    labelDM.numberOfLines=2;
    labelDM.textAlignment=0;
    //    title_label.shadowColor = [UIColor darkGrayColor];
    //    title_label.shadowOffset = CGSizeMake(1, 1);
    [view_bar addSubview:labelDM];
    
    UILabel*lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 20, 15)];
    lab.text=@"微店微店微店微店微店微店微店微店微店微店微店微店微店微店微店微店";
    //列宽
    CGFloat contentWith1=320-20;
    //显示字体
    UIFont *font1=[UIFont systemFontOfSize:12];
    labelDM.font=font1;
    //        NSString *name=@"12345";
    CGSize size1=[lab.text sizeWithFont:font1 constrainedToSize:CGSizeMake(contentWith1, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
    
    CGRect rect=[lab textRectForBounds:labelDM.frame limitedToNumberOfLines:0];
    rect.size = size1;
    labelDM.frame=rect;
    
    if ( rect.size.width>220.0) {
        rect.size.width= 220.0;
    }
 
    
    [labelDM setFrame:CGRectMake(title_label.frame.origin.x, title_label.frame.origin.y+title_label.frame.size.height, rect.size.width, rect.size.height)];
    labelDM.backgroundColor=[UIColor clearColor];
    [headView addSubview:labelDM];
    
    NSArray *array=[[NSArray alloc]initWithObjects:@"上架时间",@"销量",@"库存",@"己售完", nil];
    
    for (int i=0; i<4; i++) {
        UIButton *btn=[UIButton buttonWithType:0];
        btn.frame=CGRectMake((i%4)*77+12, floor(i/4)*40+img_headSculpture.frame.size.height+img_headSculpture.frame.origin.y+35,65, 30);
        btn.backgroundColor=[UIColor whiteColor];
        btn.layer.cornerRadius=4;
        btn.layer.borderWidth=1;
        btn.layer.borderColor=[UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1.0].CGColor;
        [btn setTitleColor:[UIColor colorWithRed:.2 green:.2 blue:.2 alpha:1.0] forState:0];
        btn.titleLabel.font=[UIFont systemFontOfSize:13];
        [btn setTitle:[array objectAtIndex:i] forState:0];
        [btn addTarget:self action:@selector(btnOrder:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=100000+i;
        [_tableView.tableHeaderView addSubview:btn];
    }
}
-(void)btnOrder:(id)sender
{
    UIButton *button=(UIButton*)sender;
    UIButton *btn1=(UIButton*)[self.view viewWithTag:touchID];
    btn1.backgroundColor=[UIColor whiteColor];
    
    if (touchID>0) {
        
        [btn1 setTitleColor:[UIColor colorWithRed:.2 green:.2 blue:.2 alpha:1.0] forState:0];
    }
    [button setTitleColor:[UIColor whiteColor] forState:0];
    
    if (button.tag==touchID) {
        UIButton *btn=(UIButton*)[self.view viewWithTag:touchID];
        btn.backgroundColor=[UIColor clearColor];
        
    }else{
        
        button.backgroundColor=hongShe;
        touchID=button.tag;
    }


}
-(void)labelDM:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",@"http//wd.haxiaomi.com"]]];


}
-(void)btnDD:(id)sender
{
    TMMyClientOrdersViewController *clientOrders=[[TMMyClientOrdersViewController alloc]init];
    TMAppDelegate *delegate=(TMAppDelegate*)[UIApplication sharedApplication].delegate;
    [delegate.navigationController pushViewController:clientOrders animated:YES];
}
-(void)btnAdd:(id)sender
{
    TMAddGoodsViewController *goods=[[TMAddGoodsViewController alloc]init];
    TMAppDelegate *delegate=(TMAppDelegate*)[UIApplication sharedApplication].delegate;
    [delegate.navigationController pushViewController:goods animated:YES];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNavigationBar];
    touchID=0;
    
    if (_isTabbar==YES)
    {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, view_bar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-view_bar.frame.size.height-49)style:UITableViewStylePlain];
        _tableView.userInteractionEnabled=YES;
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundView=nil;
        _tableView.backgroundColor=[UIColor colorWithRed:.98 green:.98 blue:.98 alpha:1.0];
        _tableView.showsHorizontalScrollIndicator=NO;
        _tableView.showsVerticalScrollIndicator=NO;
        _tableView.separatorColor=[UIColor clearColor];
        //    self.view.backgroundColor=[UIColor colorWithRed:.5 green:.5 blue:.5 alpha:1.0];
        [self.view addSubview:_tableView];
    }else{
    
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, view_bar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-view_bar.frame.size.height-49)style:UITableViewStylePlain];
        _tableView.userInteractionEnabled=YES;
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundView=nil;
        _tableView.backgroundColor=[UIColor colorWithRed:.98 green:.98 blue:.98 alpha:1.0];
        _tableView.showsHorizontalScrollIndicator=NO;
        _tableView.showsVerticalScrollIndicator=NO;
        _tableView.separatorColor=[UIColor clearColor];
        //    self.view.backgroundColor=[UIColor colorWithRed:.5 green:.5 blue:.5 alpha:1.0];
        [self.view addSubview:_tableView];
    
    }
 
    [self initHeaderView];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cate_cell";
    
    UITableViewCell*   cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.editingAccessoryType=UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType=UITableViewCellAccessoryNone;
        cell.selected=NO;
        cell.tag=1000+indexPath.row;
        cell.backgroundColor=[UIColor whiteColor];

        
        
        UIImageView *imageHead=[[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 300, 100)];
        imageHead.image=BundleImage(@"cjdp_bg_02_.png");
        [cell addSubview:imageHead];
        
//        UIImageView *imageJ=[[UIImageView alloc]initWithFrame:CGRectMake(imageHead.frame.size.width-44, (imageHead.frame.size.height-70)/2, 44, 70)];
//        imageJ.image=BundleImage(@"bt_04_J.png");
//        [imageHead addSubview:imageJ];
        
        UrlImageView *headImg=[[UrlImageView alloc]initWithFrame:CGRectMake(10, 10, 51, 51)];
        headImg.image=BundleImage(@"df_01.png");
        headImg.backgroundColor=[UIColor clearColor];
        [imageHead addSubview:headImg];
        
        

        
//        UrlImageView*imgView=[[UrlImageView alloc]initWithFrame:CGRectMake(20, 10, 56,56)];
        
        //        if ([[[[_marrayAll objectAtIndex:indexPath.row]productList]objectAtIndex:0] icon]==nil)
        //        {
        
        //        }else
        //        {
        //            [imgView setImageWithURL:[NSURL URLWithString:_url]];
        //
        //        }
        
        //        [cell addSubview:imgView];
        
        //title店铺名
        UILabel*title=[[UILabel alloc]initWithFrame:CGRectMake(headImg.frame.size.width+headImg.frame.origin.y+10, headImg.frame.origin.y, 90, 20)];
        title.backgroundColor=[UIColor clearColor];
        title.textAlignment=0;
        title.text=@"魅典幻镜";
        title.textColor=[UIColor colorWithRed:.2 green:.2 blue:.2 alpha:1.0];
        title.font=[UIFont systemFontOfSize:14];
        [imageHead addSubview:title];
        
        //店铺介绍详情
        UILabel*title2=[[UILabel alloc]initWithFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+title.frame.size.height+10, 30, 20)];
        title2.textAlignment=0;
        title2.font=[UIFont systemFontOfSize:14];
        title2.textColor=hui3;
        title2.text=@"价格";
        title2.numberOfLines=0;
        title2.backgroundColor=[UIColor clearColor];
        [imageHead addSubview:title2];
        
        UILabel*title3=[[UILabel alloc]initWithFrame:CGRectMake(title2.frame.origin.x+title2.frame.size.width, title2.frame.origin.y, 100, 20)];
        title3.textAlignment=0;
        title3.font=[UIFont systemFontOfSize:14];
        title3.textColor=hongShe;
        title3.text=@"￥139.00";
        title3.numberOfLines=0;
        title3.backgroundColor=[UIColor clearColor];
        [imageHead addSubview:title3];
        
//        CGRect cellFrame = [cell frame];
//        cellFrame.origin=CGPointMake(5, 5);
//        cellFrame.size.width=320;
//        cellFrame.size.height=headImg.frame.size.height+10;
//        [cell setFrame:cellFrame];
//        [headImg release];
        
//        dd_store_01@2x
        UIImageView*image_Xl=[[UIImageView alloc]initWithFrame:CGRectMake(headImg.frame.origin.x, headImg.frame.origin.y+headImg.frame.size.height+10, 14, 14)];
        image_Xl.image=BundleImage(@"dd_store_01.png");
        [imageHead addSubview:image_Xl];
        
        UILabel *label_XL=[[UILabel alloc]initWithFrame:CGRectMake(image_Xl.frame.origin.x+image_Xl.frame.size.width, image_Xl.frame.origin.y, 80, 15)];
        label_XL.text=@"销量:108";
        label_XL.font=[UIFont systemFontOfSize:14];
        label_XL.backgroundColor=[UIColor clearColor];
        label_XL.textColor =hui3;
        label_XL.textAlignment=0;
        [imageHead addSubview:label_XL];

        UIImageView*image_KC=[[UIImageView alloc]initWithFrame:CGRectMake(label_XL.frame.origin.x+label_XL.frame.size.width, label_XL.frame.origin.y, 14, 14)];
        image_KC.image=BundleImage(@"dd_store_02.png");
        [imageHead addSubview:image_KC];
        
        UILabel *label_KC=[[UILabel alloc]initWithFrame:CGRectMake(image_KC.frame.origin.x+image_KC.frame.size.width, image_KC.frame.origin.y, 80, 15)];
        label_KC.text=@"库存:299";
        label_KC.font=[UIFont systemFontOfSize:14];
        label_KC.backgroundColor=[UIColor clearColor];
        label_KC.textColor =hui3;
        label_KC.textAlignment=0;
        [imageHead addSubview:label_KC];
        
        UIImageView*image_RQ=[[UIImageView alloc]initWithFrame:CGRectMake(label_KC.frame.origin.x+label_KC.frame.size.width, label_KC.frame.origin.y, 14, 14)];
        image_RQ.image=BundleImage(@"dd_store_03.png");
        [imageHead addSubview:image_RQ];
        
        UILabel *label_RQ=[[UILabel alloc]initWithFrame:CGRectMake(image_RQ.frame.origin.x+image_RQ.frame.size.width, image_RQ.frame.origin.y, 80, 15)];
        label_RQ.text=@"日期:4-24";
        label_RQ.font=[UIFont systemFontOfSize:14];
        label_RQ.backgroundColor=[UIColor clearColor];
        label_RQ.textColor =hui3;
        label_RQ.textAlignment=0;
        [imageHead addSubview:label_RQ];

    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    TMGoodsDetailsViewController *goods=[[TMGoodsDetailsViewController alloc]init];
//    TMAppDelegate *delegate=(TMAppDelegate*)[UIApplication sharedApplication].delegate;
//    [delegate.navigationController pushViewController:goods animated:YES];

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return 110;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}

- (void)popActionSheet
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:@"拍照上传"
                                                    otherButtonTitles:@"本地照片上传",nil];
    [actionSheet setBackgroundColor:[UIColor clearColor]];
    actionSheet.tag = -2;
    [actionSheet showInView:self.view];
}
#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController * picker = [[UIImagePickerController alloc]init];
    switch (buttonIndex)
    {
            
            
        case 0://take photo
        {
            //            [self presentModalViewController:picker animated:YES];
            [self presentViewController:picker animated:YES completion:nil];
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.allowsEditing = YES;
            picker.delegate = self;
            
            break;
        }
        case 1://upload image
        {
            
            
//            [self presentViewController:elcPicker animated:YES completion:nil];
            [self presentViewController:picker animated:YES completion:nil];
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.allowsEditing = YES;
            picker.delegate = self;
            
            break;
        }
        case 2://cancel
        {
            //            [self.presentedViewController dismissModalViewControllerAnimated:YES];
            break;
        }
        default:
            break;
    }
    [picker release];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    /*添加处理选中图像代码*/
    [picker dismissModalViewControllerAnimated:YES];
    img_head =[[UIImage alloc] init];
    img_head=image;
    
    [img_headSculpture setImage:image forState:0];
    
    data_imghead=[[NSData dataWithData:UIImageJPEGRepresentation(image,1)] retain];
    if (data_imghead);
    else
    {
        data_imghead = UIImageJPEGRepresentation(image, 1);
    }
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"datahead"];
    [[NSUserDefaults standardUserDefaults]setObject:data_imghead forKey:@"datahead"];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    /*添加代码，处理选中图像又取消的情况*/
    //    [picker dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
