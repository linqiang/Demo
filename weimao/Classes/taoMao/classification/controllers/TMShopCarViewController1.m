//
//  TMShopCarViewController.m
//  TaoMao
//
//  Created by mac on 14-4-18.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "TMShopCarViewController1.h"
#import "FCShoppingCell.h"
#import "WCAlertView.h"
#import "FCAccountViewController.h"
@interface TMShopCarViewController1 ()
{
  float _price;
}
@end

@implementation TMShopCarViewController1

-(id)initWithTabbar:(BOOL)isTabbar
{
    self=[super init];
    if (self)
    {
//        _isTabbar=isTabbar;
    }
    return self;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    _price=0.0;

    self.navigationController.navigationBarHidden=YES;
    self.view.backgroundColor = [UIColor whiteColor];
    deleteArray = [[NSMutableArray alloc] init];
    _arrayPrice=[[NSMutableArray alloc]initWithObjects:@"100",@"130",@"50",@"70",@"990", nil];
    _checkBtnArray=[[NSMutableArray alloc]init];
    _checkBtnArray1=[[NSMutableArray alloc]init];
    
    [self initNavigationBar];
    [self addViews];
    [self initToolBar];
}

-(void)addViews
{
    _isCheck=NO;//多选选中状态
    _isTouch=NO;
    _isDelete=NO;
    _isShare=NO;
    _isAccount=NO;
    
//    if (_isTabbar==YES)
//    {
         _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, view_bar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-view_bar.frame.size.height-50-49)style:UITableViewStylePlain];
//    }else{
//    
//     _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, view_bar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-view_bar.frame.size.height-50)style:UITableViewStylePlain];
//    }
   
    _tableView.userInteractionEnabled=YES;
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.backgroundView=nil;
    _tableView.backgroundColor=[UIColor colorWithRed:.95 green:.95 blue:.95 alpha:1.0];
    _tableView.showsHorizontalScrollIndicator=NO;
    _tableView.showsVerticalScrollIndicator=NO;
    _tableView.separatorColor=[UIColor clearColor];
//    self.view.backgroundColor=[UIColor colorWithRed:.5 green:.5 blue:.5 alpha:1.0];
    [self.view addSubview:_tableView];
}

-(UIView*)initNavigationBar
{
    view_bar =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
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
    UILabel *title_label=[[UILabel alloc]initWithFrame:CGRectMake(65, view_bar.frame.size.height-44, self.view.frame.size.width-130, 44)];
    title_label.text=@"魅典幻镜";
    title_label.font=[UIFont boldSystemFontOfSize:20];
    title_label.backgroundColor=[UIColor clearColor];
    title_label.textColor =[UIColor whiteColor];
    title_label.textAlignment=1;
    [view_bar addSubview:title_label];


    UIButton*btnSelecdAll=[UIButton buttonWithType:0];
    btnSelecdAll.frame=CGRectMake(self.view.frame.size.width-60, 0, 54, 44);
    
    [btnSelecdAll setBackgroundImage:BundleImage(@"all_btn.png") forState:0];
    [btnSelecdAll setTitleColor:[UIColor whiteColor] forState:0];
    btnSelecdAll.titleLabel.textColor=[UIColor whiteColor];
    [btnSelecdAll addTarget:self action:@selector(btnSelecdAll:) forControlEvents:UIControlEventTouchUpInside];
    [view_bar addSubview:btnSelecdAll];
    UIImageView*leftImageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-60, (44-37)/2, 2,37)];
    leftImageView.image=BundleImage(@"navigation_bar_line.png");
    [view_bar addSubview:leftImageView];
    [view_bar addSubview:btnSelecdAll];
    [self.view addSubview:view_bar];
    
    UIButton*btnBack=[UIButton buttonWithType:0];
    btnBack.frame=CGRectMake(0, view_bar.frame.size.height-34, 47, 34);
    [btnBack setImage:BundleImage(@"ret_01.png") forState:0];
    [btnBack addTarget:self action:@selector(btnBack:) forControlEvents:UIControlEventTouchUpInside];
    [view_bar addSubview:btnBack];
    
   

    UIButton*btnHome=[UIButton buttonWithType:0];
    btnHome.frame=CGRectMake(view_bar.frame.size.width-55, view_bar.frame.size.height-40, 47, 34);
    [btnHome setImage:BundleImage(@"shop_zy_.png") forState:0];
    [btnHome addTarget:self action:@selector(btnHome:) forControlEvents:UIControlEventTouchUpInside];
    [view_bar addSubview:btnHome];
