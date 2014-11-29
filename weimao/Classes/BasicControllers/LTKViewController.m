//
//  LTKViewController.m
//  LvTongKa
//
//  Created by 123 on 13-8-26.
//

#import "LTKViewController.h"

@interface LTKViewController ()

@end

@implementation LTKViewController

//- (void)startLoading
//{
//	[DejalBezelActivityView activityViewForView:self.view.window];
//}
//
//- (void)stopLoading
//{
//    [DejalBezelActivityView removeViewAnimated:YES];
//}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
    self.view.backgroundColor=[UIColor colorWithRed:0.988 green:0.988 blue:0.988 alpha:1.0];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
        // Return YES for supported orientations
    return (interfaceOrientation == UIDeviceOrientationPortrait);
}

- (BOOL)shouldAutorotate {
    return NO;
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
-(BOOL)prefersStatusBarHidden
{
    return  NO;
}
- (NSUInteger)supportedInterfaceOrientations {
    return UIDeviceOrientationPortrait;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
