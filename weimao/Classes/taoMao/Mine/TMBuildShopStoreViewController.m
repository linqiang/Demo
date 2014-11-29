//
//  TMBuildShopStoreViewController.m
//  TaoMao
//
//  Created by  on 14-4-23.
//  Copyright (c) 2014年  All rights reserved.
//

#import "TMBuildShopStoreViewController.h"
//#import "TMAddGoodsViewController.h"
#import "TMMySotreViewController.h"

@interface TMBuildShopStoreViewController ()

@end

@implementation TMBuildShopStoreViewController

-(UIView*)initNavigationBar
{
    self.navigationController.navigationBarHidden = YES;
    view_bar =[[UIView alloc]init];
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>6.1)
    {
        view_bar .frame=CGRectMake(0, 0, self.view.frame.size.width, 44+20);
        UIImageView *imageV = [[UIImageView alloc]initWithImage:BundleImage(@"top.png")];
        [view_bar addSubview:imageV];
        [imageV release];
        
    }else{
        view_bar .frame=CGRectMake(0, 0, self.view.frame.size.width, 44);
        UIImageView *imageV = [[UIImageView alloc]initWithImage:BundleImage(@"top.png")];
        [view_bar addSubview:imageV];
        [imageV release];
    }
    view_bar.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview: view_bar];
    UILabel *title_label=[[UILabel alloc]initWithFrame:CGRectMake(65, view_bar.frame.size.height-44, self.view.frame.size.width-130, 44)];
    title_label.text=@"创建店铺";
    title_label.tag=-101;
    title_label.font=[UIFont boldSystemFontOfSize:20];
    title_label.backgroundColor=[UIColor clearColor];
    title_label.textColor =[UIColor whiteColor];
    title_label.textAlignment=1;
    [view_bar addSubview:title_label];
    
//    btnBack=[UIButton buttonWithType:0];
//    btnBack.frame=CGRectMake(0, view_bar.frame.size.height-34, 47, 34);
//    [btnBack setImage:BundleImage(@"ret_01.png") forState:0];
//    [btnBack addTarget:self action:@selector(btnBack:) forControlEvents:UIControlEventTouchUpInside];
//    [view_bar addSubview:btnBack];
    
    btnTJ=[UIButton buttonWithType:0];
    btnTJ.frame=CGRectMake(view_bar.frame.size.width-55, view_bar.frame.size.height-40, 47, 34);
    
    [btnTJ setTitle:@"完成" forState:0];
    [btnTJ addTarget:self action:@selector(btnTJ:) forControlEvents:UIControlEventTouchUpInside];
    [view_bar addSubview:btnTJ];

    
    [title_label release];
    
    return view_bar;
}

