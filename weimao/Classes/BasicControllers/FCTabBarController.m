//
//  FCTabBarController.m
//  
//
//  Created by  on 13-4-17.
//  Copyright (c) 2013年 chen wei. All rights reserved.
//

#import "FCTabBarController.h"
#import "LTKNavigationViewController.h"
#import "TMHomePageViewController.h"
#import "TMClassicViewController.h"
#import "TMShopStoreViewController.h"
#import "TMBuildShopStoreViewController.h"
#import "TMMySotreViewController.h"
#import "LTKSeachViewController.h"

@implementation FCTabBarController

-(void)reachabilityChanged:(NSNotification*)note
{
    Reachability* curReach=[note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    NetworkStatus status=[curReach currentReachabilityStatus];
    if (status==NotReachable) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"当前没有网络" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
    
}
-(void)viewWillAppear:(BOOL)animated
{
   
    [super viewWillAppear:animated];
         self.navigationController.navigationBarHidden=YES;
   
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    CGRect screenRect = [[UIScreen mainScreen] bounds];



    
   TMHomePageViewController  *daoHangViewController= [[TMHomePageViewController alloc] init];
    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"gre icon_01.png"]tag:-300];
    daoHangViewController.tabBarItem = item1;
    [item1 release];
    
    TMClassicViewController *homeViewController = [[TMClassicViewController alloc]init];
    UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"gre icon_02.png"]tag:-301];
    homeViewController.tabBarItem = item2;
    [item2 release];
//
//    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"chuangjianchengong"]isEqualToString:@"chengong"]) {
//        
//        
//    }else{

//    }
 
//
    LTKSeachViewController  *gongying = [[LTKSeachViewController alloc] initSeachKeyWord:nil];
    UITabBarItem *item4 = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"gre icon_04.png"]tag:-303];

    gongying.tabBarItem = item4;
    [item4 release];
//
     TMShopStoreViewController *shoppingViewController= [[TMShopStoreViewController alloc]initWithTabbar:YES];
    UITabBarItem *item5 = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"gre icon_05.png"]tag:-304];

    shoppingViewController.tabBarItem = item5;
    [item5 release];


    LTKNavigationViewController*navigationController1= [[[LTKNavigationViewController alloc] initWithRootViewController:daoHangViewController] autorelease];
    LTKNavigationViewController *navigationController2 = [[[LTKNavigationViewController alloc] initWithRootViewController:homeViewController]autorelease];
    
    LTKNavigationViewController *navigationController3;
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"chuangjianchengong"]isEqualToString:@"chengong"])
    {
        
        TMMySotreViewController *actiivityViewController = [[TMMySotreViewController alloc] initWithTabbar:YES];
        UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"gre icon_03.png"]tag:-302];
        actiivityViewController.tabBarItem = item3;
        [item3 release];
        
         navigationController3 = [[[LTKNavigationViewController alloc] initWithRootViewController:actiivityViewController] autorelease];
        
    }else{
        
        TMBuildShopStoreViewController *actiivityViewController = [[TMBuildShopStoreViewController alloc]init];
        UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"gre icon_03.png"]tag:-302];
        actiivityViewController.tabBarItem = item3;
        [item3 release];
        
         navigationController3 = [[[LTKNavigationViewController alloc] initWithRootViewController:actiivityViewController] autorelease];

    }
       LTKNavigationViewController *navigationController4=[[[LTKNavigationViewController alloc]initWithRootViewController:gongying]autorelease];
        LTKNavigationViewController*navigationController5= [[[LTKNavigationViewController alloc] initWithRootViewController:shoppingViewController] autorelease];
//
//    
    NSArray *viewArray = [[NSArray arrayWithObjects:navigationController1,navigationController2, navigationController3, navigationController4,navigationController5,nil] autorelease];

    self.viewControllers = viewArray;

}



-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
//
    [viewController viewWillAppear:animated];

}

-(void)btnPress:(id)sender
{


}
-(void)dealloc
{
//    [tabBarArrow release];
    [super dealloc];
}
@end
