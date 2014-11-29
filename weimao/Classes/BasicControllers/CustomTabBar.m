#import "CustomTabBar.h"
#import "FCLogonViewController.h"
#import "FCRsgisterViewController.h"
#import "FCTabBarController.h"
#import "FCsetViewController.h"

@implementation CustomTabBar


@synthesize currentSelectedIndex;
@synthesize buttons;
@synthesize tabBarArrow=_tabBarArrow;
//@synthesize  _delegate=delegate;
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (NO==_isLoading) {
        TMAppDelegate *app = (TMAppDelegate*)[[UIApplication sharedApplication] delegate];
        [app startLoading];
        _isLoading = YES;
    }
    

   
}
- (void)viewDidAppear:(BOOL)animated
{
    if (slideBg)
    {
        [slideBg removeFromSuperview];
        
        for (int i = 0; i < 5; i ++)
        {
            UIButton *btn = (UIButton*)[self.view viewWithTag:(200 + i)];
            [btn removeFromSuperview];
        }
    }
    
    slideBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu_bg_click1.png"]];

    [self hideRealTabBar];
    [self customTabBar];
}
-(void)viewDidLoad
{
    _isLoading=NO;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(backHome:) name:@"backHome" object:nil];


}
-(void)backHome:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
  [self selectedTab:[self.buttons objectAtIndex:0]];
}
- (void)hideRealTabBar{
    for(UIView *view in self.view.subviews){
        if([view isKindOfClass:[UITabBar class]]){
            view.hidden = YES;
            break;
        }
    }
}

- (void)customTabBar{

    UIImageView *imgView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@""]];
    imgView.frame = CGRectMake(0, self.view.frame.size.height-49, self.view.frame.size.width, 49);
    [self.view addSubview:imgView];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];

    slideBg.frame = CGRectMake(0, self.tabBar.frame.origin.y-5, slideBg.image.size.width, slideBg.image.size.height);
    [self.view addSubview:slideBg];
    [UIView commitAnimations];

    //创建按钮
    int viewCount = self.viewControllers.count > 5 ? 5 : self.viewControllers.count;
    if (self.buttons) {
        self.buttons = nil;
    }
    self.buttons = [NSMutableArray arrayWithCapacity:viewCount];
    double _width = 320 / viewCount;
    double _height = self.tabBar.frame.size.height;
    for (int i = 0; i < viewCount; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*_width ,self.tabBar.frame.origin.y, _width , _height );
        btn.backgroundColor=[UIColor clearColor];
        [btn addTarget:self action:@selector(selectedTab:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0)
        {
            [btn setBackgroundImage:[UIImage imageNamed:@"icon_01.png"] forState:UIControlStateNormal];
        
        }else if (i==1)
        {
            [btn setBackgroundImage:[UIImage imageNamed:@"icon_02.png"] forState:UIControlStateNormal];
        }else if (i==2)
        {
            [btn setBackgroundImage:[UIImage imageNamed:@"icon_03.png"] forState:UIControlStateNormal];
        }else if (i==3)
        {
            [btn setBackgroundImage:[UIImage imageNamed:@"icon_04.png"] forState:UIControlStateNormal];
        }
        else if(i==4)
        {
            [btn setBackgroundImage:[UIImage imageNamed:@"icon_05.png"] forState:UIControlStateNormal];
        }
        btn.tag = 200 + i;
        [self.buttons addObject:btn];
        [self.view  addSubview:btn];
    }
    [imgView release];
    [self selectedTab:[self.buttons objectAtIndex:currentSelectedIndex]];
}