-(void)btnBack:(id)sender
{
    TMAppDelegate *app=(TMAppDelegate*)[UIApplication sharedApplication].delegate;
    [app.navigationController popViewControllerAnimated:YES];
    
}
-(void)btnTJ:(id)sender
{

    [[NSUserDefaults standardUserDefaults]setObject:@"chengong" forKey:@"chuangjianchengong"];
    btnBack.hidden=YES;
    btnTJ.hidden=YES;
    UILabel *label=(UILabel*)[self.view viewWithTag:-101];
    label.text=@"店铺创建成功";
    [_scrollView removeFromSuperview];
    
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-29/2, view_bar.frame.size.height+30, 29, 29)];
    image.image=BundleImage(@"cjcg_ic_.png");
    [self.view addSubview:image];
    
    UILabel *title_label=[[UILabel alloc]initWithFrame:CGRectMake(0, image.frame.size.height+image.frame.origin.y, self.view.frame.size.width, 30)];
    title_label.text=@"恭喜你，你的店铺创建成功啦！";
    title_label.font=[UIFont systemFontOfSize:20];
    title_label.backgroundColor=[UIColor clearColor];
    title_label.textColor =hui5;
    title_label.textAlignment=1;
    [self.view addSubview:title_label];
    
    UIButton *button=[UIButton buttonWithType:0];
    button.frame=CGRectMake(self.view.frame.size.width/2-137/2, title_label.frame.size.height+title_label.frame.origin.y+40, 137, 35);
    [button setImage:BundleImage(@"cjcg_bt_.png") forState:0];
    [button addTarget:self action:@selector(btnWin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];


}
-(void)btnWin:(id)sender
{
    TMMySotreViewController*my=[[TMMySotreViewController alloc]init];
    TMAppDelegate *delegate=(TMAppDelegate*)[UIApplication sharedApplication].delegate;
    [self.navigationController pushViewController:my animated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    touchID1=0;
    [self initNavigationBar];
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake( 0,view_bar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-view_bar.frame.size.height-49)];
    _scrollView.delegate=self;
    _scrollView.contentSize=CGSizeMake(0, self.view.frame.size.height);
    [self.view addSubview:_scrollView];
    self.view.backgroundColor=[UIColor colorWithRed:.95 green:.95 blue:.95 alpha:1.0];
    [self initSubviews];
    
}
-(void)initSubviews
{
    UIImageView *_view1=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 300, 85)];
    _view1.userInteractionEnabled=YES;
    _view1.backgroundColor=[UIColor clearColor];
    _view1.image=BundleImage(@"cjdp_bg_02_.png");
   
    [_scrollView addSubview:_view1];
    
    
    img_headSculpture=[[UrlImageButton alloc]initWithFrame:CGRectMake(12, 12, 60, 60)];
    [img_headSculpture setImage:BundleImage(@"cjdp_df_.png") forState:0];
  
    img_headSculpture.layer.cornerRadius=4;
    [img_headSculpture addTarget:self action:@selector(popActionSheet) forControlEvents:UIControlEventTouchUpInside];
    [_view1 addSubview:img_headSculpture];
    
    UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(img_headSculpture.frame.size.width+img_headSculpture.frame.origin.x+10, 80/2-20/2, 220, 16)];
    label.text=@"点击添加店铺图标(可选)";
    label.font=[UIFont systemFontOfSize:20];
    label.textAlignment=0;
    label.textColor=hui5;
    [_view1 addSubview:label];
    [label release];

    
    UIImageView *_view2=[[UIImageView alloc]initWithFrame:CGRectMake(10, _view1.frame.size.height+_view1.frame.origin.y+10, 300, 85)];
    _view2.userInteractionEnabled=YES;
    _view2.backgroundColor=[UIColor clearColor];
    _view2.image=BundleImage(@"cjdp_bg_01_.png");
    [_scrollView addSubview:_view2];
    
    UILabel *labelDPXX=[[UILabel alloc]initWithFrame:CGRectMake(12, 12, 100, 15)];
    labelDPXX.text=@"店铺信息";
    labelDPXX.font=[UIFont systemFontOfSize:16];
    labelDPXX.backgroundColor=[UIColor clearColor];
    labelDPXX.textColor =hui5;
    labelDPXX.textAlignment=0;
    [_view2 addSubview:labelDPXX];

    UILabel *labelDPMC=[[UILabel alloc]initWithFrame:CGRectMake(12, labelDPXX.frame.size.height+labelDPXX.frame.origin.y+23, 70, 15)];
    labelDPMC.text=@"店铺名称";
    labelDPMC.font=[UIFont systemFontOfSize:16];
    labelDPMC.backgroundColor=[UIColor clearColor];
    labelDPMC.textColor =hui5;
    labelDPMC.textAlignment=0;
    [_view2 addSubview:labelDPMC];
    
    UITextField *fieldDPMC=[[UITextField alloc]initWithFrame:CGRectMake(labelDPMC.frame.size.width+labelDPMC.frame.origin.x+15,labelDPMC.frame.origin.y , 195, 15)];
    fieldDPMC.placeholder=@"建议十个字左右";
    fieldDPMC.font=[UIFont systemFontOfSize:16];
    fieldDPMC.backgroundColor=[UIColor clearColor];
    fieldDPMC.textColor =hui8;
    fieldDPMC.textAlignment=0;
    [fieldDPMC addTarget:self action:@selector(textFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [fieldDPMC addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];

    [_view2 addSubview:fieldDPMC];

    UIImageView *_view3=[[UIImageView alloc]initWithFrame:CGRectMake(10, _view2.frame.size.height+_view2.frame.origin.y+10, 300, 85)];
    _view3.userInteractionEnabled=YES;
    _view3.backgroundColor=[UIColor clearColor];
    _view3.image=BundleImage(@"cjdp_bg_03_.png");
    
    [_scrollView addSubview:_view3];
    
    
    UILabel *labelDPJS=[[UILabel alloc]initWithFrame:CGRectMake(12, 12, 70, 15)];
    labelDPJS.text=@"店铺介绍";
    labelDPJS.font=[UIFont systemFontOfSize:16];
    labelDPJS.backgroundColor=[UIColor clearColor];
    labelDPJS.textColor =hui5;
    labelDPJS.textAlignment=0;
    [_view3 addSubview:labelDPJS];
    
    UITextView *fieldDPJS=[[UITextView alloc]initWithFrame:CGRectMake(12,labelDPJS.frame.origin.y+labelDPJS.frame.size.height+10 , 270, 40)];
    fieldDPJS.font=[UIFont systemFontOfSize:16];
    fieldDPJS.backgroundColor=[UIColor clearColor];
    fieldDPJS.textColor =hui5;
    fieldDPJS.textAlignment=0;
    fieldDPJS.delegate=self;
    fieldDPJS.showsHorizontalScrollIndicator=YES;
    fieldDPJS.scrollEnabled=YES;
    fieldDPJS.bouncesZoom=YES;
    fieldDPJS.canCancelContentTouches=YES;
    fieldDPJS.clearsContextBeforeDrawing=YES;
    fieldDPJS.userInteractionEnabled=YES;
    [_view3 addSubview:fieldDPJS];
    
    UILabel *label_DPJS=[[UILabel alloc]initWithFrame:CGRectMake(0, 10, 150, 20)];
    label_DPJS.text=@"输入文字30字以内";
    label_DPJS.backgroundColor=[UIColor clearColor];
    label_DPJS.font=[UIFont systemFontOfSize:16];
    label_DPJS.textColor =hui8;
    label_DPJS.textAlignment=0;
    label_DPJS.tag=-100;
    [fieldDPJS addSubview:label_DPJS];
    
    UIImageView *_view4=[[UIImageView alloc]initWithFrame:CGRectMake(10, _view3.frame.size.height+_view3.frame.origin.y+10, 300, 150)];
    _view4.userInteractionEnabled=YES;
    _view4.backgroundColor=[UIColor clearColor];
    _view4.image=[[UIImage imageNamed:@"cjdp_bg_03_.png" ]resizableImageWithCapInsets:UIEdgeInsetsMake(40, 0, 10, 0)resizingMode:UIImageResizingModeTile];
    [_scrollView addSubview:_view4];
    
    UILabel *label_SPFL=[[UILabel alloc]initWithFrame:CGRectMake(12, 12, 70, 15)];
    label_SPFL.text=@"商品分类";
    label_SPFL.font=[UIFont systemFontOfSize:16];
    label_SPFL.backgroundColor=[UIColor clearColor];
    label_SPFL.textColor =hui5;
    label_SPFL.textAlignment=0;
    [_view4 addSubview:label_SPFL];
    
    
    for (int i=0; i<7; i++)
    {
        UrlImageButton *btnNine=[[UrlImageButton alloc]initWithFrame:CGRectMake((i%4)*71+10, floor(i/4)*40+50,65, 30)];
        btnNine.backgroundColor=[UIColor whiteColor];
        btnNine.tag=i+1000;
        [btnNine setTitle:@"男人时尚" forState:0];
        [btnNine setTitleColor:[UIColor colorWithRed:.2 green:.2 blue:.2 alpha:1.0] forState:0];
        btnNine.titleLabel.font=[UIFont systemFontOfSize:14];
        btnNine.layer.masksToBounds=YES;
        btnNine.layer.borderWidth=1;
        btnNine.layer.cornerRadius = 4;
        btnNine.layer.borderColor = [[UIColor colorWithRed:.8 green:.8 blue:.8 alpha:1.0] CGColor];
        [btnNine addTarget:self action:@selector(btnNine:) forControlEvents:UIControlEventTouchUpInside];
        [_view4 addSubview:btnNine];
    }
}

-(void)btnNine:(id)sender
{
    UIButton *button=(UIButton*)sender;
    UIButton *btn1=(UIButton*)[self.view viewWithTag:touchID1];
    btn1.backgroundColor=[UIColor whiteColor];
   
    if (touchID1>0) {
       
         [btn1 setTitleColor:[UIColor colorWithRed:.2 green:.2 blue:.2 alpha:1.0] forState:0];
    }
    [button setTitleColor:[UIColor whiteColor] forState:0];
    
    if (button.tag==touchID1) {
        UIButton *btn=(UIButton*)[self.view viewWithTag:touchID1];
        btn.backgroundColor=[UIColor clearColor];

    }else{
    
        button.backgroundColor=hongShe;
        touchID1=button.tag;
    }

}

- (void) textFieldBegin:(id)sender
{
    UITextField *t = (UITextField*)sender;
    NSLog(@"%i",t.tag);
    
}

- (void) textFieldDone:(id)sender
{
    [sender resignFirstResponder];
}
#pragma mark keyboard methods

- (void)keyboardWillShow:(NSNotification *)notification
{
  
    NSTimeInterval animationDuration = 0.30f;
    CGRect frame = self.view.frame;
    frame.origin.y = -50;
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = frame;
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    NSTimeInterval animationDuration = 0.30f;
    CGRect frame = self.view.frame;
    frame.origin.y =0;
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = frame;
    [UIView commitAnimations];
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    else if (textView.text.length>30 && range.length == 0)
    {
        ShowMessage(@"超过最大字数30!");
        return NO;
    }
    else {
        return YES;
    }
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    return YES;
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    UILabel *label=(UILabel*)[self.view viewWithTag:-100];
    label.hidden=YES;
    [self keyboardWillShow:nil];

}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self keyboardWillHide:nil];
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
    [actionSheet showInView:self.view];
}
#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController * picker = [[UIImagePickerController alloc]init];
    switch (buttonIndex)
    {
            
            
        case 0://take photo
        {
//            [self presentModalViewController:picker animated:YES];
            [self presentViewController:picker animated:YES completion:nil];
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.allowsEditing = YES;
            picker.delegate = self;
            
            break;
        }
        case 1://upload image
        {
            //            UIImagePickerController * picker = [[UIImagePickerController alloc]init];
//            [self presentModalViewController:picker animated:YES];
            [self presentViewController:picker animated:YES completion:nil];

            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.allowsEditing = YES;
            picker.delegate = self;
            
            break;
        }
        case 2://cancel
        {
            //            [self.presentedViewController dismissModalViewControllerAnimated:YES];
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
    img_head =[[UIImage alloc] init];
    img_head=image;
    
    [img_headSculpture setImage:image forState:0];

    data_imghead=[[NSData dataWithData:UIImageJPEGRepresentation(image,1)] retain];
    if (data_imghead);
    else
    {
        data_imghead = UIImageJPEGRepresentation(image, 1);
    }
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"datahead"];
    [[NSUserDefaults standardUserDefaults]setObject:data_imghead forKey:@"datahead"];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    /*添加代码，处理选中图像又取消的情况*/
//    [picker dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
