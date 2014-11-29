//
//  TMDetailView.m
//  TaoMao
//
//  Created by mac on 14-4-17.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "TMDetailView.h"
#import "FCImageTextViewController.h"
#import "FCImageTextView.h"
@implementation TMDetailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
   
        for (int i=0; i<8; i++)
        {
            UrlImageButton *btnNine=[[UrlImageButton alloc]initWithFrame:CGRectMake((i%4)*(320-10)/4+10, floor(i/4)*(320-10)/4+10, (320-30-10)/4, (320-30-10)/4)];
            btnNine.backgroundColor=[UIColor whiteColor];
            [btnNine setImage:[UIImage imageNamed:@"df_01.png"] forState:0];
            btnNine.tag=i+1000;

            [btnNine addTarget:self action:@selector(btnNine:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btnNine];
            
        }
        
    }
    return self;
}
-(void)btnNine:(id)sender
{
//    UIButton *btn=(UIButton*)sender;
//  
    FCImageTextViewController *imageText=[[FCImageTextViewController alloc] init];
    TMAppDelegate *delegate=(TMAppDelegate*)[UIApplication sharedApplication].delegate;
    [delegate.navigationController presentViewController:imageText animated:YES completion:nil];
    
}


@end
