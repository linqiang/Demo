//
//  TMClassicViewController.m
//  TaoMao
//
//  Created by mac on 14-4-16.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "TMClassicViewController.h"
#import "TMSecondClassViewController.h"
@interface TMClassicViewController ()

@end

@implementation TMClassicViewController

-(void)dealloc
{
    
    [self.marrayAll release];
    [super dealloc];
}
-(id)initWithWhere:(NSString*)isFirstClass
{
    self=[super init];
    if (self) {
        _isFirst=[[NSString alloc]initWithString:isFirstClass];
      
    }
    return self;
}
-(UIView*)initNavigationBar
{
    self.navigationController.navigationBarHidden = YES;
    UIView *view_bar =[[UIView alloc]init];
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
    title_label.text=@"商品分类";
    title_label.font=[UIFont boldSystemFontOfSize:20];
    title_label.backgroundColor=[UIColor clearColor];
    title_label.textColor =[UIColor whiteColor];
    title_label.textAlignment=1;
    [view_bar addSubview:title_label];
    
    if ([_isFirst isEqualToString:@"first"])
    {
        UIButton*btnBack=[UIButton buttonWithType:0];
        btnBack.frame=CGRectMake(0, view_bar.frame.size.height-34, 47, 34);
        [btnBack setImage:BundleImage(@"ret_01.png") forState:0];
        [btnBack addTarget:self action:@selector(btnBack:) forControlEvents:UIControlEventTouchUpInside];
        [view_bar addSubview:btnBack];
   
        
    }else{
    
    
    
    }
    
    
    [title_label release];
    
    return view_bar;
}
-(void)btnBack:(id)sender
{
    TMAppDelegate *app=(TMAppDelegate*)[UIApplication sharedApplication].delegate;
    [app.navigationController popViewControllerAnimated:YES];
}
-(void)viewDidLoad
{
    self.marrayAll=[[NSArray alloc]init];
  
//    http://192.168.1.119:8080/weimao/mobile/commodity_category/category
    //    NSString *parmeters1=[NSString stringWithFormat:@"%@&%@&%@",@"page=1",@"pageSize=5",[NSString stringWithFormat:@"menuId=%d",_typeId]];
//    [[RequestServer instance] doActionAsync:0 withAction:@"/mobile/commodity_category/category" withParameters:nil withDelegate:self];
//    TMAppDelegate *delegate=(TMAppDelegate*)[UIApplication sharedApplication].delegate;
//    [delegate startLoading];
    
    UIView*naviView=(UIView*) [self initNavigationBar];
    if ([_isFirst isEqualToString:@"first"])
    {
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, naviView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-naviView.frame.size.height)];
        [_scrollView setContentSize:CGSizeMake(320, self.view.frame.size.height+naviView.frame.size.height+49+27)];
    }else{
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, naviView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-naviView.frame.size.height-49)];
          [_scrollView setContentSize:CGSizeMake(320, self.view.frame.size.height+naviView.frame.size.height+49+27)];
    }
    if (IS_IPHONE_5) {
        
        [_scrollView setContentSize:CGSizeMake(320, self.marrayAll.count/2*71+naviView.frame.size.height+49+27)];
    }else{
        [_scrollView setContentSize:CGSizeMake(320, self.marrayAll.count/2*71+naviView.frame.size.height+49+155)];
    }

    _scrollView.showsVerticalScrollIndicator=NO;
    _scrollView.backgroundColor=[UIColor colorWithRed:.98 green:.98 blue:.98 alpha:1.0];

    [self.view addSubview:_scrollView];
    [self addsubView];
  


}
-(void)addsubView
{

    for (int i =0; i<self.marrayAll.count; i++){
        
        
        UrlImageButton *btnNine=[[UrlImageButton alloc]initWithFrame:CGRectMake((i%2)*(self.view.frame.size.width/2-2)+3, floor(i/2)*73+3, (self.view.frame.size.width/2-5), 70)];
        btnNine.backgroundColor=[UIColor whiteColor];
        btnNine.layer.borderColor=[UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1.0].CGColor;
        btnNine.layer.borderWidth=1;
        btnNine.layer.cornerRadius = 4;
        btnNine.tag=i+1000;
        [btnNine addTarget:self action:@selector(btnNine:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:btnNine];
        
        UrlImageView * image = [[UrlImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width/2)-60 ,5, 50, 60)];
        NSString *imagePath = [[self.marrayAll objectAtIndex:i] objectForKey:@"icon"];
        NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@/mobile/image/download/%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"current_imgUrl"],imagePath]];
        if (imagePath == nil)
        {
            [image setImage:[UIImage imageNamed:@"temp_Icon.png"]];
        }else{
            [image setImageWithURL:url];
            
        }
        [btnNine addSubview:image];
        
        
        UILabel *title_label=[[UILabel alloc]initWithFrame:CGRectMake(8, 8,160-70, 20)];
        title_label.font=[UIFont systemFontOfSize:16];
        title_label.backgroundColor=[UIColor clearColor];
        title_label.textColor =hui2;
        title_label.textAlignment=0;
        title_label.text=[[self.marrayAll objectAtIndex:i]objectForKey:@"name"];
        [btnNine addSubview:title_label];
        
        UILabel *titleDetail=[[UILabel alloc]initWithFrame:CGRectMake(8, title_label.frame.size.height+title_label.frame.origin.y,160-70, 40)];
        titleDetail.font=[UIFont systemFontOfSize:12];
        titleDetail.backgroundColor=[UIColor clearColor];
        titleDetail.textColor =hui5;
        titleDetail.textAlignment=0;
        titleDetail.numberOfLines=2;
        titleDetail.text=[[self.marrayAll objectAtIndex:i]objectForKey:@"description"];
        [btnNine addSubview:titleDetail];
        
    }
    TMAppDelegate *delegate=(TMAppDelegate*)[UIApplication sharedApplication].delegate;
    [delegate stopLoading];
}
-(void)btnNine:(id)sender
{
    
    UIButton *btn=(UIButton*)sender;
    NSLog(@"%d",btn.tag);
    
//    TMSecondClassViewController *secondV=[[TMSecondClassViewController alloc]initWithTitle:[[self.marrayAll objectAtIndex:btn.tag-1000]objectForKey:@"name"]
//            addWithID:[NSString stringWithFormat:@"%@",[[self.marrayAll objectAtIndex:btn.tag-1000]objectForKey:@"id"]]];
    TMSecondClassViewController *secondV = [[TMSecondClassViewController alloc]initWithTitle:@"asdfasf" addWithID:@"asdf"];
    
    
    TMAppDelegate *delegate=(TMAppDelegate*)[UIApplication sharedApplication].delegate;
    [delegate.navigationController pushViewController:secondV animated:YES];
}

-(void)requestFinished:(NSNumber *)code withMessage:(NSString *)message withData:(id)data
{
//    NSLog(@"%@meth%@",data,message);
    if(data==nil)
        ShowMessage(@"当前没有数据！");
    self.marrayAll=data;
    [self addsubView];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
