//
//  LTKNavigationViewController.m
//  LvTongKa
//
//  Created by 123 on 13-8-26.

//

#import "LTKNavigationViewController.h"

@interface LTKNavigationViewController ()

@end

@implementation LTKNavigationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   	// Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{

    self.navigationController.navigationBarHidden=YES;

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
