//
//  ProfileImagesViewController.m
//  TwProfile
//
//  Created by Edgar on 5/19/13.
//  Copyright (c) 2013 mx.com.hunk. All rights reserved.
//

#import "ProfileImagesViewController.h"

static CGFloat ImageHeight  = 150.0;
static CGFloat ImageWidth  = 320.0;

@interface ProfileImagesViewController ()


@end

@implementation ProfileImagesViewController

- (void)updateImg {
    CGFloat yOffset   = _tableView.contentOffset.y;
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


#pragma mark - Table View Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self updateImg];
}

#pragma mark - Table View Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0)
		return 1;
	else
		return 12;
	
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0)
		return ImageHeight;
    else
		return 44.0;
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellReuseIdentifier   = @"SectionTwoCell";
    NSString *windowReuseIdentifier = @"SectionOneCell";
    
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:windowReuseIdentifier];
        if (!cell) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:windowReuseIdentifier];
            [cell.contentView addSubview:self.wrapperScroll];
        }
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifier];
            cell.contentView.backgroundColor = [UIColor lightGrayColor];
            
            
        }
        cell.textLabel.text = [ NSString stringWithFormat:@"cell %i",indexPath.row];
    }
    
	cell.selectionStyle              = UITableViewCellSelectionStyleNone;
	
    return cell;
}

- (id)init
{
    self = [super init];
    if (self) {
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

        
        self.tableView = [[UITableView alloc] init];
		self.tableView.dataSource = self;
		self.tableView.delegate = self;
		self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.backgroundColor = [UIColor clearColor];
        
        [self.view addSubview:self.tableView];
        
        //wrapper scroll
        self.wrapperScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ImageWidth, ImageHeight)];
        self.wrapperScroll.backgroundColor = [UIColor clearColor];
        self.wrapperScroll.delegate = self;
        self.wrapperScroll.pagingEnabled = YES;
        self.wrapperScroll.showsVerticalScrollIndicator = NO;
        self.wrapperScroll.showsHorizontalScrollIndicator = NO;
        
        self.wrapperScroll.contentSize = CGSizeMake([images count]*ImageWidth, ImageHeight);
        
        self.title = @"img+ with UITableView";
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    CGRect bounds = self.view.bounds;
    _tableView.frame = bounds;
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
