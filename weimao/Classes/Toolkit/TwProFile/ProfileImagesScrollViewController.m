//
//  ProfileImagesScrollViewController.m
//  TwProfile
//
//  Created by Edgar on 5/19/13.
//  Copyright (c) 2013 mx.com.hunk. All rights reserved.
//

#import "ProfileImagesScrollViewController.h"

static CGFloat ImageHeight  = 150.0;
static CGFloat ImageWidth  = 320.0;

@interface ProfileImagesScrollViewController ()

@end

@implementation ProfileImagesScrollViewController

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat yOffset   = self.scrollView.contentOffset.y;
    CGFloat xOffset   = self.wrapperScroll.contentOffset.x;
    
    if (yOffset < 0) {
        
        CGFloat pageWidth = self.wrapperScroll.frame.size.width;
		int page = floor((self.wrapperScroll.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        
        UIImageView *imgTmp;
		for (UIView *view in self.imgContainer.subviews) {
			if ([view isKindOfClass:[UIImageView class]]) {
				if (view.tag == 10+ page) {
					imgTmp = (UIImageView*)view;
				}
			}
		}
        
        CGFloat factor = ((ABS(yOffset)+ ImageHeight )*ImageWidth)/ ImageHeight;
        
        CGRect f = CGRectMake((-(factor-ImageWidth)/2) + 320 *page, 0, ImageWidth, ImageHeight);
        f.size.height = ImageHeight+ABS(yOffset);
        f.size.width = factor;
		imgTmp.frame = f;
        
        CGRect frame = self.imgContainer.frame;
        frame.origin.y = 0;
		self.imgContainer.frame = frame;
    } else {
        self.imgContainer.contentOffset = CGPointMake(xOffset, yOffset);
    }
}

#pragma mark - View lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BgPatron"]];
        // Custom initialization
        self.imgContainer  = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ImageWidth, self.view.bounds.size.height)];
        self.imgContainer.backgroundColor = [UIColor clearColor];
        self.imgContainer.showsHorizontalScrollIndicator = NO;
        self.imgContainer.showsVerticalScrollIndicator = NO;
        
        NSArray *images = [NSArray arrayWithObjects:[UIImage imageNamed:@"ballpark1.png"],
                           [UIImage imageNamed:@"ballpark2.png"],
                           [UIImage imageNamed:@"ballpark3.png"],
                           [UIImage imageNamed:@"ballpark4.png"],
                           nil];
        
		int  tag = 0;
        for (UIImage *image in images) {
            UIImageView *imageView  = [[UIImageView alloc] initWithImage:image];
            imageView.frame = CGRectMake(ImageWidth*tag, 0, ImageWidth, ImageHeight);
            imageView.tag = tag + 10;
			tag++;
            [self.imgContainer addSubview:imageView];
        }
        self.imgContainer.contentSize = CGSizeMake([images count]*ImageWidth, self.view.bounds.size.height);
        [self.view addSubview:self.imgContainer];

        //wrapper scroll
        self.wrapperScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ImageWidth, ImageHeight)];
        self.wrapperScroll.backgroundColor = [UIColor clearColor];
        self.wrapperScroll.delegate = self;
        self.wrapperScroll.pagingEnabled = YES;
        self.wrapperScroll.showsVerticalScrollIndicator = NO;
        self.wrapperScroll.showsHorizontalScrollIndicator = NO;
        
        self.wrapperScroll.contentSize = CGSizeMake([images count]*ImageWidth, ImageHeight);
        
        UIImageView *fakeView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dummyProfile"]];
        CGRect frame = fakeView.frame;
        frame.origin.y = ImageHeight;
        fakeView.frame = frame;
        
        self.scrollView = [[UIScrollView alloc] init];
		self.scrollView.delegate = self;
        self.scrollView.backgroundColor = [UIColor clearColor];
        self.scrollView.contentSize = CGSizeMake(320, frame.size.height+ImageHeight);
        
        [self.scrollView addSubview:self.wrapperScroll];
        [self.scrollView addSubview:fakeView];
        
        [self.view addSubview:self.scrollView];
        
        self.title = @"img+ with UIScrollView";
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    CGRect bounds = self.view.bounds;
    self.scrollView.frame = bounds;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
