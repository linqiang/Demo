//
//  TMAddGoodsViewController.m
//  TaoMao
//
//  Created by mac on 14-4-24.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "TMAddGoodsViewController.h"
#import "SwipeView.h"

@interface TMAddGoodsViewController ()

@end

@implementation TMAddGoodsViewController

-(UIView*)initNavigationBar
{
    self.navigationController.navigationBarHidden = YES;
    view_bar =[[UIView alloc]init];
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>6.1)
    {
        view_bar .frame=CGRectMake(0, 0, self.view.frame.size.width, 44+20);
        UIImageView *imageV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, 44+20)];
        imageV.image = BundleImage(@"top.png");
        [view_bar addSubview:imageV];
        [imageV release];
        
    }else{
        view_bar .frame=CGRectMake(0, 0, self.view.frame.size.width, 44);
        UIImageView *imageV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, 44)];
        imageV.image = BundleImage(@"top.png");
        [view_bar addSubview:imageV];
        [imageV release];
    }
    view_bar.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview: view_bar];
    UILabel *title_label=[[UILabel alloc]initWithFrame:CGRectMake(65, view_bar.frame.size.height-44, self.view.frame.size.width-130, 44)];
    title_label.text=@"添加商品";
    title_label.font=[UIFont boldSystemFontOfSize:20];
    title_label.backgroundColor=[UIColor clearColor];
    title_label.textColor =[UIColor whiteColor];
    title_label.textAlignment=1;
    [view_bar addSubview:title_label];
    
    UIButton*btnBack=[UIButton buttonWithType:0];
    btnBack.frame=CGRectMake(0, view_bar.frame.size.height-34, 47, 34);
    [btnBack setImage:BundleImage(@"ret_01.png") forState:0];
    [btnBack addTarget:self action:@selector(btnBack:) forControlEvents:UIControlEventTouchUpInside];
    [view_bar addSubview:btnBack];

    
    UIButton*btnTJ=[UIButton buttonWithType:0];
    btnTJ.frame=CGRectMake(view_bar.frame.size.width-55, view_bar.frame.size.height-40, 47, 34);
    
    [btnTJ setTitle:@"完成" forState:0];
    [btnTJ addTarget:self action:@selector(btnTJ:) forControlEvents:UIControlEventTouchUpInside];
    [view_bar addSubview:btnTJ];
    
    
    [title_label release];
    
    return view_bar;
}
-(void)btnTJ:(id)sender
{

}
-(void)btnBack:(id)sender
{
    TMAppDelegate *app=(TMAppDelegate*)[UIApplication sharedApplication].delegate;
    [app.navigationController popViewControllerAnimated:YES];
    
}


//-(void)addButton:(id)sender
//{
//    
//    _xinhao_Height+=1;
//
//    
//    [_tableView reloadData];
//}
//-(void)cutButton:(id)sender
//{
//    UIButton*btn=(UIButton*)sender;
//    int b=(int)btn.tag;
//    NSLog(@"%d",b);
////    [_tableView beginUpdates];
//
// 
//    NSIndexPath*path=[NSIndexPath indexPathForRow:btn.tag-10001 inSection:0];
//    NSLog(@"%d",(int)path.row);
//    NSMutableArray *delete_array=[[NSMutableArray alloc]init];
//    [delete_array addObject:path];
//      NSLog(@"%d",_xinhao_Height);
//     _xinhao_Height-=1;
//    [_tableView deleteRowsAtIndexPaths:delete_array withRowAnimation:NO];
//   
//}

-(void)btnSelect:(id)sender
{
    bgView = [[UIView alloc]initWithFrame:CGRectMake(0,0, 320,self.view.frame.size.height)];
    [bgView setTag:99999];
    [bgView setBackgroundColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.9]];
    [bgView setAlpha:1.0];
    
    [self.view addSubview:bgView];
    NSArray *arrayL=[[NSArray alloc]initWithObjects:@"电脑",@"水果",@"手机",@"电脑1",@"水果1",@"手机1",@"电脑2",@"水果2",@"手机2" ,nil];
    
    firstLevelMenuView = [[firstLevelMenu1 alloc]initWithFrame:CGRectMake(10, 0, 300,300) Contents:arrayL addSelectTag:cellIndexPath];
    firstLevelMenuView.tag = 100000;
    firstLevelMenuView.layer.cornerRadius=4;
    firstLevelMenuView.menuDelegate11 = self;
    firstLevelMenuView.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];
    [bgView addSubview:firstLevelMenuView];
    [UIView beginAnimations:@"animationID" context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:firstLevelMenuView cache:NO];
    firstLevelMenuView.frame= CGRectMake(320/2-250/2, self.view.frame.size.height/2-250/2, 250,250);
    
    [UIView commitAnimations];



}