- (void)selectedTab:(UIButton *)button
{
    NSString *selectAtIndex = [NSString stringWithFormat:@"%d",self.currentSelectedIndex + 200];
    UIButton *selectedBtn = (UIButton*)[self.view viewWithTag:[selectAtIndex integerValue]];
    
    if ([selectAtIndex integerValue] == 200)
    {
      
        [selectedBtn setBackgroundImage:[UIImage imageNamed:@"icon_01.png"] forState:UIControlStateNormal];
        TMAppDelegate *app = (TMAppDelegate*)[[UIApplication sharedApplication] delegate];
        [app stopLoading];
    }else if ([selectAtIndex integerValue] == 201)
    {
        [selectedBtn setBackgroundImage:[UIImage imageNamed:@"icon_02.png"] forState:UIControlStateNormal];
    }else if ([selectAtIndex integerValue] == 202)
    {

        [selectedBtn setBackgroundImage:[UIImage imageNamed:@"icon_03.png"] forState:UIControlStateNormal];
    }else if ([selectAtIndex integerValue] == 203)
    {

        [selectedBtn setBackgroundImage:[UIImage imageNamed:@"icon_04.png"] forState:UIControlStateNormal];
    }
    else if([selectAtIndex integerValue]==204)
    {
        
        [selectedBtn setBackgroundImage:[UIImage imageNamed:@"icon_05.png"] forState:UIControlStateNormal];

    }
    
    UIButton *btn = (UIButton*)button;

    self.currentSelectedIndex = btn.tag - 200;
    if (self.currentSelectedIndex==0)
    {
        [slideBg setImage:  BundleImage(@"menu_bg_click1.png")];
        [btn setBackgroundImage:[UIImage imageNamed:@"icon_01C.png"] forState:UIControlStateNormal];
        
    }else if (self.currentSelectedIndex==1)
    {
        [slideBg setImage:  BundleImage(@"menu_bg_click1.png")];

        [btn setBackgroundImage:[UIImage imageNamed:@"icon_02C.png"] forState:UIControlStateNormal];
    }else if (self.currentSelectedIndex==2)
    {
        [slideBg setImage:  BundleImage(@"menu_bg_click1.png")];

        [btn setBackgroundImage:[UIImage imageNamed:@"icon_03C.png"] forState:UIControlStateNormal];
    }else if (self.currentSelectedIndex==3)
    {
        [slideBg setImage:  BundleImage(@"menu_bg_click1.png")];

        [btn setBackgroundImage:[UIImage imageNamed:@"icon_04C.png"] forState:UIControlStateNormal];
    }
    else if(self.currentSelectedIndex==4)
        {
        [slideBg setImage:  BundleImage(@"menu_bg_click1.png")];;
        [btn setBackgroundImage:[UIImage imageNamed:@"icon_05C.png"] forState:UIControlStateNormal];
        }
    
    
//    if (btn.tag==204 ) {
//        if ([[NSUserDefaults standardUserDefaults]objectForKey:@"verify"]==Nil)
//        {
//            FCLogonViewController*VC=[[FCLogonViewController alloc]init];
//            [appDelegate.navigationController pushViewController:VC animated:NO];
//            
//        }else{
//            
//            popupMenu = [[QBPopupMenu alloc] init];
//            QBPopupMenuItem *item1 = [QBPopupMenuItem itemWithTitle:@"我的" image:[UIImage imageNamed:@"usercenter_click.png"] target:self action:@selector(btnMine:)];
//            item1.width = 46;
//            
//            QBPopupMenuItem *item2 = [QBPopupMenuItem itemWithTitle:@"设置" image:[UIImage imageNamed:@"setting_click.png"] target:self action:@selector(btnShop:)];
//            item2.width = 46;
//            popupMenu.items = [NSArray arrayWithObjects:item1,item2, nil];
//            self.popupMenu = popupMenu;
//            [self.popupMenu showInView:self.view atPoint:CGPointMake(320/20*17,self.view.frame.size.height-49)];
//            self.selectedIndex = self.currentSelectedIndex;
//            [self performSelector:@selector(slideTabBg:) withObject:button];
//        }
//    }else if(btn.tag==203)
//    {
//        
//        if ([[NSUserDefaults standardUserDefaults]objectForKey:@"verify"]==Nil)
//        {
//            FCLogonViewController*VC=[[FCLogonViewController alloc]init];
//            [appDelegate.navigationController pushViewController:VC animated:NO];
//        }else{
//        
            self.selectedIndex = self.currentSelectedIndex;
            [self performSelector:@selector(slideTabBg:) withObject:button];
//        }
//        
//    }else{
//        
//        self.selectedIndex = self.currentSelectedIndex;
//        [self performSelector:@selector(slideTabBg:) withObject:button];
//    
//    }

}
//-(void)showTabbar:(id)sender
//{
//    for (int i=0; i<5; i++) {
//        UIButton *btn1=(UIButton*)[self.view viewWithTag:200+i];
//        btn1.hidden=NO;
//    }
//    //
//
//}
//
//-(void)hiddenTabbar:(id)sender
//{
//    for (int i=0; i<5; i++) {
//        UIButton *btn1=(UIButton*)[self.view viewWithTag:200+i];
//        btn1.hidden=YES;
//    }
//    //
//
//}
- (void)slideTabBg:(UIButton *)btn
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.01];
    [UIView setAnimationDelegate:self];
    slideBg.frame = CGRectMake(btn.frame.origin.x , btn.frame.origin.y , slideBg.image.size.width, slideBg.image.size.height);
    [UIView commitAnimations];
   
}
-(void)btnRegister:(id)sender
{

    FCRsgisterViewController*vc=[[FCRsgisterViewController alloc]init];
   TMAppDelegate *appDelegate = (TMAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController pushViewController:vc
                                                animated:YES];
}
-(void)btnLogin:(id)sender
{
    FCLogonViewController*vc=[[FCLogonViewController alloc]init];
   TMAppDelegate *appDelegate = (TMAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController pushViewController:vc
                                                animated:YES];

}
-(void)btnShop:(id)sender
{
    FCsetViewController *VC=[[FCsetViewController alloc]init];
    TMAppDelegate  *appDelegate=(TMAppDelegate*)[[UIApplication sharedApplication]delegate];
    [appDelegate.navigationController pushViewController:VC animated:YES];
    
  
}
-(void)btnMine:(id)sender
{
//    FCMineViewController*VC=[[FCMineViewController alloc]init];
//    FCAppDelegate *appDelegate=(FCAppDelegate*)[[UIApplication sharedApplication]delegate];
//    [appDelegate.navigationController pushViewController:VC animated:YES];
    
}
-(void)timerFirde
{
    [popupMenu dismiss];
    [popupMenuLogin dismiss];

}
-(void)timerFired:(NSTimer *)timer{
    done =YES;
}

- (void) dealloc{
    [popupMenuLogin release];
    [popupMenu release];
    [_imageView5 release];
    [slideBg release];
    [buttons release];
    [super dealloc];
}
@end