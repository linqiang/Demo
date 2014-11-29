//
//  TMCommentListViewController.m
//  TaoMao
//
//  Created by mac on 14-4-21.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "TMCommentListViewController.h"
#import "AMRatingControl.h"
@interface TMCommentListViewController ()
{

    UIView *view_bar;
}
@end

@implementation TMCommentListViewController

- (void)dealloc
{
    [_tableView release];
    [super dealloc];
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
    
    [self.view addSubview:view_bar];
    UILabel *title_label=[[UILabel alloc]initWithFrame:CGRectMake(65, view_bar.frame.size.height-44, self.view.frame.size.width-130, 44)];
    title_label.text=@"评论列表";
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
-(void)btnBack:(id)sender
{
    TMAppDelegate *app=(TMAppDelegate*)[UIApplication sharedApplication].delegate;
    [app.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    
    
    self.navigationController.navigationBarHidden=YES;
    self.newsArray = [[NSMutableArray alloc] init];
    naviBar=(UIView*) [self initNavigationBar];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, naviBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-naviBar.frame.size.height)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.backgroundView=nil;
    _tableView.backgroundColor=[UIColor whiteColor];
    _tableView.separatorColor=[UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_tableView];
    [self initHeadView];
    
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
   
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
}
-(void)initHeadView{
    _tableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    [_tableView addSubview:_tableView.tableHeaderView];
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    //    view.layer.borderColor=[UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1.0].CGColor;
    //    view.layer.borderWidth=1;
    UILabel *title_label=[[UILabel alloc]initWithFrame:CGRectMake(10, 50/2-10, 68, 20)];
    title_label.text=@"70.00%";
    title_label.font=[UIFont systemFontOfSize:18];
    title_label.backgroundColor=[UIColor clearColor];
    title_label.textColor =hongShe;
    title_label.textAlignment=0;

    [view addSubview:title_label];

    UILabel *title_label1=[[UILabel alloc]initWithFrame:CGRectMake(title_label.frame.size.width+title_label.frame.origin.x, 50/2-10, 70, 20)];
    title_label1.text=@"满意度";
    title_label1.font=[UIFont systemFontOfSize:10];
    title_label1.backgroundColor=[UIColor clearColor];
    title_label1.textColor =hongShe;
    title_label1.textAlignment=0;

    [view addSubview:title_label1];

    AMRatingControl* imagesRatingControl1 = [[AMRatingControl alloc ]initWithLocation:CGPointMake(230, 50/2-20/2) emptyColor:BundleCGColor(0.4, 0.4, 0.47, 1.0) solidColor:BundleCGColor(1.0, 0.8, 0.0, 1.0) andMaxRating:5 andFontSize:16 andStartWidth:16 isTouch:NO];

    //    if ([_grade length]>0)
    //    {
    [imagesRatingControl1 setRating:4];
    //    }
    [view addSubview:imagesRatingControl1];


    [_tableView.tableHeaderView addSubview:view];
    _tableView.tableHeaderView.backgroundColor = [UIColor clearColor];
    UIImageView*line=[[UIImageView alloc]initWithFrame:CGRectMake(0, 50-1, 320, 1)];
    line.backgroundColor=[UIColor clearColor];
    line.image=BundleImage(@"line_01_.png");
    [view addSubview:line];

}

#pragma mark - 刷新的代理方法---进入下拉刷新\上拉加载更多都有可能调用这个方法
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (refreshView == _header)
    { // 下拉刷新
        // 增加9个假数据
    }
    else if(refreshView == _footer)
    {
        _page++;

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
        [self initHeadView];
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    
    UITableViewCell *cell = nil;
    
    
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier: SimpleTableIdentifier] autorelease];
    }
    
    cell.textLabel.font = [UIFont fontWithName:@"楷体" size:6];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType=UITableViewCellAccessoryNone;
    
    int row = indexPath.row;
    
    
    [cell setBackgroundColor:[UIColor whiteColor]];
    
    
    
    UIImageView * imgvw = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 23, 23)];
    [imgvw setImage:[UIImage imageNamed:@"shop_tx_"]];
    [cell addSubview:imgvw];
    
    UILabel * lb_title = [[UILabel alloc]initWithFrame:CGRectMake(imgvw.frame.size.width+imgvw.frame.origin.x+5, 10, 180, 10)];
    //    [lb_title setText:[arr_Title objectAtIndex:(indexPath.row < arr_Title.count ? indexPath.row:0)]];
    [lb_title setBackgroundColor:[UIColor clearColor]];
    [lb_title setFont:[UIFont systemFontOfSize:12]];
    lb_title.textColor=hongShe;
    lb_title.text=@"S";
    
    [cell addSubview:lb_title];
    
    UILabel * lb_detailTitle = [[UILabel alloc]initWithFrame:CGRectMake(lb_title.frame.origin.x, lb_title.frame.size.height+lb_title.frame.origin.y, 280, 45)];
    //    [lb_detailTitle setText:[arr_detailTitle objectAtIndex:(indexPath.row < arr_detailTitle.count ? indexPath.row:0)]];
    lb_detailTitle.text=@"胸围：胸围：80 肩宽：43 臀围：80 腰围：80胸围：胸围：胸围：80 肩宽：43 臀围：80 腰围：80胸围：80 肩宽：43 臀围：80 腰围80 肩宽：43 臀围：80 腰围：8080 肩宽：43 臀围：80 腰围：80";
    [lb_detailTitle setTextColor:[UIColor colorWithRed:.5 green:.5 blue:.5 alpha:1.0]];
    [lb_detailTitle setBackgroundColor:[UIColor clearColor]];
    [lb_detailTitle setFont:[UIFont systemFontOfSize:10]];
    lb_detailTitle.numberOfLines=0;
    [cell addSubview:lb_detailTitle];
    
    UILabel * lb_timeTitle = [[UILabel alloc]initWithFrame:CGRectMake(cell.frame.size.width-80,80-18, 80, 15)];
    //    [lb_detailTitle setText:[arr_detailTitle objectAtIndex:(indexPath.row < arr_detailTitle.count ? indexPath.row:0)]];
    lb_timeTitle.text=@"2014年04月20日";
    [lb_timeTitle setTextColor:[UIColor colorWithRed:.8 green:.8 blue:.8 alpha:1.0]];
    [lb_timeTitle setBackgroundColor:[UIColor clearColor]];
    [lb_timeTitle setFont:[UIFont systemFontOfSize:10]];
    lb_timeTitle.numberOfLines=3;
    [cell addSubview:lb_timeTitle];
    
    //    NSString *_grade;
    AMRatingControl* imagesRatingControl1 = [[AMRatingControl alloc ]initWithLocation:CGPointMake(230, 5)
                                                                           emptyColor:BundleCGColor(0.4, 0.4, 0.47, 1.0)
                                                                           solidColor:BundleCGColor(1.0, 0.8, 0.0, 1.0) andMaxRating:5
                                                                          andFontSize:16
                                                                        andStartWidth:16
                                                                              isTouch:NO];
    
    //    if ([_grade length]>0)
    //    {
    [imagesRatingControl1 setRating:4];
    //    }
    [cell addSubview:imagesRatingControl1];
    
    CGRect cellFrame = [cell frame];
    cellFrame.origin=CGPointMake(5, 5);
    cellFrame.size.width=310;
    cellFrame.size.height=lb_title.frame.size.height+20;
    [cell setFrame:cellFrame];
    
    UIImageView*line=[[UIImageView alloc]initWithFrame:CGRectMake(0, 80-1, 320, 1)];
    line.backgroundColor=[UIColor clearColor];
    line.image=BundleImage(@"line_01_.png");
    [cell addSubview:line];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else{
        
        return YES;
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger count = indexPath.row;
    //    [self.LtTtbSDelegate ListTitleTbSelectSpecificRow:count];
}





- (void)didReceiveMemoryWarning

{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}@end
