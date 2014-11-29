//
//  firstLevelMenu.m
//  testDoubleMenu
//
//  Created by Skyler on 13-9-5.
//  Copyright (c) 2013年 SK. All rights reserved.
//

#import "secondLevelMenu.h"

@implementation secondLevelMenu

@synthesize smenuDelegate;

- (id)initWithFrame:(CGRect)frame Contents:(NSArray *)Contents addWithClassicID:(NSString*)classID
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
//        _class_id=[[NSString alloc]initWithString:classID];
        
        NSString *parmeters1=[NSString stringWithFormat:@"categoryId=%@",classID];
//        [[RequestServer instance] doActionAsync:0 withAction:@"/mobile/commodity/page?" withParameters:parmeters1 withDelegate:self];
        marrayall=[[NSMutableDictionary alloc]init];
        

    }
    return self;
}

-(void)requestFinished:(NSNumber *)code withMessage:(NSString *)message withData:(id)data
{
    
//    if ((int)code==1) {
        marrayall=data;
        NSLog(@"%@",data);
        UrlImageButton *btnTow;
        self.showsVerticalScrollIndicator = NO;
    
        for (int i =0; i<2; i++)
        {

            btnTow=[[UrlImageButton alloc]initWithFrame:CGRectMake((i%2)*115+10, floor(i/2)*82+10,105, 70)];

            NSString *imagePath;
            NSURL *url;
            if ([marrayall  objectForKey:@"rows"]!=nil)
            {
                imagePath = [[[[marrayall  objectForKey:@"rows"] objectAtIndex:i] objectForKey:@"icons"] objectAtIndex:0];
                url=[NSURL URLWithString:[NSString stringWithFormat:@"%@/mobile/image/download/%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"current_imgUrl"],imagePath]];
                [btnTow setImageWithURL:url];
            }else{
                [btnTow setImage:[UIImage imageNamed:@"df_02_.png"] forState:0];

                
            }


            btnTow.backgroundColor=[UIColor whiteColor];
            btnTow.tag=i+1000;
            btnTow.layer.masksToBounds=YES;
            btnTow.layer.borderWidth=1;
            btnTow.layer.cornerRadius = 4;
            btnTow.layer.borderColor = [[UIColor colorWithRed:.8 green:.8 blue:.8 alpha:1.0] CGColor];
            [btnTow addTarget:self action:@selector(btnNine:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btnTow];
            
        }
        
        for (int i =0; i<marrayall.count; i++){
            
            UrlImageButton *btnNine=[[UrlImageButton alloc]initWithFrame:CGRectMake((i%3)*(320-80-10)/3+10, floor(i/3)*(320-80-10)/3+90, (320-80-30-10)/3, (320-80-30-10)/3)];
            btnNine.backgroundColor=[UIColor whiteColor];
            
            NSString *imagePath = [[[[marrayall  objectForKey:@"rows"] objectAtIndex:i] objectForKey:@"icons"] objectAtIndex:0];
            NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@/mobile/image/download/%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"current_imgUrl"],imagePath]];
            if (imagePath == nil)
            {
                [btnNine setImage:[UIImage imageNamed:@"df_01_.png"] forState:0];
            }else{
                [btnNine setImageWithURL:url];
                
            }
            btnNine.tag=i+1000;
            btnNine.layer.masksToBounds=YES;
            btnNine.layer.borderWidth=1;
            btnNine.layer.cornerRadius = 4;
            btnNine.layer.borderColor = [[UIColor colorWithRed:.8 green:.8 blue:.8 alpha:1.0] CGColor];
            [btnNine addTarget:self action:@selector(btnNine:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btnNine];
            
        
            UILabel *title_label=[[UILabel alloc]initWithFrame:CGRectMake((i%3)*(320-80-10)/3+10, floor(i/3)*(320-80-10)/3+90+(320-80-30-10)/3, (320-80-30-10)/3, 10)];
            
            title_label.font=[UIFont boldSystemFontOfSize:9];
            title_label.backgroundColor=[UIColor clearColor];
            title_label.textColor =[UIColor colorWithRed:.5 green:.5 blue:.5 alpha:1.0];
            title_label.textAlignment=1;
            title_label.text=[[[marrayall  objectForKey:@"rows"] objectAtIndex:i] objectForKey:@"name"] ;
            
            [self addSubview:title_label];
            
            
        }

    
}
-(void)btnNine:(id)sender
{
    UIButton *btn=(UIButton*)sender;

//    if ([arrContent count]>0)
//    {
        [self.smenuDelegate secondLevelMenuselectTheSpecificRow:btn.tag-100000 addName:[arrContent objectAtIndex:btn.tag-100000]];
        
//    }

}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
