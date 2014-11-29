//
//  ProfileScrollViewController.m
//  TwProfile
//
//  Created by Edgar on 5/1/13.
//  Copyright (c) 2013 mx.com.hunk. All rights reserved.
//

#import "ProfileScrollViewController.h"

static CGFloat ImageHeight  = 150.0;
static CGFloat ImageWidth  = 320.0;

@interface ProfileScrollViewController ()

@end

@implementation ProfileScrollViewController

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat yOffset   = self.scrollView.contentOffset.y;
    
    if (yOffset < 0) {
        
        CGFloat factor = ((ABS(yOffset)+ImageHeight)*ImageWidth)/ImageHeight;
        CGRect f = CGRectMake(-(factor-ImageWidth)/2, 0, factor, ImageHeight+ABS(yOffset));
        self.imgProfile.frame = f;
    } else {
        CGRect f = self.imgProfile.frame;
        f.origin.y = -yOffset;
        self.imgProfile.frame = f;
    }
}

#pragma mark - View lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BgPatron"]];
        // Custom initialization
        UIImage *image = [UIImage imageNamed:@"bg.png"];
        self.imgProfile = [[UIImageView alloc] initWithImage:image];
		self.imgProfile.frame             = CGRectMake(0, 0, ImageWidth, ImageHeight);
        
        UIImageView *fakeView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dummyProfile"]];
        
        CGRect frame = fakeView.frame;
        frame.origin.y = ImageHeight;
        fakeView.frame = frame;
        
        self.scrollView = [[UIScrollView alloc] init];
		self.scrollView.delegate = self;
        self.scrollView.backgroundColor = [UIColor clearColor];
        self.scrollView.contentSize = CGSizeMake(320, frame.size.height+ImageHeight);
        
        [self.scrollView addSubview:fakeView];
        
        [self.view addSubview:self.imgProfile];
        [self.view addSubview:self.scrollView];
        
        self.title = @"with UIScrollView";

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