//    if (_isTabbar==YES)
//    {
        btnBack.hidden=YES;
        btnHome.hidden=YES;
//    }
    [title_label release];
    [view_bar release];

    return view_bar;
}
-(void)btnHome:(id)sender
{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"backHome" object:nil];
}
-(void)btnBack:(id)sender
{
    TMAppDelegate *app=(TMAppDelegate*)[UIApplication sharedApplication].delegate;
    [app.navigationController popViewControllerAnimated:YES];
    
}
-(void)viewWillAppear:(BOOL)animated
{
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"showTabbar" object:nil];
 
    _isSelecedAll=NO;
    _isPOP = YES;
    
    [deleteArray removeAllObjects];

}
-(UIView *)initToolBar
{
//    if (_isTabbar==YES)
//    {
            view_toolBar =[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-49-49, self.view.frame.size.width, 49)];
//    }else{
//    
//        view_toolBar =[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-49, self.view.frame.size.width, 49)];
//    }

    view_toolBar.backgroundColor=[UIColor whiteColor];
    view_toolBar.layer.borderColor=[UIColor colorWithRed:.9 green:.9  blue:.9  alpha:1.0].CGColor;
    view_toolBar.layer.borderWidth=1;
    [self.view addSubview:view_toolBar];
    
    UIButton *checkBtn1=[UIButton buttonWithType:0];
    checkBtn1.frame=CGRectMake(8, 10, 40, 30);
    checkBtn1.layer.borderWidth=1;
    checkBtn1.layer.borderColor=hui8Cg;
    checkBtn1.layer.cornerRadius = 4;
    checkBtn1.titleLabel.font=[UIFont systemFontOfSize:10];
