//
//  LTKSeachViewController.m
//  LvTongKa
//
//  Created by 123 on 13-8-27.

//

#import "LTKSeachViewController.h"
#import "LTKSeachResultViewController.h"
#import "TMShopStoreDetailScrollController.h"
#import "TMBabyListView.h"
#import "TMStoreListView.h"
#import "LTKSeachResultViewController.h"

@interface LTKSeachViewController ()
{
    UIButton*seachBtn;
    TMBabyListView *list;
    TMStoreListView *storeList;
    UIImageView*seachImageView;

}
@end

@implementation LTKSeachViewController


-(id)initSeachKeyWord:(NSString*)keyWord
{
    self =[super init];
    if (self) {
  
        [self initNavigationBar];
  
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, view_bar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-view_bar.frame.size.height-49)];
        _scrollView.delegate=self;
        _scrollView.showsVerticalScrollIndicator=NO;
        _scrollView.backgroundColor=[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        [self.view addSubview:_scrollView];

        
        
        EScrollerView *scroller=[[EScrollerView alloc] initWithFrameRect:CGRectMake(0,0, 320, 180)
                                                              scrolArray:[NSArray arrayWithArray:self._scrol_marray] needTitile:YES];
        
        scroller.delegate=self;
        scroller.backgroundColor=[UIColor clearColor];
        [_scrollView addSubview:scroller];
        [scroller release];
        
        
        for (int i =0; i<8; i++)
        {
            
            
            fourBtn=[[UrlImageButton alloc]initWithFrame:CGRectMake(12+(i%4)*75,  floor(i/4)*110+scroller.frame.size.height+scroller.frame.origin.y+30, 70, 70)];
            [fourBtn addTarget:self action:@selector(btnShopStore:) forControlEvents:UIControlEventTouchUpInside];
            [_scrollView addSubview:fourBtn];
            fourBtn.backgroundColor=[UIColor clearColor];
            [fourBtn setBackgroundImage: [UIImage imageNamed:@"default_02.png"] forState:0];
            [fourBtn setImage: [UIImage imageNamed:@"spic_01.png"] forState:0];
            fourLab=[[UILabel alloc]initWithFrame:CGRectMake(12+(i%4)*75, floor(i/4)*110+scroller.frame.size.height+scroller.frame.origin.y+110, 70, 20)];
            fourLab.text=@"都市韩风";
            fourLab.textColor=[UIColor grayColor];
            fourLab.font=[UIFont boldSystemFontOfSize:10];
            fourLab.textAlignment=1;
            fourLab.backgroundColor=[UIColor clearColor];
            [_scrollView addSubview:fourLab];
            
            
        }
          [_scrollView setContentSize:CGSizeMake(320, fourLab.frame.size.height+fourLab.frame.origin.y+10)];
    }
  
    
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
  
    self.view.backgroundColor=[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
}
-(void)btnShopStore:(id)sender
{
    TMShopStoreDetailScrollController *shopStore=[[TMShopStoreDetailScrollController alloc]init];
    TMAppDelegate *appDelegate = (TMAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController pushViewController:shopStore animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.backgroundColor=[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
}

-(BOOL)showLoading{
    return YES;
}

-(BOOL)closeLoading{
    return YES;
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
    title_label.text=@"商品快寻";
    title_label.font=[UIFont boldSystemFontOfSize:20];
    title_label.backgroundColor=[UIColor clearColor];
    title_label.textColor =[UIColor whiteColor];
    title_label.textAlignment=1;
    [view_bar addSubview:title_label];
    
    UIButton*btnSeach=[UIButton buttonWithType:0];
    btnSeach.frame=CGRectMake(view_bar.frame.size.width-55, view_bar.frame.size.height-45, 49, 45);
    
    [btnSeach setTitle:@"订单" forState:0];
    [btnSeach setImage:BundleImage(@"sskx_search.png") forState:0];
    [btnSeach addTarget:self action:@selector(btnSeach:) forControlEvents:UIControlEventTouchUpInside];
    [view_bar addSubview:btnSeach];
    
    return view_bar;
}
-(void)btnSeach:(id)sender
{
    LTKSeachResultViewController *seachR=[[LTKSeachResultViewController alloc]init];
    TMAppDelegate *delegate=(TMAppDelegate*)[UIApplication sharedApplication].delegate;
    [delegate.navigationController pushViewController:seachR animated:YES];

}


    //热门搜索
-(void)btnHotSeach:(id)sender
{
    UIButton *btn1=(UIButton*)sender;
    UIButton *btn;
    for (int i =0; i<[_marrayHotKeyWords count]; i++)
    {
        btn=(UIButton*)[self.view viewWithTag:i+1000];
        if (btn.tag==btn1.tag)
        {
            
        }

    }
 
    if  (IS_IPHONE||IS_IPOD||IS_IPad)
    {
        if ([[NSUserDefaults standardUserDefaults]objectForKey:@"lng"]==nil||
            [[NSUserDefaults standardUserDefaults]objectForKey:@"lat"]==nil)
        {
            ShowMessage(@"请打开定位！或点击导航定位按钮！");
        }else{

            LTKSeachResultViewController *VC=[[LTKSeachResultViewController alloc]initSeachKeyWords:[[_marrayHotKeyWords objectAtIndex:btn1.tag-1000] name]addSeachString:@""];
            [self.navigationController pushViewController:VC animated:YES];
        }

    }else{

        ShowMessage(@"此设备没有定位功能!");
        
    }

}


#pragma mark - Initializer


-(void)labelFrameWithFont:(UILabel*)label withOriginX:(double)originX withOrignY:(double)originY{
        //列宽
    CGFloat contentWith1=self.view.frame.size.width;
        //显示字体
    UIFont *font1=[UIFont systemFontOfSize:14];
    label.font=font1;
        //        NSString *name=@"12345";
    CGSize size1=[label.text sizeWithFont:font1 constrainedToSize:CGSizeMake(contentWith1, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
    CGRect rect=[label textRectForBounds:label.frame limitedToNumberOfLines:0];
    rect.size = size1;
    label.frame=rect;
    [label setFrame:CGRectMake(originX,originY, rect.size.width, rect.size.height)];
    label.backgroundColor=[UIColor clearColor];
    label.textColor=[[UIColor alloc]initWithRed:0.235 green:0.235 blue:0.235 alpha:1.0];

}
-(void)dealloc
{

    [tabBarArrow release];
    [list release];
    [storeList release];
    [hotLabel release];
    [_keyWord release];
    [_array release];
    [_marrayHotKeyWords release];
//    [scrollView release];
    [_array release];
    [seachField release];
    [super dealloc];
}
@end
