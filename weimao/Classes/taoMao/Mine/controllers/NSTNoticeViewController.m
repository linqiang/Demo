//
//  NSTNoticeViewController.m
//  NewsTextModel
//
//  Created by mac on 14-3-21.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "NSTNoticeViewController.h"


@interface NSTNoticeViewController ()

@end

@implementation NSTNoticeViewController

- (void)dealloc
{
    [_tableView release];
    [super dealloc];
}
-(UIView*)initNavigationBar
{
    UIView *view_bar =[[UIView alloc]init];
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>6.1)
    {
        view_bar .frame=CGRectMake(0, 0, self.view.frame.size.width, 44+20);
        UIImageView *imageV = [[UIImageView alloc]initWithImage:BundleImage(@"导航红色128.png")];
        [view_bar addSubview:imageV];
        [imageV release];
        
    }else{
        view_bar .frame=CGRectMake(0, 0, self.view.frame.size.width, 44);
        UIImageView *imageV = [[UIImageView alloc]initWithImage:BundleImage(@"导航红色88.png")];
        [view_bar addSubview:imageV];
        [imageV release];
    }
    view_bar.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview: view_bar];
    UILabel *title_label=[[UILabel alloc]initWithFrame:CGRectMake(65, view_bar.frame.size.height-44, self.view.frame.size.width-130, 44)];
    title_label.text=@"行业资讯";
    title_label.font=[UIFont boldSystemFontOfSize:20];
    title_label.backgroundColor=[UIColor clearColor];
    title_label.textColor =[UIColor whiteColor];
    title_label.textAlignment=1;
    //    title_label.shadowColor = [UIColor darkGrayColor];
    //    title_label.shadowOffset = CGSizeMake(1, 1);
    [view_bar addSubview:title_label];
    [title_label release];
    
    return view_bar;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
      self.navigationController.navigationBarHidden=YES;
    self.newsArray = [[NSMutableArray alloc] init];
    naviBar=(UIView*) [self initNavigationBar];

    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, naviBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-naviBar.frame.size.height-49)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.backgroundView=nil;
    _tableView.backgroundColor=[UIColor whiteColor];
    _tableView.separatorColor=[UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_tableView];
    _page = 0;
    // 3.3行集成下拉刷新控件
    _header = [MJRefreshHeaderView header];
    _header.scrollView = _tableView;
    _header.delegate = self;
    
    // 4.3行集成上拉加载更多控件
    _footer = [MJRefreshFooterView footer];
    _footer.scrollView = _tableView;
    _footer.delegate = self;
    TMAppDelegate *app = (TMAppDelegate*)[[UIApplication sharedApplication] delegate];
    [app startLoading];
    NSString *parmeters1=[NSString stringWithFormat:@"%@&%@&%@",@"page=1",@"pageSize=5",[NSString stringWithFormat:@"menuId=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"hangyezixun"]]];
    
//    [[RequestServer instance] doActionAsync:0 withAction:@"/mobile/second?" withParameters:parmeters1 withDelegate:self];
}
-(void)viewWillAppear:(BOOL)animated
{
    
}
-(void)initTableHeadView
{
    _tableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, naviBar.frame.size.height, 320, 144)];
    [_tableView addSubview:_tableView.tableHeaderView];
    EScrollerView *scroller=[[EScrollerView alloc] initWithFrameRect:CGRectMake(0, 0, 320, 144)
                                                          scrolArray:[NSArray arrayWithArray:self._scrol_marray] needTitile:YES];
    scroller.delegate=self;
    [_tableView.tableHeaderView addSubview:scroller];
    _tableView.tableHeaderView.backgroundColor = [UIColor clearColor];
    
    
    [scroller release];
    
}

#pragma mark - 刷新的代理方法---进入下拉刷新\上拉加载更多都有可能调用这个方法
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (refreshView == _header)
    { // 下拉刷新
        // 增加9个假数据
        
        // 2秒后刷新表格
//        NSString *parmeters1=[NSString stringWithFormat:@"%@&%@&%@",@"page=1",@"pageSize=5",[NSString stringWithFormat:@"menuId=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"hangyezixun"]]];
        
//        [[RequestServer instance] doActionAsync:0 withAction:@"/mobile/second?" withParameters:parmeters1 withDelegate:self];
        [self.newsArray removeAllObjects];
        _page = 1;
    }
    else if(refreshView == _footer)
    {
        _page++;
//        NSString *parmeters1=[NSString stringWithFormat:@"page=%d&pageSize=5&menuId=%@",_page,[[NSUserDefaults standardUserDefaults] objectForKey:@"hangyezixun"]];
//        [[RequestServer instance] doActionAsync:0 withAction:@"/mobReachabilityile/second?" withParameters:parmeters1 withDelegate:self];
    }
}

