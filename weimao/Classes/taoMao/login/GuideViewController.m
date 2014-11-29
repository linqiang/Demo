//
//  ViewController.m
//  GuideViewController
//
//  Created by 发兵 杨 on 12-9-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GuideViewController.h"
#import "TMAppDelegate.h"
#import "FCLoginViewController.h"
@implementation GuideViewController
@synthesize gotoMainViewBtn = _gotoMainViewBtn;

@synthesize imageView;
@synthesize left = _left;
@synthesize right = _right;
@synthesize pageScroll;
@synthesize pageControl;



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    pageScroll =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    pageControl =[[UIPageControl alloc]initWithFrame:CGRectMake(142,320, 38, 36)];

    pageScroll.showsHorizontalScrollIndicator=NO;
    pageScroll.showsVerticalScrollIndicator=NO;
    pageControl.numberOfPages = 4;
    pageControl.currentPage = 0;
    pageScroll.delegate = self;
    pageScroll.contentSize = CGSizeMake(self.view.frame.size.width * 4, self.view.frame.size.height);
    pageScroll.scrollsToTop = YES;
    pageScroll.bouncesZoom = YES;
    pageScroll.pagingEnabled = YES;
    pageScroll.scrollEnabled = YES;
    pageScroll.bouncesZoom = YES;
    pageScroll.canCancelContentTouches = YES;
    pageScroll.opaque = YES;
    self.navigationController.navigationBar.hidden = YES;
    UIImageView *image_view1 =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"欢1.png"]];
    [image_view1 setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [pageScroll addSubview:image_view1];
    UIImageView *image_view2 =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"欢2.png"]];
    [image_view2 setFrame:CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    [pageScroll addSubview:image_view2];
    UIImageView *image_view3 =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"欢3.png"]];
    [image_view3 setFrame:CGRectMake(self.view.frame.size.width*2, 0, self.view.frame.size.width, self.view.frame.size.height)];
     [pageScroll addSubview:image_view3];
    
    UIImageView *image_view4 =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"欢4新.png"]];
    
    [image_view4 setFrame:CGRectMake(self.view.frame.size.width*3, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [pageScroll addSubview:image_view4];
    
    _gotoMainViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_gotoMainViewBtn setFrame:CGRectMake((320-90)/2+320*3, 440, 90, 90)];
    _gotoMainViewBtn.backgroundColor=[UIColor clearColor];
    [self.view bringSubviewToFront:_gotoMainViewBtn];
//    [_gotoMainViewBtn setBackgroundImage:[UIImage imageNamed:@"开始体验@2x.png"] forState:UIControlStateNormal];
    [_gotoMainViewBtn addTarget:self action:@selector(gotoMainView:) forControlEvents:UIControlEventTouchUpInside];
    [pageScroll addSubview:_gotoMainViewBtn];

    [self.view addSubview:pageScroll];
//    [self.view addSubview:pageControl];
}

- (void)viewDidUnload
{
    [self setGotoMainViewBtn:nil];
    [super viewDidUnload];
}

-(void)dealloc
{   
    [_gotoMainViewBtn release];
    [self.imageView release];
    [super dealloc];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (void)gotoMainView:(id) sender{
   
    [self dismissViewControllerAnimated:NO completion:nil];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{	
    CGFloat pageWidth = self.view.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
}

@end