//一级代理
- (void)selectTheSpecificRow:(int)num addSelectTag:(int)tag
{
    cellIndexPath=tag;
    NSLog(@"%d",num);
//    _marraySecond=[[NSMutableArray alloc]init];
//    [_marraySecond removeAllObjects];
//    cellIndexPath=num;
    
//    if (tag==1)
//    {
    
        
//        if ([[[_marrayCategory objectAtIndex:num]cList ]count]>0)//距离有二级分类
//        {
//            hasSecond=YES;
//            for (int i =0; i<[[[_marrayCategory objectAtIndex:num]cList ] count]; i++)
//            {
//                
//                if ([[[[_marrayCategory objectAtIndex:num]cList ] objectAtIndex:i] name]==nil)
//                {
//                    [_marraySecond addObject:@""];
//                }else
//                {
//                    [_marraySecond addObject:[[[[_marrayCategory objectAtIndex:num]cList ] objectAtIndex:i] name]];
//                }
//                
//            }
//            
            if ([self.view viewWithTag:99999])
            {
                [[self.view viewWithTag:99999] removeFromSuperview];
            }
            label_xzfl.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"fenglei"];
    
//       NSArray*array=[[NSArray alloc]initWithObjects:@"1",@"2", nil];
//            secondLevelMenuView = [[secondLevelMenu1 alloc]initWithFrame:CGRectMake(160, firstLevelMenuView.frame.origin.y, 150, 400) Contents:array];
//            secondLevelMenuView.tag = 100001;
//            secondLevelMenuView.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0];
//            secondLevelMenuView.smenuDelegate1 = self;
//            [bgView addSubview:secondLevelMenuView];
//            
//        }else{
//            hasSecond=NO;
//            if (_btn1Select==YES)
//            {
//                _page=1;
//                [self colection1:num];
//            }
//        }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _xinhao_Height=0;
    cellIndexPath=0;
    arrayView=[[NSMutableArray alloc]init];
    [self initNavigationBar];
    _scrollViewBG=[[UIScrollView alloc]initWithFrame:CGRectMake(0, view_bar.frame.size.height, 320, self.view.frame.size.height-view_bar.frame.size.height)];
    _scrollViewBG.delegate = self;
    _scrollViewBG.userInteractionEnabled=YES;
    _scrollViewBG.showsVerticalScrollIndicator = NO;
    _scrollViewBG.backgroundColor=[UIColor colorWithRed:.95 green:.95 blue:.95 alpha:1.0];
    [self.view addSubview:_scrollViewBG];
    [self initHeaderView];
    
    elcPicker = [[ELCImagePickerController alloc] initImagePicker];
    elcPicker.maximumImagesCount = 4;
    elcPicker.returnsOriginalImage = NO; //Only return the fullScreenImage, not the fullResolutionImage
    elcPicker.imagePickerDelegate = self;

}

