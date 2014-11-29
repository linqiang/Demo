//
//  LTKSeachResultViewController.m
//  LvTongKa
//
//  Created by 123 on 13-8-27.
//  Copyright (c) 2013年 呵呵. All rights reserved.
//

#import "LTKSeachResultViewController.h"
#import "TMGoodsDetailsViewController.h"
#import "TMShopStoreDetailScrollController.h"
#import "TMThirdClassViewController.h"

@interface LTKSeachResultViewController ()



@end

@implementation LTKSeachResultViewController
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
-(BOOL)prefersStatusBarHidden
{
    return  NO;
}
-(void)dealloc
{
    [seachField release];
    [_scrollView release];
    [hotLabel release];
    [_tableView release];
    [_keyWords release];
    [_marrayAll release];
    [appDelegate release];
    [super dealloc];

}
-(id)initSeachKeyWords:(NSString*)keyWords addSeachString:(NSString *)string
{
    self = [super init];
    if (self) {
        _keyWords=[[NSString alloc]initWithString:keyWords];
        _seachString=[[NSString alloc]initWithString:string];
        
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
    title_label.text=@"快寻";
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
    
    
//    UIButton*btnTJ=[UIButton buttonWithType:0];
//    btnTJ.frame=CGRectMake(view_bar.frame.size.width-55, view_bar.frame.size.height-40, 47, 34);
//    
//    [btnTJ setTitle:@"完成" forState:0];
//    [btnTJ addTarget:self action:@selector(btnTJ:) forControlEvents:UIControlEventTouchUpInside];
//    [view_bar addSubview:btnTJ];
    
    
    [title_label release];
    
    return view_bar;
}
-(void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;

}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    }
-(void)viewDidDisappear:(BOOL)animated
{
    
}


