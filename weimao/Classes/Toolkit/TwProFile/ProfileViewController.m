//
//  ProfileViewController.m
//  TwProfile
//
//  Created by hunk on 4/30/13.
//  Copyright (c) 2013 mx.com.hunk. All rights reserved.
//

#import "ProfileViewController.h"

static CGFloat ImageHeight  = 150.0;
static CGFloat ImageWidth  = 320.0;

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)updateImg {
    CGFloat yOffset   = _tableView.contentOffset.y;
    
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
		
		UIImage *image = [UIImage imageNamed:@"bg.png"];
        self.imgProfile = [[UIImageView alloc] initWithImage:image];		
		self.imgProfile.frame             = CGRectMake(0, 0, ImageWidth, ImageHeight);
        
        self.tableView = [[UITableView alloc] init];
		self.tableView.dataSource = self;
		self.tableView.delegate = self;
		self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.backgroundColor = [UIColor clearColor];

        [self.view addSubview:self.imgProfile];
        [self.view addSubview:self.tableView];
        
        self.title = @"with UITableView";
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