//    [checkBtn1 setImage:BundleImage(@"ic_01_n_.png") forState:0];
    [checkBtn1 setTitle:@"删除" forState:0];
    [checkBtn1 setTitleColor:[UIColor grayColor] forState:0];
    [checkBtn1 addTarget:self action:@selector(deleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    [view_toolBar addSubview:checkBtn1];
   
    UIButton *checkBtnAll=[UIButton buttonWithType:0];
    checkBtnAll.frame=CGRectMake(checkBtn1.frame.size.width+checkBtn1.frame.origin.x+10, 10, 40, 30);
    checkBtnAll.layer.borderWidth=1;
    checkBtnAll.layer.borderColor=hui8Cg;
    checkBtnAll.layer.cornerRadius = 4;
    checkBtnAll.titleLabel.font=[UIFont systemFontOfSize:10];
    //    [checkBtn1 setImage:BundleImage(@"ic_01_n_.png") forState:0];
    [checkBtnAll setTitle:@"全选" forState:0];
    [checkBtnAll setTitleColor:[UIColor grayColor] forState:0];
    [checkBtnAll addTarget:self action:@selector(btnSelecdAll:) forControlEvents:UIControlEventTouchUpInside];
    [view_toolBar addSubview:checkBtnAll];
    
    UILabel *title_label=[[UILabel alloc]initWithFrame:CGRectMake(checkBtnAll.frame.size.width+checkBtnAll.frame.origin.x+10, 15, 38, 20)];
    title_label.text=@"合计:";
    title_label.font=[UIFont boldSystemFontOfSize:16];
    title_label.backgroundColor=[UIColor clearColor];
    title_label.textColor =hongShe;
    title_label.textAlignment=1;
    [view_toolBar addSubview:title_label];

    UILabel *price_label=[[UILabel alloc]initWithFrame:CGRectMake(title_label.frame.size.width+title_label.frame.origin.x+10, 15, 60, 20)];
    price_label.tag=-101;
    price_label.text=[NSString stringWithFormat:@"￥%.2f",_price];
    price_label.font=[UIFont boldSystemFontOfSize:16];
    price_label.backgroundColor=[UIColor clearColor];
    price_label.textColor =hongShe;
    price_label.textAlignment=0;
    [view_toolBar addSubview:price_label];
    
    UIButton *acountBtn1=[UIButton buttonWithType:0];
    acountBtn1.frame=CGRectMake(view_toolBar.frame.size.width-95, 10, 85, 30);
    acountBtn1.titleLabel.font=[UIFont systemFontOfSize:10];
    [acountBtn1 setImage:BundleImage(@"ic_02_n_.png") forState:0];
    [acountBtn1 setTitleColor:[UIColor grayColor] forState:0];
    [acountBtn1 addTarget:self action:@selector(accountBtn:) forControlEvents:UIControlEventTouchUpInside];
    [view_toolBar addSubview:acountBtn1];
    
    return view_toolBar;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrayPrice.count;
}

- (FCShoppingCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cate_cell";
    
    FCShoppingCell*   cell =nil;
    
    if (cell == nil) {
        
        cell = [[[FCShoppingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.editingAccessoryType=UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType=UITableViewCellAccessoryNone;
        cell.selected=NO;
        cell.tag=1000+indexPath.row;
        
  
        cell.isTouch=NO;
        
        UIView *_view1=[[UIView alloc] initWithFrame:CGRectMake(10, 10, 300, 128)];
        
        [_view1 addSubview:[[UIImageView alloc]initWithImage:BundleImage(@"gwc_bg_02_.png")]];
        [cell addSubview:_view1];

        
        
        //checkbox@2x
        UIImageView *checkBtn=[[UIImageView alloc]init];
        checkBtn.frame=CGRectMake(0, 3, 40, 40);
        checkBtn.tag=100+indexPath.row;
        checkBtn.image=BundleImage(@"ic_01_n_.png");
        [_view1 addSubview:checkBtn];
        
         [_checkBtnArray addObject:checkBtn];

        
        
        for (NSIndexPath *path in deleteArray) {
            
            NSLog(@"%d",path.row);
            if (checkBtn.tag==path.row+100) {
                
                checkBtn.image= BundleImage(@"ic_01_h_.png");
                
            }
            
        }

        //checkbox@2x
        //按钮
        //减
        UIButton *btnCut=[UIButton buttonWithType:0];
        btnCut.frame=CGRectMake(150, 7, 35, 35);
        btnCut.tag=indexPath.row;
        [btnCut setImage:BundleImage(@"bt_01_.png") forState:0];
        [btnCut addTarget:self action:@selector(btnCut:) forControlEvents:UIControlEventTouchUpInside];
        
        [_view1 addSubview:btnCut];
        
        UITextField*  numTextField=[[UITextField alloc]initWithFrame:CGRectMake(btnCut.frame.size.width+btnCut.frame.origin.x+1, btnCut.frame.origin.y+3,59,28)];
        numTextField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
        numTextField.textAlignment=1;
        numTextField.delegate=self;
        numTextField.returnKeyType=UIReturnKeyDone;
        numTextField.text=@"1";
        numTextField.contentVerticalAlignment=0;
        numTextField.textColor=[UIColor colorWithRed:.2 green:.2 blue:.2 alpha:1.0];
        numTextField.tag=100000+indexPath.row;
        numTextField.keyboardType=UIKeyboardTypeDefault;
        numTextField.userInteractionEnabled=YES;
        //        numTextField.background=BundleImage(@"number_frame.png");
        numTextField.layer.borderColor=[UIColor colorWithRed:.8 green:.8 blue:.8 alpha:1.0].CGColor;
        numTextField.layer.borderWidth=1;
        numTextField.backgroundColor=[UIColor whiteColor];
        [numTextField addTarget:self action:@selector(textFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
        [numTextField addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
        [_view1 addSubview:numTextField];
        [numTextField release];
        
        //加
        UIButton *btnAdd=[UIButton buttonWithType:0];
        btnAdd.frame=CGRectMake(numTextField.frame.origin.x+numTextField.frame.size.width+3,btnCut.frame.origin.y+3, 30, 28);
        [btnAdd setBackgroundImage:BundleImage(@"bt_02_.png") forState:0];
        [btnAdd addTarget:self action:@selector(btnAdd:) forControlEvents:UIControlEventTouchUpInside];
        if (btnAdd.highlighted) {
            [btnAdd setBackgroundImage:BundleImage(@"number_up_click.png") forState:0];
        }
        btnAdd.tag=indexPath.row;
        [_view1 addSubview:btnAdd];
    
        
        //图片
        //
        // NSString*_url=[NSString stringWithFormat:@"%@/%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"currentUrl"],[[[[_marrayAll objectAtIndex:indexPath.row]productList]objectAtIndex:0] icon]];
        UIImageView *backImg=[[UIImageView alloc]initWithFrame:CGRectMake(10, checkBtn.frame.size.height+checkBtn.frame.origin.y+15, 62,62)];
        backImg.layer.masksToBounds=YES;
        backImg.layer.borderWidth=1;
        backImg.layer.cornerRadius = 4;
        backImg.layer.borderColor=[UIColor colorWithRed:.8 green:.8 blue:.8 alpha:1.0].CGColor;
        backImg.backgroundColor=[UIColor whiteColor];
        [_view1 addSubview:backImg];
        UrlImageView*imgView=[[UrlImageView alloc]initWithFrame:CGRectMake(3, 3, 56,56)];
        
        //        if ([[[[_marrayAll objectAtIndex:indexPath.row]productList]objectAtIndex:0] icon]==nil)
        //        {
        imgView.image=[UIImage imageNamed:@"df_01_.png"];
        //        }else
        //        {
        //            [imgView setImageWithURL:[NSURL URLWithString:_url]];
        //
        //        }
        
        [backImg addSubview:imgView];
        
        //title
        UILabel*title=[[UILabel alloc]initWithFrame:CGRectMake(backImg.frame.origin.x+backImg.frame.size.width+10, backImg.frame.origin.y, 210, 20)];
        title.backgroundColor=[UIColor clearColor];
        title.textAlignment=0;
        title.text=@"小清新小清新";
        title.textColor=[UIColor colorWithRed:.2 green:.2 blue:.2 alpha:1.0];
        title.font=[UIFont systemFontOfSize:14];
        [_view1 addSubview:title];
        
        
        //颜色
        UILabel*labelColor=[[UILabel alloc]initWithFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+title.frame.size.height, 105, 20)];
        labelColor.textAlignment=0;
        labelColor.font=[UIFont systemFontOfSize:12];
        labelColor.textColor=[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
        labelColor.text=[NSString stringWithFormat:@"颜色:%@",@"绿色"];
        labelColor.backgroundColor=[UIColor clearColor];
        [_view1 addSubview:labelColor];
        //尺码
        UILabel*labelRuler=[[UILabel alloc]initWithFrame:CGRectMake(labelColor.frame.origin.x+labelColor.frame.size.width, title.frame.origin.y+title.frame.size.height, 100, 20)];
        labelRuler.textAlignment=0;
        labelRuler.font=[UIFont systemFontOfSize:12];
        labelRuler.textColor=[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
        labelRuler.text=[NSString stringWithFormat:@"尺码:%@",@"S码"];
        labelRuler.backgroundColor=[UIColor clearColor];
        [_view1 addSubview:labelRuler];
        // 单价
        UILabel*labelPrice=[[UILabel alloc]initWithFrame:CGRectMake(labelColor.frame.origin.x, labelColor.frame.origin.y+labelColor.frame.size.height, 35, 20)];
        labelPrice.textAlignment=0;
        labelPrice.font=[UIFont systemFontOfSize:12];
        labelPrice.textColor=[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
        //        NSArray *arr=[NSArray arrayWithArray:_arrayPrice];
        labelPrice.text=[NSString stringWithFormat:@"单价:¥"];
        labelPrice.backgroundColor=[UIColor clearColor];
        [_view1 addSubview:labelPrice];

        
        
        UILabel*labelPrice1=[[UILabel alloc]initWithFrame:CGRectMake(labelPrice.frame.origin.x+labelPrice.frame.size.width, labelPrice.frame.origin.y,70, 20)];
        labelPrice1.textAlignment=0;
        labelPrice1.tag=10000000+indexPath.row;
        labelPrice1.font=[UIFont systemFontOfSize:12];
        labelPrice1.textColor=[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
//        NSArray *arr=[NSArray arrayWithArray:_arrayPrice];
        labelPrice1.text=[NSString stringWithFormat:@"%.2f",[[_arrayPrice objectAtIndex:indexPath.row]floatValue]];
        labelPrice1.backgroundColor=[UIColor clearColor];
        [_view1 addSubview:labelPrice1];
        
        
       
        UILabel*labelPrice3=[[UILabel alloc]initWithFrame:CGRectMake(labelPrice1.frame.origin.x+labelPrice1.frame.size.width, labelPrice1.frame.origin.y, 35, 20)];
        labelPrice3.textAlignment=0;
        labelPrice3.font=[UIFont systemFontOfSize:12];
        labelPrice3.textColor=[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
        //        NSArray *arr=[NSArray arrayWithArray:_arrayPrice];
        labelPrice3.text=[NSString stringWithFormat:@"总价:¥"];
        labelPrice3.backgroundColor=[UIColor clearColor];
        [_view1 addSubview:labelPrice3];
        
        //总价
        
        UILabel*labelPrice4=[[UILabel alloc]initWithFrame:CGRectMake(labelPrice3.frame.origin.x+labelPrice3.frame.size.width, labelPrice3.frame.origin.y, 70, 20)];
        labelPrice4.textAlignment=0;
        labelPrice4.tag=11000000+indexPath.row;
        labelPrice4.font=[UIFont systemFontOfSize:12];
        labelPrice4.textColor=[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
        //        NSArray *arr=[NSArray arrayWithArray:_arrayPrice];
        labelPrice4.text=[NSString stringWithFormat:@"%.2f",[[_arrayPrice objectAtIndex:indexPath.row]floatValue]];
        labelPrice4.backgroundColor=[UIColor clearColor];
        [_view1 addSubview:labelPrice4];
        
        //        [labelPrice release];
        CGRect cellFrame = [cell frame];
        cellFrame.origin=CGPointMake(5, 5);
        cellFrame.size.width=320;
        cellFrame.size.height=imgView.frame.size.height+10;
        [cell setFrame:cellFrame];
        [imgView release];
    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIImageView*btn=(UIImageView*)[tableView viewWithTag:100+indexPath.row];
    NSIndexPath*path=[NSIndexPath indexPathForRow:btn.tag-100 inSection:0];
    FCShoppingCell*cell=(FCShoppingCell*)[tableView viewWithTag:indexPath.row+1000];
    
    if (cell.isTouch==NO)
    {
        btn.image= BundleImage(@"ic_01_h_.png") ;
        [deleteArray addObject:path];
        cell.isTouch=YES;
        
    }else{
        
        btn.image=BundleImage(@"ic_01_n_.png");

        [deleteArray removeObject:path];
        cell.isTouch=NO;
    }

    float _p=0;
    
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    NSMutableArray* tempArray2 = [[NSMutableArray alloc] init];
    
    for(NSIndexPath *path in deleteArray)
    {

        [indexSet addIndex:[path row]];//添加指定单元行的下标
        UILabel *label=(UILabel*)[self.view viewWithTag:[path row]+11000000];
        [tempArray2 addObject:label.text ];
        
    }
    

    
    for (int i =0; i<tempArray2.count; i++)
    {
        _p=[[tempArray2 objectAtIndex:i] floatValue]+_p;
        
    }

    _price=_p;
    UILabel *labelPriceSum=(UILabel*)[self.view viewWithTag:-101];
    labelPriceSum.text=[NSString stringWithFormat:@"%.2f",_price];

    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return 140;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}
#pragma mark keyboard methods

- (void)keyboardWillShow:(NSNotification *)notification
{
    //    if ([_confirmPwdTextfield isFirstResponder]) {
    NSTimeInterval animationDuration = 0.30f;
    CGRect frame = self.view.frame;
    frame.origin.y = -160;
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = frame;
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    NSTimeInterval animationDuration = 0.30f;
    CGRect frame = self.view.frame;
    frame.origin.y = 0;
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = frame;
    [UIView commitAnimations];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    UITextField*field;
    
    for (int i=0; i<[_arrayPrice count]; i++)
    {
        field=(UITextField*)[self.view viewWithTag:100000+i];
        UILabel*label=(UILabel*)[self.view viewWithTag:10000000+i];
        
        if (textField.tag==field.tag)
        {
            //            [self keyboardWillShow:nil];
            
//            label.text= [NSString stringWithFormat:@"%.2f", [[_arrayPrice objectAtIndex:i]  floatValue]*[field.text floatValue]];
        }else if(textField.tag >=100003)
        {
            [self keyboardWillShow:nil];
            
        }
        
    }
    
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return [self isValidateNumber:string];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    UITextField*field;
    
    for (int i=0; i<[_arrayPrice count]; i++)
    {
        field=(UITextField*)[self.view viewWithTag:100000+i];
        UILabel*label=(UILabel*)[self.view viewWithTag:10000000+i];
        
        if (textField.tag==field.tag)
        {
//            label.text= [NSString stringWithFormat:@"%.2f", [[[_marrayAll objectAtIndex:i] price] floatValue]*[field.text floatValue]];
        }else if(textField.tag >=100001)
        {
            [self keyboardWillShow:nil];
            
        }
        
    }
    
}

#pragma mark 按钮事件
-(void)showAlertView
{
    
    [WCAlertView showAlertWithTitle:@"提示" message:@"您没有选中任何商品！" customizationBlock:^(WCAlertView *alertView) {
        alertView.style = WCAlertViewStyleWhiteHatched;
        
    } completionBlock:^(NSUInteger buttonIndex, WCAlertView *alertView) {
        if (buttonIndex == 0) {
            NSLog(@"继续购物");
        } else {
            NSLog(@"去购物车");
            
            
        }
    } cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    
}
-(void)accountBtn:(id)sender
{
    if ([deleteArray count]<=0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您没有选中任何商品！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    else {
        [arrayTextFeild removeAllObjects];
        [arrayLabel removeAllObjects];
        [_marrayProductid removeAllObjects];
        for (NSIndexPath *path in deleteArray)
        {
            UITextField *textField = (UITextField *)[self.view viewWithTag:100000+path.row];
            [arrayTextFeild addObject:textField.text];
            
            UILabel *label = (UILabel *)[self.view viewWithTag:10000000+path.row];
            [arrayLabel addObject:[label.text substringFromIndex:1]];
            
//            [_marrayProductid addObject:[[[_marrayAll objectAtIndex:path.row]productList]objectAtIndex:0]];
            
        }
        
        dic=[NSDictionary dictionaryWithObjectsAndKeys:arrayTextFeild,@"salesNum",arrayLabel,@"countPrice", nil];
        
        FCAccountViewController *VC=[[FCAccountViewController alloc]initWithProduct:[NSArray arrayWithArray:[_marrayProductid retain]]withSalesNumAndPrices:dic];
          TMAppDelegate *appDelegate = (TMAppDelegate*)[[UIApplication sharedApplication] delegate];
        
        [appDelegate.navigationController pushViewController:VC animated:YES];
    }
    
}

-(void)deleteBtn:(id)sender
{
    //删除前首先要初始化一个临时数组用来接收要删除数组对应下标的各个元素（用nsmutableindexset添加下标，最后指量删除），删除cell时cell要处于可编辑状态。最后roloadData;

    
    if ([deleteArray count]<=0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您没有选中任何商品！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定要删除选中的商品吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
        [alert show];
        alert.tag = 1000;
        [alert release];
    }
    
    
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1000)
    {
        if (buttonIndex == 1)
        {
            [self deleteColection];
        }
    }
}

-(void)deleteColection
{
    _strings=[[NSString alloc] init];
    
    for(NSIndexPath *path in deleteArray)
    {
        NSString *productids=[NSString stringWithFormat:@"%@,",[[[[_arrayPrice objectAtIndex:[path row]] productList] objectAtIndex:0] id]];
        _strings=[_strings stringByAppendingString:productids];
    }
    

}
//利用正则表达式验证
-(BOOL)isValidateNumber:(NSString *)number
{
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

- (void) textFieldBegin:(id)sender
{
    UITextField *t = (UITextField*)sender;
    NSLog(@"%i",t.tag);
    
}


- (void) textFieldDone:(id)sender
{
    
    [sender resignFirstResponder];
    [self keyboardWillHide:Nil];
}
//全选
-(void)btnSelecdAll:(id)sender
{
    
    
    if ([deleteArray count]>0)
    {
        [deleteArray removeAllObjects];
    }
    
    UIImageView*imageView;
    _isPOP=NO;
    if (_isSelecedAll==NO)
    {
        for (int i=0; i<5; i++)
        {
            imageView=(UIImageView*)[self.view viewWithTag:i+100];
            imageView.image=BundleImage(@"ic_01_h_.png");
            NSIndexPath*path=[NSIndexPath indexPathForRow:i inSection:0];
            [deleteArray addObject:path];
            
        }
        _isSelecedAll=YES;
        _isPOP=YES;
    }else{
        
        for (int i=0; i<5; i++)
        {
            
            imageView=(UIImageView*)[self.view viewWithTag:i+100];
            imageView.image=BundleImage(@"ic_01_n_.png");;
        }
        [deleteArray removeAllObjects];
        _isSelecedAll=NO;
        
    }
    
}
#pragma mark多选

//两个按钮 是同时对一个textfiled操作，所以把tag设为同样的。
//最小为1
-(void)btnCut:(id)sender
{
    UIButton*btn=(UIButton*)sender;
    UITextField*field=(UITextField* )[self.view viewWithTag:100000+btn.tag ];
    UILabel*label=(UILabel*)[self.view viewWithTag:10000000+btn.tag];
    UILabel*label1=(UILabel*)[self.view viewWithTag:11000000+btn.tag];
  
    if ([field.text intValue]>1) {
        field.text=[NSString stringWithFormat:@"%d",[field.text intValue]-1];
          }
 
    label1.text= [NSString stringWithFormat:@"%.2f", [[_arrayPrice objectAtIndex:btn.tag] floatValue]*[field.text floatValue]];
  
    float _p=0;
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    NSMutableArray* tempArray2 = [[NSMutableArray alloc] init];
    
    for(NSIndexPath *path in deleteArray)
    {
        [indexSet addIndex:[path row]];//添加指定单元行的下标
        UILabel *label=(UILabel*)[self.view viewWithTag:[path row]+11000000];
        [tempArray2 addObject:label.text ];
        
    }
    
    
    for (int i =0; i<tempArray2.count; i++)
    {
        _p=[[tempArray2 objectAtIndex:i] floatValue]+_p;
        
    }
  
    _price=_p;


  

    UILabel *labelPriceSum=(UILabel*)[self.view viewWithTag:-101];
    labelPriceSum.text=[NSString stringWithFormat:@"%.2f",_price];

}

//加
-(void)btnAdd:(id)sender
{
    
    UIButton*btn=(UIButton*)sender;
    UITextField*field=(UITextField* )[self.view viewWithTag:100000+btn.tag ];
    field.text=[NSString stringWithFormat:@"%d",[field.text intValue]+1];
//    UILabel*label=(UILabel*)[self.view viewWithTag:10000000+btn.tag];
     UILabel*label1=(UILabel*)[self.view viewWithTag:11000000+btn.tag];
    label1.text= [NSString stringWithFormat:@"%.2f", [[_arrayPrice objectAtIndex:btn.tag] floatValue]*[field.text floatValue]];
    NSLog(@"%@",deleteArray);
    
    float _p=0;
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    NSMutableArray* tempArray2 = [[NSMutableArray alloc] init];

            for(NSIndexPath *path in deleteArray)
            {
                [indexSet addIndex:[path row]];//添加指定单元行的下标
                UILabel *label=(UILabel*)[self.view viewWithTag:[path row]+11000000];
                [tempArray2 addObject:label.text ];

            }
    
    
    for (int i =0; i<tempArray2.count; i++)
    {
        _p=[[tempArray2 objectAtIndex:i] floatValue]+_p;
    
    }
//     NSLog(@"%f",_p);
    _price=_p;
    UILabel *labelPriceSum=(UILabel*)[self.view viewWithTag:-101];
    labelPriceSum.text=[NSString stringWithFormat:@"%.2f",_price];


    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