-(void)initToolBar
{
    
    UIImageView*line;
    
    imageViewToolBar.backgroundColor=[UIColor clearColor];
    imageViewToolBar=[[UIImageView alloc]initWithFrame:CGRectMake(0, self.searchBar.frame.size.height+self.searchBar.frame.origin.y, self.view.frame.size.width,35 )];
    imageViewToolBar.backgroundColor=[UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1.0];
    imageViewToolBar.userInteractionEnabled=YES;
    imageViewToolBar.hidden=NO;
//    [self.view insertSubview:imageViewToolBar aboveSubview:_tableView];

    
    BtnItem2.backgroundColor=[UIColor clearColor];
    BtnItem1.backgroundColor=[UIColor clearColor];
    BtnItem1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [BtnItem1 setFrame:CGRectMake(0, 0, 320/2, 35)];
    BtnItem1.exclusiveTouch=YES;
    BtnItem1.tag = 100;
    [BtnItem1 setTitle:@"宝贝" forState:0];
    BtnItem1.titleLabel.font=[UIFont systemFontOfSize:14];
    BtnItem1.titleLabel.textAlignment=1;
    BtnItem1.titleLabel.textColor=   hongShe;
    BtnItem1.layer.borderColor=[UIColor colorWithRed:.95 green:.95 blue:.95 alpha:1.0].CGColor;
    BtnItem1.backgroundColor=[UIColor whiteColor];
    [BtnItem1 addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
    [imageViewToolBar addSubview:BtnItem1];
    
    
    BtnItem2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [BtnItem2 setFrame:CGRectMake(320/2*1+1, 0, 320/2, 35)];
    BtnItem2.exclusiveTouch=YES;
    BtnItem2.tag = 101;
    BtnItem2.backgroundColor=[UIColor colorWithRed:.95 green:.95 blue:.95 alpha:1.0];
    [BtnItem2 setTitle:@"商家" forState:0];
    [BtnItem2 setTitleColor:[UIColor colorWithRed:.5 green:.5 blue:.5 alpha:1.0] forState:0];
    BtnItem2.titleLabel.font=[UIFont systemFontOfSize:14];
    [BtnItem2 addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
    [imageViewToolBar addSubview:BtnItem2];
    
    
    line=[[UIImageView alloc]initWithFrame:CGRectMake(0, imageViewToolBar.frame.size.height-1, 320, 1)];
    line.image=BundleImage(@"line_01_.png");
    [imageViewToolBar addSubview:line];
    
    tabBarArrow=[[UIImageView alloc]init];
    tabBarArrow.frame = CGRectMake([self horizontalLocationFor:0], 34, 320/2, 2);
    tabBarArrow.image=BundleImage(@"line_p_.png");
    [imageViewToolBar addSubview:tabBarArrow];

//    _tableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
//    [_tableView addSubview:_tableView.tableHeaderView];
    [self.view addSubview:imageViewToolBar];
    
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
        _isFirstView=YES;
        [BtnItem1 setTitleColor:[UIColor colorWithRed:1.0 green:.23 blue:.49 alpha:1.0] forState:0]   ;
        [BtnItem2 setTitleColor:[UIColor colorWithRed:.5 green:.5 blue:.5 alpha:1.0] forState:0]   ;
        BtnItem1.backgroundColor=[UIColor whiteColor];
        BtnItem2.backgroundColor=[UIColor colorWithRed:.95 green:.95 blue:.95 alpha:1.0];
        
        [_tableView reloadData];
       
        
    }else if(btn.tag==101)
    {
        _isFirstView=NO;
        [BtnItem2 setTitleColor:[UIColor colorWithRed:1.0 green:.23 blue:.49 alpha:1.0] forState:0]   ;
        [BtnItem1 setTitleColor:[UIColor colorWithRed:.5 green:.5 blue:.5 alpha:1.0] forState:0]   ;
        BtnItem1.backgroundColor=[UIColor colorWithRed:.95 green:.95 blue:.95 alpha:1.0];
        BtnItem2.backgroundColor=[UIColor whiteColor];
        
        [_tableView reloadData];
    }
    
}
- (CGFloat) horizontalLocationFor:(NSUInteger)tabIndex
{
    CGFloat tabItemWidth = self.view.frame.size.width/2;
    return (tabIndex * tabItemWidth);
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
    self.navigationController.navigationBarHidden=YES;
    [self initNavigationBar];
    
    _isFirstView=YES;

    appDelegate=(TMAppDelegate*)[[UIApplication sharedApplication]delegate];
//    page=1;
    _marrayAll =[[NSMutableArray alloc]init];

 
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, view_bar.frame.size.height, 320, 40)];
    self.searchBar.placeholder = @"搜索你喜欢的宝贝";
    self.searchBar.delegate = self;
    self.searchBar.barStyle=UIBarStyleDefault;

    self.searchBar.tintColor=[UIColor colorWithRed:1.0 green:.4 blue:.5 alpha:1.0];
    self.searchBar.barTintColor=[UIColor colorWithRed:1.0 green:.4 blue:.5 alpha:1.0];
    [self.searchBar sizeToFit];
    self.searchBar.keyboardType=UIKeyboardTypeDefault;
    

 
    [self.view addSubview:self.searchBar];
    self.strongSearchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    self.searchDisplayController.searchResultsDataSource = self;
    self.searchDisplayController.searchResultsDelegate = self;
    self.searchDisplayController.delegate = self;

    
    [self initToolBar];
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, view_bar.frame.size.height+imageViewToolBar.frame.size.height+self.searchBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-view_bar.frame.size.height-imageViewToolBar.frame.size.height-self.searchBar.frame.size.height)style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorColor=[UIColor clearColor];
    [self.view addSubview:_tableView];
    
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
//    seachBarView.frame=CGRectZero;
    searchBar.showsCancelButton = YES;
    for(id cc in [searchBar subviews])
    {
        if([cc isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)cc;
            [btn setTitle:@"dqe" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor redColor] forState:0];
            
            NSLog(@"%@",btn.layer);
        }
    }

}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{

    return YES;
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{


}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{

    [searchBar resignFirstResponder];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    [self.searchBar resignFirstResponder];
}

#pragma mark tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isFirstView==YES) {
        return 18;
    }else{
        return 7;
    }
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

        // Return the number of sections.
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cate_cell";

    UITableViewCell *cell =nil;

    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType=UITableViewCellAccessoryNone;
        cell.selectedBackgroundView = [[[UIView alloc] initWithFrame:cell.frame] autorelease];
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:0.88 green:0.94 blue:0.99 alpha:1.0];
    }

        if (_isFirstView==YES)
        {
            UIImageView *line=[[UIImageView alloc]initWithFrame:CGRectMake(0, 39, 320, 1)];
            line.image=BundleImage(@"line_01_.png");
            [cell addSubview:line];
            
            UIImageView *imageP=[[UIImageView alloc]initWithFrame:CGRectMake(cell.frame.size.width-44, (40-70)/2, 44, 70)];
            imageP.image=BundleImage(@"bt_04_J.png");
            [cell addSubview:imageP];
            
            CGRect cellFrame = [cell frame];
            cellFrame.origin=CGPointMake(5, 5);
            cellFrame.size.width=320;
            cellFrame.size.height=40;
            [cell setFrame:cellFrame];
       
            return cell;
        }else {
        
            UIImageView *imageP=[[UIImageView alloc]initWithFrame:CGRectMake(cell.frame.size.width-44, (90-70)/2, 44, 70)];
            imageP.image=BundleImage(@"bt_04_J.png");
            [cell addSubview:imageP];
            
            
            UrlImageView *headImg=[[UrlImageView alloc]initWithFrame:CGRectMake(90/2-60/2, 15, 60, 60)];
            headImg.image=BundleImage(@"df_03_.png");
            [cell addSubview:headImg];
            headImg.backgroundColor=[UIColor clearColor];
            
            UrlImageView *headImg1=[[UrlImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
            headImg1.image=BundleImage(@"bg_01_.png");
            [headImg addSubview:headImg1];
            headImg1.backgroundColor=[UIColor clearColor];
            
            UrlImageView*imgView=[[UrlImageView alloc]initWithFrame:CGRectMake(20, 10, 56,56)];
            
            //        if ([[[[_marrayAll objectAtIndex:indexPath.row]productList]objectAtIndex:0] icon]==nil)
            //        {
            
            //        }else
            //        {
            //            [imgView setImageWithURL:[NSURL URLWithString:_url]];
            //
            //        }
            
            //        [cell addSubview:imgView];
            
            //title店铺名
            UILabel*title=[[UILabel alloc]initWithFrame:CGRectMake(imgView.frame.size.width+imgView.frame.origin.y+20, 25, 100, 20)];
            title.backgroundColor=[UIColor clearColor];
            title.textAlignment=0;
            title.text=@"魅典幻镜";
            title.textColor=[UIColor colorWithRed:.2 green:.2 blue:.2 alpha:1.0];
            title.font=[UIFont systemFontOfSize:14];
            [cell addSubview:title];
            
            //店铺介绍
            UILabel*title1=[[UILabel alloc]initWithFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+title.frame.size.height+5, 60, 20)];
            title1.textAlignment=0;
            title1.tag=1000+indexPath.row;
            title1.font=[UIFont systemFontOfSize:12];
            title1.textColor=[UIColor colorWithRed:.2 green:.2 blue:.2 alpha:1.0];
            title1.text=@"店铺介绍：";
            title1.backgroundColor=[UIColor clearColor];
            [cell addSubview:title1];
            
            //店铺介绍详情
            UILabel*title2=[[UILabel alloc]initWithFrame:CGRectMake(title1.frame.origin.x+title1.frame.size.width, title1.frame.origin.y, 140, 20)];
            title2.textAlignment=0;
            title2.tag=1000+indexPath.row;
            title2.font=[UIFont systemFontOfSize:12];
            title2.textColor=[UIColor colorWithRed:.8 green:.8 blue:.8 alpha:1.0];
            title2.text=@"欧美 混搭 居家 传媒 中性 居家 传媒 中性";
            title2.numberOfLines=0;
            title2.backgroundColor=[UIColor clearColor];
            [cell addSubview:title2];
            
            CGRect cellFrame = [cell frame];
            cellFrame.origin=CGPointMake(5, 5);
            cellFrame.size.width=320;
            cellFrame.size.height=90;
            [cell setFrame:cellFrame];
            [imgView release];
            
            //        line@2x
            UIImageView *line=[[UIImageView alloc]initWithFrame:CGRectMake(0, 89, 320, 1)];
            line.image=BundleImage(@"line_01_.png");
            line.backgroundColor=[UIColor colorWithRed:.5 green:.5 blue:.5 alpha:1.0];
            [cell addSubview:line];
            [line release];
        
            //cell高度

            return cell;
        
        
            }
    return 0;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TMAppDelegate *delegate=(TMAppDelegate*)[UIApplication sharedApplication].delegate;
    if (_isFirstView==YES) {
        TMThirdClassViewController *goods=[[TMThirdClassViewController alloc]init];
        
        [delegate.navigationController pushViewController:goods animated:YES];
    }else{
        TMShopStoreDetailScrollController *shopStore=[[TMShopStoreDetailScrollController alloc]init];
       
        [delegate.navigationController pushViewController:shopStore animated:YES];
    
    }
//    LTKDetailCommercialViewController*VC=[[LTKDetailCommercialViewController alloc]initShopInFoID:[[_marrayAll objectAtIndex:indexPath.row]id]addCollectionIsCollection:NO];
//    [self.navigationController pushViewController:VC animated:YES];

}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