-(void)initHeaderView
{

    
    UIImageView *_view1=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 300, 85)];
    _view1.userInteractionEnabled=YES;
    _view1.backgroundColor=[UIColor clearColor];
    _view1.image=BundleImage(@"cjdp_bg_02_.png");
    [_scrollViewBG addSubview:_view1];
    
    img_headSculpture=[[UrlImageButton alloc]initWithFrame:CGRectMake(12, 12, 60, 60)];
    [img_headSculpture setImage:BundleImage(@"tt_tutu_01.png") forState:0];
    [img_headSculpture addTarget:self action:@selector(popActionSheet) forControlEvents:UIControlEventTouchUpInside];
    [_view1 addSubview:img_headSculpture];
    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(img_headSculpture.frame.size.width+img_headSculpture.frame.origin.x+10, img_headSculpture.frame.origin.y, 210, 60)];

    _scrollView.backgroundColor=[UIColor clearColor];
    [_view1 addSubview:_scrollView];


    
    //tj_textbox_01@2x
    UIImageView *image_SPXX=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-296/2, _view1.frame.size.height+_view1.frame.origin.y+10, 296, 334)];
    image_SPXX.image=BundleImage(@"tt_textbox_01.png");
    image_SPXX.userInteractionEnabled=YES;
    
    [_scrollViewBG addSubview:image_SPXX];
    
    UILabel*label_spxx=[[UILabel alloc]initWithFrame:CGRectMake(5, 7, 200, 15)];
    label_spxx.text=@"商品信息";
    label_spxx.backgroundColor=[UIColor clearColor];
    label_spxx.textAlignment=0;
    label_spxx.textColor=[UIColor whiteColor];
    [image_SPXX addSubview:label_spxx];
    
    UILabel*label_spms=[[UILabel alloc]initWithFrame:CGRectMake(5, 50, 70, 15)];
    label_spms.text=@"商品描述";
    label_spms.backgroundColor=[UIColor clearColor];
    label_spms.textAlignment=0;
    label_spms.textColor=hui1;
    [image_SPXX addSubview:label_spms];
    
    UILabel*label_spms_detail=[[UILabel alloc]initWithFrame:CGRectMake(5, label_spms.frame.size.height+label_spms.frame.origin.y, 70, 15)];
    label_spms_detail.text=@"最多300个字";
    label_spms_detail.font=[UIFont systemFontOfSize:12];
    label_spms_detail.backgroundColor=[UIColor clearColor];
    label_spms_detail.textAlignment=0;
    label_spms_detail.textColor=hui5;
    [image_SPXX addSubview:label_spms_detail];
    
    UITextView *fieldDPJS=[[UITextView alloc]initWithFrame:CGRectMake(90,label_spxx.frame.origin.y+label_spxx.frame.size.height+12 , 200, 60)];
    fieldDPJS.font=[UIFont systemFontOfSize:14];
    fieldDPJS.backgroundColor=[UIColor clearColor];
    fieldDPJS.textColor =hui5;
    fieldDPJS.textAlignment=0;
    fieldDPJS.delegate=self;
    fieldDPJS.showsHorizontalScrollIndicator=YES;
    fieldDPJS.scrollEnabled=YES;
    fieldDPJS.bouncesZoom=YES;
    fieldDPJS.tag=1000;
    fieldDPJS.canCancelContentTouches=YES;
    fieldDPJS.clearsContextBeforeDrawing=YES;
    fieldDPJS.userInteractionEnabled=YES;
    [image_SPXX addSubview:fieldDPJS];
    
    UILabel*label_spfl=[[UILabel alloc]initWithFrame:CGRectMake(5, label_spms.frame.size.height+label_spms.frame.origin.y+47, 70, 15)];
    label_spfl.text=@"商品分类";
    label_spfl.font=[UIFont systemFontOfSize:17];
    label_spfl.backgroundColor=[UIColor clearColor];
    label_spfl.textAlignment=0;
    label_spfl.textColor=hui1;
    [image_SPXX addSubview:label_spfl];
    
    
    label_xzfl=[[UILabel alloc]initWithFrame:CGRectMake(label_spfl.frame.origin.x+label_spfl.frame.size.width+10, label_spfl.frame.origin.y, 200, 15)];
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"fenglei"]==nil)
    {
        label_xzfl.text=@"选择分类";
    }else{
        label_xzfl.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"fenglei"];
    }

    label_xzfl.font=[UIFont systemFontOfSize:17];
    label_xzfl.backgroundColor=[UIColor clearColor];
    label_xzfl.textAlignment=0;
    label_xzfl.textColor=hui5;
    [image_SPXX addSubview:label_xzfl];
    
    //    27*38
    UIButton *btnSelect=[UIButton buttonWithType:0];
    btnSelect.frame=CGRectMake(image_SPXX.frame.size.width-28, label_xzfl.frame.origin.y-12, 27, 38);
    [btnSelect addTarget:self action:@selector(btnSelect:) forControlEvents:UIControlEventTouchUpInside];
    [btnSelect setImage:BundleImage(@"selecticon_01.png") forState:0];
    [image_SPXX addSubview:btnSelect];

    UILabel*label_xh=[[UILabel alloc]initWithFrame:CGRectMake(label_spfl.frame.origin.x, label_spfl.frame.origin.y+label_spfl.frame.size.height+25, 200, 15)];
    label_xh.text=@"型       号";
    label_xh.font=[UIFont systemFontOfSize:17];
    label_xh.backgroundColor=[UIColor clearColor];
    label_xh.textAlignment=0;
    label_xh.textColor=hui1;
    [image_SPXX addSubview:label_xh];
    
    
    UITextField *field_xh=[[UITextField alloc]initWithFrame:CGRectMake(90,label_xh.frame.origin.y-3 , 195, 20)];
    field_xh.font=[UIFont systemFontOfSize:14];
    field_xh.backgroundColor=[UIColor clearColor];
    field_xh.textColor =hui5;
    field_xh.textAlignment=0;
    field_xh.delegate=self;
    field_xh.tag=1001;
    field_xh.clearsContextBeforeDrawing=YES;
    field_xh.userInteractionEnabled=YES;
    [field_xh addTarget:self action:@selector(textFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [field_xh addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [image_SPXX addSubview:field_xh];
    
    UILabel*label_jg=[[UILabel alloc]initWithFrame:CGRectMake(label_xh.frame.origin.x, label_xh.frame.origin.y+label_xh.frame.size.height+25, 200, 15)];
    label_jg.text=@"价       格";
    label_jg.font=[UIFont systemFontOfSize:17];
    label_jg.backgroundColor=[UIColor clearColor];
    label_jg.textAlignment=0;
    label_jg.textColor=hui1;
    [image_SPXX addSubview:label_jg];
    
    
    UITextField *field_jg=[[UITextField alloc]initWithFrame:CGRectMake(90,label_jg.frame.origin.y-3 , 195, 20)];
    field_jg.font=[UIFont systemFontOfSize:14];
    field_jg.backgroundColor=[UIColor clearColor];
    field_jg.textColor =hui5;
    field_jg.textAlignment=0;
    field_jg.delegate=self;
    field_jg.tag=1002;
    field_jg.clearsContextBeforeDrawing=YES;
    field_jg.userInteractionEnabled=YES;
    [field_jg addTarget:self action:@selector(textFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [field_jg addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [image_SPXX addSubview:field_jg];
    
    UILabel*label_jg_hd=[[UILabel alloc]initWithFrame:CGRectMake(label_jg.frame.origin.x, label_jg.frame.origin.y+label_jg.frame.size.height+25, 200, 15)];
    label_jg_hd.text=@"活动价格";
    label_jg_hd.font=[UIFont systemFontOfSize:17];
    label_jg_hd.backgroundColor=[UIColor clearColor];
    label_jg_hd.textAlignment=0;
    label_jg_hd.textColor=hui1;
    [image_SPXX addSubview:label_jg_hd];
    
    UITextField *field_jg_hd=[[UITextField alloc]initWithFrame:CGRectMake(90,label_jg_hd.frame.origin.y-3 , 195, 20)];
    field_jg_hd.font=[UIFont systemFontOfSize:14];
    field_jg_hd.backgroundColor=[UIColor clearColor];
    field_jg_hd.textColor =hui5;
    field_jg_hd.textAlignment=0;
    field_jg_hd.delegate=self;
    field_jg_hd.tag=1003;
    field_jg_hd.clearsContextBeforeDrawing=YES;
    field_jg_hd.userInteractionEnabled=YES;
    [field_jg_hd addTarget:self action:@selector(textFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [field_jg_hd addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [image_SPXX addSubview:field_jg_hd];
    
    UILabel*label_KC=[[UILabel alloc]initWithFrame:CGRectMake(label_jg_hd.frame.origin.x, label_jg_hd.frame.origin.y+label_jg_hd.frame.size.height+25, 200, 15)];
    label_KC.text=@"库       存";
    label_KC.font=[UIFont systemFontOfSize:17];
    label_KC.backgroundColor=[UIColor clearColor];
    label_KC.textAlignment=0;
    label_KC.textColor=hui1;
    [image_SPXX addSubview:label_KC];
    
    UITextField *field_kc=[[UITextField alloc]initWithFrame:CGRectMake(90,label_KC.frame.origin.y-3 , 195, 20)];
    field_kc.font=[UIFont systemFontOfSize:14];
    field_kc.backgroundColor=[UIColor clearColor];
    field_kc.textColor =hui5;
    field_kc.textAlignment=0;
    field_kc.delegate=self;
    field_kc.tag=1004;
    field_kc.clearsContextBeforeDrawing=YES;
    field_kc.userInteractionEnabled=YES;
    [field_kc addTarget:self action:@selector(textFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [field_kc addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [image_SPXX addSubview:field_kc];
    
    UILabel*label_ys=[[UILabel alloc]initWithFrame:CGRectMake(label_KC.frame.origin.x, label_KC.frame.origin.y+label_KC.frame.size.height+25, 200, 15)];
    label_ys.text=@"颜       色";
    label_ys.font=[UIFont systemFontOfSize:17];
    label_ys.backgroundColor=[UIColor clearColor];
    label_ys.textAlignment=0;
    label_ys.textColor=hui1;
    [image_SPXX addSubview:label_ys];
    
    UITextField *field_ys=[[UITextField alloc]initWithFrame:CGRectMake(90,label_ys.frame.origin.y-3 , 195, 20)];
    field_ys.font=[UIFont systemFontOfSize:14];
    field_ys.backgroundColor=[UIColor clearColor];
    field_ys.textColor =hui5;
    field_ys.textAlignment=0;
    field_ys.delegate=self;
    field_ys.tag=1005;
    field_ys.clearsContextBeforeDrawing=YES;
    field_ys.userInteractionEnabled=YES;
    [field_ys addTarget:self action:@selector(textFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [field_ys addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [image_SPXX addSubview:field_ys];
    
     _scrollViewBG.contentSize=CGSizeMake(320, _view1.frame.size.height+25+image_SPXX.frame.size.height);
}



- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    

    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self keyboardWillHide:nil];
}


#pragma mark 文本框
- (void) textFieldBegin:(id)sender
{
    
//    UIButton*btn=(UIButton*)[self.view viewWithTag:-102];
//    btn.enabled=NO;
//    ShowMessage(@"请编辑完再添加型号信息");
    UITextField *t = (UITextField*)sender;
    NSLog(@"%d",(int)t.tag);
    NSTimeInterval animationDuration = 0.30f;
    CGRect frame = self.view.frame;
    frame.origin.y = -40*(t.tag-1000)-40;
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = frame;
    [UIView commitAnimations];
}

- (void) textFieldDone:(id)sender
{
    [sender resignFirstResponder];
    NSTimeInterval animationDuration = 0.30f;
    CGRect frame = self.view.frame;
    frame.origin.y =0;
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = frame;
    [UIView commitAnimations];
}
#pragma mark keyboard methods

- (void)keyboardWillShow:(NSNotification *)notification
{
    
    NSTimeInterval animationDuration = 0.30f;
    CGRect frame = self.view.frame;
    frame.origin.y = -40;
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
        ShowMessage(@"超过最大字数300!");
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
         
            
            [self presentViewController:elcPicker animated:YES completion:nil];
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

- (void)displayPickerForGroup:(ALAssetsGroup *)group
{
	ELCAssetTablePicker *tablePicker = [[ELCAssetTablePicker alloc] initWithStyle:UITableViewStylePlain];
    tablePicker.singleSelection = YES;
    tablePicker.immediateReturn = YES;
    
	elcPicker = [[ELCImagePickerController alloc] initWithRootViewController:tablePicker];
    elcPicker.maximumImagesCount = 1;
    elcPicker.imagePickerDelegate = self;
    elcPicker.returnsOriginalImage = NO; //Only return the fullScreenImage, not the fullResolutionImage
	tablePicker.parent = elcPicker;
    
    // Move me
    tablePicker.assetGroup = group;
    [tablePicker.assetGroup setAssetsFilter:[ALAssetsFilter allAssets]];
    
    [self presentViewController:elcPicker animated:YES completion:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return YES;
    } else {
        return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
    }
}

#pragma mark ELCImagePickerControllerDelegate Methods

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
	
    for (UIView *v in [_scrollView subviews]) {
        [v removeFromSuperview];
    }
    
	CGRect workingFrame = _scrollView.frame;
	workingFrame.origin.x = 0;
    self.chosenImages=[[NSMutableArray alloc]init];
   images = [NSMutableArray arrayWithCapacity:[info count]];
	
	for (NSDictionary *dict in info) {
        
        UIImage *image = [dict objectForKey:UIImagePickerControllerOriginalImage];
        [images addObject:image];
        [self.chosenImages addObject:image];
		UIImageView *imageview = [[UIImageView alloc] initWithImage:image];
		[imageview setContentMode:UIViewContentModeScaleAspectFit];
		imageview.frame = CGRectMake((images.count-1)*70,0 , 60, 60);
        imageview.layer.borderColor=hui8Cg;
        imageview.layer.borderWidth=1;
		imageview.image=image;
		[_scrollView addSubview:imageview];
        _scrollView.contentSize=CGSizeMake(images.count*70, 60);
		
//		workingFrame.origin.x = workingFrame.origin.x + workingFrame.size.width;
	}
    
    self.chosenImages = images;
	
//	[_scrollView setPagingEnabled:YES];
//	[_scrollView setContentSize:CGSizeMake(workingFrame.origin.x, workingFrame.size.height)];
    
    
//    self.chosenImages = images;

}

- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}









- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
