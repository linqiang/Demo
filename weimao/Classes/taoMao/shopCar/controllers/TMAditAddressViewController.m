//
//  TMAditAddressViewController.m
//  TaoMao
//
//  Created by mac on 14-4-22.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "TMAditAddressViewController.h"
#import "TMAddAddressViewController.h"

@interface TMAditAddressViewController ()

@end

@implementation TMAditAddressViewController

-(UIView*)initNavigationBar
{
    view_bar =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
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
    UILabel *title_label=[[UILabel alloc]initWithFrame:CGRectMake(65, view_bar.frame.size.height-44, self.view.frame.size.width-130, 44)];
    title_label.text=@"我的收货地址";
    title_label.font=[UIFont boldSystemFontOfSize:20];
    title_label.backgroundColor=[UIColor clearColor];
    title_label.textColor =[UIColor whiteColor];
    title_label.textAlignment=1;
    [view_bar addSubview:title_label];
    

    UIImageView*leftImageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-60, (44-37)/2, 2,37)];
    leftImageView.image=BundleImage(@"navigation_bar_line.png");
    [view_bar addSubview:leftImageView];
    [self.view addSubview:view_bar];
    
    UIButton*btnBack=[UIButton buttonWithType:0];
    btnBack.frame=CGRectMake(0, view_bar.frame.size.height-34, 47, 34);
    [btnBack setImage:BundleImage(@"ret_01.png") forState:0];
    [btnBack addTarget:self action:@selector(btnBack:) forControlEvents:UIControlEventTouchUpInside];
    [view_bar addSubview:btnBack];
    
    
    
    UIButton*btnAdd=[UIButton buttonWithType:0];
    btnAdd.frame=CGRectMake(view_bar.frame.size.width-55, view_bar.frame.size.height-40, 47, 34);
    [btnAdd setTitle:@"新增" forState:0];
    [btnAdd setTitleColor:[UIColor whiteColor] forState:0];
    [btnAdd addTarget:self action:@selector(btnAdd:) forControlEvents:UIControlEventTouchUpInside];
    [view_bar addSubview:btnAdd];
 

  
    [title_label release];
    [view_bar release];

    return view_bar;
}
-(void)btnAdd:(id)sender
{

    TMAddAddressViewController *addAddress=[[TMAddAddressViewController alloc]init];
    TMAppDelegate *delegate=(TMAppDelegate*)[UIApplication sharedApplication].delegate;
    [delegate.navigationController pushViewController:addAddress animated:NO];

}
-(void)btnHome:(id)sender
{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"backHome" object:nil];
}
-(void)btnBack:(id)sender
{
    TMAppDelegate *app=(TMAppDelegate*)[UIApplication sharedApplication].delegate;
    [app.navigationController popViewControllerAnimated:YES];
    
}
-(void)btnEdit:(id)sender
{

    TMAddAddressViewController *addAddress=[[TMAddAddressViewController alloc]init];
    TMAppDelegate *delegate=(TMAppDelegate*)[UIApplication sharedApplication].delegate;
    [delegate.navigationController pushViewController:addAddress animated:NO];
}
-(void)btnDelete:(id)sender
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"你确定要删除吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    alert.tag=-100;
    [alert show];
    [alert release];

}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==-100&&buttonIndex==0)
    {
      //删除数据，RELOAD
//        _index
    }

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNavigationBar];

    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, view_bar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-view_bar.frame.size.height)style:UITableViewStylePlain];
    _tableView.userInteractionEnabled=YES;
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.backgroundView=nil;
    _tableView.backgroundColor=[UIColor colorWithRed:.95 green:.95 blue:.95 alpha:1.0];
    _tableView.showsHorizontalScrollIndicator=NO;
    _tableView.showsVerticalScrollIndicator=NO;
    _tableView.separatorColor=[UIColor clearColor];
    //    self.view.backgroundColor=[UIColor colorWithRed:.5 green:.5 blue:.5 alpha:1.0];
    [self.view addSubview:_tableView];

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
        cell.backgroundColor=[UIColor colorWithRed:.95 green:.95 blue:.95 alpha:1.0];
        cell.accessoryType=UITableViewCellAccessoryNone;
        cell.selected=NO;
        cell.tag=1000+indexPath.row;
        _index=indexPath.row;

        
        UIView *_view1=[[UIView alloc] initWithFrame:CGRectMake(10, 10, 300, 102)];

        UIImageView*imageBG=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 102)];
        imageBG.tag=10000+indexPath.row;
        
        if (indexPath.row==0) {
      
            imageBG.image=BundleImage(@"xz_s_.png");
        }else{
        
            imageBG.image=BundleImage(@"xz_n_.png");

        }
    
        [_view1 addSubview:imageBG];
        [cell addSubview:_view1];
        
        //颜色
        UILabel*labelColor=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 105, 20)];
        labelColor.textAlignment=0;
        labelColor.font=[UIFont systemFontOfSize:12];
        labelColor.textColor=hui2;
        labelColor.text=@"阿萨德发说";
        labelColor.backgroundColor=[UIColor clearColor];
        [_view1 addSubview:labelColor];
        //尺码
        UILabel*labelRuler=[[UILabel alloc]initWithFrame:CGRectMake(labelColor.frame.origin.x+labelColor.frame.size.width, labelColor.frame.origin.y, 100, 20)];
        labelRuler.textAlignment=0;
        labelRuler.font=[UIFont systemFontOfSize:12];
        labelRuler.textColor=hui2;
        labelRuler.text=@"13912345678";
        labelRuler.backgroundColor=[UIColor clearColor];
        [_view1 addSubview:labelRuler];
        // 单价
        UILabel*labelPrice=[[UILabel alloc]initWithFrame:CGRectMake(labelColor.frame.origin.x, labelColor.frame.origin.y+labelColor.frame.size.height, 280, 40)];
        labelPrice.textAlignment=0;
        labelPrice.font=[UIFont systemFontOfSize:12];
        labelPrice.textColor=[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
        //        NSArray *arr=[NSArray arrayWithArray:_arrayPrice];
        labelPrice.numberOfLines=2;
        labelPrice.text=[NSString stringWithFormat:@"江苏省常州市天宁区普南新村443幢甲单元601室江苏省常州市天宁区普南新村443幢甲单元601室"];
        labelPrice.backgroundColor=[UIColor clearColor];
        [_view1 addSubview:labelPrice];
        
    
        //checkbox@2x
        UIImageView *checkBtn=[[UIImageView alloc]init];
        checkBtn.frame=CGRectMake(0, _view1.frame.size.height-33, 92, 33);
        checkBtn.tag=100+indexPath.row;
        
        if (indexPath.row==0) {
              checkBtn.image=BundleImage(@"xz_mr_s_.png");
        }else{
            checkBtn.image=BundleImage(@"xz_mr_n_.png");
        
        }
      
        [_view1 addSubview:checkBtn];
        

        UIButton *btnDelete=[UIButton buttonWithType:0];
        btnDelete.frame=CGRectMake(checkBtn.frame.size.width+checkBtn.frame.origin.x+20, checkBtn.frame.origin.y, 62, 34);
        [btnDelete setBackgroundImage:BundleImage(@"xz_sc_.png") forState:0];
        [btnDelete addTarget:self action:@selector(btnDelete:) forControlEvents:UIControlEventTouchUpInside];
        //        if (btnDelete.highlighted) {
        //            [btnDelete setBackgroundImage:BundleImage(@"number_up_click.png") forState:0];
        //        }
        btnDelete.tag=indexPath.row+1000000;
        [_view1 addSubview:btnDelete];

        //按钮
        
        UIButton *btnEdit=[UIButton buttonWithType:0];
        btnEdit.frame=CGRectMake(btnDelete.frame.size.width+btnDelete.frame.origin.x+10, btnDelete.frame.origin.y-1, 62, 34);
        btnEdit.tag=indexPath.row;
        [btnEdit setImage:BundleImage(@"xz_bg.png") forState:0];
        [btnEdit addTarget:self action:@selector(btnEdit:) forControlEvents:UIControlEventTouchUpInside];
        [_view1 addSubview:btnEdit];
        
        
//        [labelPrice release];
//        CGRect cellFrame = [cell frame];
//        cellFrame.origin=CGPointMake(5, 5);
//        cellFrame.size.width=320;
//        cellFrame.size.height=imgView.frame.size.height+10;
//        [cell setFrame:cellFrame];
    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{

    UIImageView*imageBJ=(UIImageView*)[tableView viewWithTag:10000+indexPath.row];
    imageBJ.image=BundleImage(@"xz_n_.png");
    UIImageView*btnImage=(UIImageView*)[self.view viewWithTag:100+indexPath.row];
    btnImage.image=BundleImage(@"xz_mr_n_.png");
    _index=indexPath.row;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row!=0)
    {
        UIImageView*imageBJ=(UIImageView*)[tableView viewWithTag:10000];
        imageBJ.image=BundleImage(@"xz_n_.png");
        UIImageView*btnImage=(UIImageView*)[self.view viewWithTag:100];
        btnImage.image=BundleImage(@"xz_mr_n_.png");

    }
    UIImageView*imageBJ=(UIImageView*)[tableView viewWithTag:10000+indexPath.row];
    imageBJ.image=BundleImage(@"xz_s_.png");
    UIImageView*btnImage=(UIImageView*)[self.view viewWithTag:100+indexPath.row];
    btnImage.image=BundleImage(@"xz_mr_s_.png");
    NSIndexPath*path=[NSIndexPath indexPathForRow:imageBJ.tag-100 inSection:0];
    UITableViewCell*cell=(UITableViewCell*)[tableView viewWithTag:indexPath.row+1000];
  
//    _index=indexPath.row;

    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
//    NSMutableArray* tempArray2 = [[NSMutableArray alloc] init];
    
    [indexSet addIndex:[path row]];//添加指定单元行的下标

    _index=indexPath.row;
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