#pragma mark 刷新团购
- (void)reloadDeals
{
    // 结束刷新状态
    [_tableView reloadData];
    [_header endRefreshing];
    [_footer endRefreshing];
}

-(void)requestFinished:(NSNumber *)code withMessage:(NSString *)message withData:(id)data
{
    NSLog(@"%@",data);
    TMAppDelegate *app = (TMAppDelegate*)[[UIApplication sharedApplication] delegate];
    [app stopLoading];
    for (int i=0; i<[[[data objectForKey:@"news"]objectForKey:@"content"] count]; i++)
    {
        NSDictionary *dic = [[[data objectForKey:@"news"]objectForKey:@"content"] objectAtIndex:i];
        [self.newsArray addObject:dic];
    }
    
    
    self._scrol_marray = [NSMutableArray arrayWithArray:[data objectForKey:@"focus"]];
    
    if(self._scrol_marray.count != 0)
    {
        [self initTableHeadView];
    }
    if(_page == 0)
    {
        [_tableView reloadData];
        _page = 1;
    }
    else
    {
        [self performSelector:@selector(reloadDeals) withObject:nil afterDelay:1];
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
        cell.backgroundColor=[UIColor colorWithRed:.97 green:.97 blue:.97 alpha:1.0];
    }
    if(self.newsArray.count == 0 || indexPath.row>self.newsArray.count)
        return cell;
    UrlImageView * imgvw = [[UrlImageView alloc]initWithFrame:CGRectMake(5, 8, 80, 56)];
    NSString *imagePath = [[self.newsArray objectAtIndex:indexPath.row] objectForKey:@"ititle"];
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@/mobile/attachment/download/%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"current_imgUrl"],imagePath]];
    if (imagePath == nil)
    {
        [imgvw setImage:[UIImage imageNamed:@"temp_Icon.png"]];
    }else{
        [imgvw setImageWithURL:url];
        
    }
    [cell addSubview:imgvw];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(imgvw.frame.size.width+imgvw.frame.origin.x+8, imgvw.frame.origin.y, cell.frame.size.width-imgvw.frame.size.width-imgvw.frame.origin.x, 20)];
    NSString *headStr = [[self.newsArray objectAtIndex:indexPath.row] objectForKey:@"mainHeading"];
    label.text=headStr;
    label.backgroundColor=[UIColor clearColor];
    [cell addSubview:label];
    
    UILabel *labelDetail=[[UILabel alloc]initWithFrame:CGRectMake(imgvw.frame.size.width+imgvw.frame.origin.x+8, label.frame.origin.y+label.frame.size.height, cell.frame.size.width-imgvw.frame.size.width-imgvw.frame.origin.x, 15)];
    labelDetail.text=[[self.newsArray objectAtIndex:indexPath.row] objectForKey:@"subHeading"];
    labelDetail.backgroundColor=[UIColor clearColor];
    labelDetail.font=[UIFont systemFontOfSize:12];
    labelDetail.numberOfLines=2;
    labelDetail.textColor=[UIColor grayColor];
    [cell addSubview:labelDetail];
    
    UILabel *labelTime=[[UILabel alloc]initWithFrame:CGRectMake(cell.frame.size.width-85, labelDetail.frame.size.height+labelDetail.frame.origin.y, 80, 20)];
    NSString *timeStr = [[self.newsArray objectAtIndex:indexPath.row] objectForKey:@"updateDate"];
    labelTime.text= [timeStr substringWithRange:NSMakeRange(0, 10)];
    
    labelTime.backgroundColor=[UIColor clearColor];
    labelTime.font=[UIFont systemFontOfSize:12];
    
    labelTime.textColor=[UIColor grayColor];
    [cell addSubview:labelTime];
    
    
    
    CGRect cellFrame = [cell frame];
    cellFrame.origin=CGPointMake(5, 5);
    cellFrame.size.width=320;
    cellFrame.size.height=imgvw.frame.size.height+15;
    [cell setFrame:cellFrame];
    
    UIImageView *_line=[[UIImageView alloc]initWithFrame:CGRectMake(0, cellFrame.size.height-1, 320, 1)];
    _line.image=[UIImage imageNamed:@"xianxain.png"];
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
    return cell.frame.size.height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return self._marray_updateDate.count;
    return self.newsArray.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSTDetailHomeViewController *VC =[[NSTDetailHomeViewController alloc]initWithNews:[self.newsArray objectAtIndex:indexPath.row]];
//    TMAppDelegate *appDelegate=(TMAppDelegate*)[[UIApplication sharedApplication]delegate];
//    [appDelegate.navigationController pushViewController:VC animated:YES];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
