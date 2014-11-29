//
//  FCMineViewController.m
//  Flower&Cake
//
//  Created by 呵呵 on 13-7-3.
//  Copyright (c) 2013年 呵呵. All rights reserved.
//

#import "FCMineViewController.h"

#import "QBPopupMenu.h"
@interface FCMineViewController () {
    UIImageView * bg_gray;

}

@end

@implementation FCMineViewController

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
    self.navigationController.navigationBarHidden=YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.hidesBottomBarWhenPushed = NO;
    
    [self initNavigaitonBar];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HideTabBar" object:nil];
//    [self colection];
//    [self alterColection:nil];
}

-(void)initNavigaitonBar
{
    UIImageView *view_bar =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [view_bar setUserInteractionEnabled:YES];
    [view_bar setImage:[UIImage imageNamed:@"navigation_bar.png"]];
    
    UILabel *title_label=[[[UILabel alloc]initWithFrame:CGRectMake(60, 0, 200, 44)]autorelease];
    title_label.text=@"我的";
    title_label.font=[UIFont systemFontOfSize:20];
    [title_label setTextAlignment:NSTextAlignmentCenter];
    title_label.backgroundColor=[UIColor clearColor];
    title_label.textColor =[UIColor whiteColor];
    title_label.shadowColor = [UIColor darkGrayColor];
    title_label.shadowOffset = CGSizeMake(1, 1);
    [view_bar addSubview:title_label];
    
    UIButton*btnBack=[UIButton buttonWithType:0];
    btnBack.frame=CGRectMake(0, 0, 59, 44);
    [btnBack setImage:[UIImage imageNamed:@"nav_home_btn.png"] forState:0];
    [btnBack addTarget:self action:@selector(btnToHome:) forControlEvents:UIControlEventTouchUpInside];
    [view_bar addSubview:btnBack];
    
    UIImageView*leftImageView=[[[UIImageView alloc]initWithFrame:CGRectMake(55, (44-37)/2, 2,37)]autorelease];
    leftImageView.image=[UIImage imageNamed:@"navigation_bar_line.png"];
    [view_bar addSubview:leftImageView];
    
    [self.view addSubview:view_bar];
}

- (void)btnToHome:(UIButton *)btn
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowTabbar" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowHomeVC" object:nil];
}

-(BOOL)showLoading{
    return YES;
}

-(BOOL)closeLoading{
    return YES;
}


- (void)popActionSheet
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:@"拍照上传"
                                                    otherButtonTitles:@"本地照片上传",nil];
    [actionSheet setBackgroundColor:[UIColor clearColor]];
    actionSheet.tag = -2;
    [actionSheet showInView:self.view.window];
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController * picker = [[UIImagePickerController alloc]init];
    switch (buttonIndex)
    {
            
            
        case 0://take photo
        {
            [self presentModalViewController:picker animated:YES];
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.allowsEditing = YES;
            picker.delegate = self;
            
            break;
        }
        case 1://upload image
        {
            //            UIImagePickerController * picker = [[UIImagePickerController alloc]init];
            [self presentModalViewController:picker animated:YES];
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.allowsEditing = YES;
            picker.delegate = self;
            
            break;
        }
        case 2://cancel
        {
            [self.presentedViewController dismissModalViewControllerAnimated:YES];
            break;
        }
        default:
            break;
    }
    [picker release];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    /*添加处理选中图像代码*/
    [picker dismissModalViewControllerAnimated:YES];
    //img_head = image;
    [img_headSculpture setImage:image];
    
    
    NSUserDefaults * ndf = [NSUserDefaults standardUserDefaults];
    
    NSData * data_imghead = UIImagePNGRepresentation(image);
    if (data_imghead);
    else
    {
        data_imghead = UIImageJPEGRepresentation(image, 1);
    }
    
    if (data_imghead)
    {
        [ndf setObject:data_imghead forKey:@"datahead"];
    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    /*添加代码，处理选中图像又取消的情况*/
    [picker dismissModalViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    
}

- (void)takePhoto:(UIButton *)btn
{
    
}



- (void)buildTbContent:(int)count
{
//    [tb removeFromSuperview];
//    tb = [[listTitleDisplayTb alloc]initWithFrame:CGRectMake(0, 140, 320, self.view.frame.size.height - 140) style:UITableViewStyleGrouped count:count];
//    tb.LtTtbSDelegate = self;
//    [tb setBackgroundColor:[UIColor whiteColor]];
//    [self.view addSubview:tb];
//    [tb release];
}


- (void)ListTitleTbSelectSpecificRow:(NSInteger)num
{
//    switch (num)
//    {
//        case 0:
//        {
//            baseInforViewController * baseInforViewControl = [[baseInforViewController alloc]init];
//            [self.navigationController pushViewController:baseInforViewControl animated:YES];
//            break;
//        }
//        case 1:
//        {
//            FCmyOrderViewController * FCmyOrderViewControl = [[FCmyOrderViewController alloc]init];
//            [self.navigationController pushViewController:FCmyOrderViewControl animated:YES];
//
//            break;
//        }
//        case 2:
//        {
//            FCdeliveryAddressViewController * VC = [[FCdeliveryAddressViewController alloc]init];
//            VC.hidesBottomBarWhenPushed=YES;
//            [self.navigationController pushViewController:VC animated:YES];
//            
//            break;
//        }
//        case 3:
//        {
//            FCmyCollectionViewController * FCmyCollectionViewControl =[[FCmyCollectionViewController alloc]init];
//            [self.navigationController pushViewController:FCmyCollectionViewControl animated:YES];
//
//            break;
//        }
//        case 4:
//        {
//            FCalterPasswdViewController * FCalterPasswdViewControl = [[FCalterPasswdViewController alloc]init];
//            [self.navigationController pushViewController:FCalterPasswdViewControl animated:YES];
//
//            break;
//        }
//            
//        default:
//            break;
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
