//
//  FCLoadingVIew.m
//  Flower&Cake
//
//  Created by 呵呵 on 13-7-9.
//  Copyright (c) 2013年 呵呵. All rights reserved.
//

#import "FCLoadingVIew.h"

@implementation FCLoadingVIew

- (void)dealloc
{
    [imageView release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame  addTitle:(NSString *)title
{
    self = [super initWithFrame:frame ];
    if (self) {
        // Initialization code
        self.frame=CGRectMake(0, 0,320, 320);
        self.backgroundColor=[UIColor blackColor];
        self.alpha=0.3;
        UILabel*titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 10, self.frame.size.width, 25)];
        titleLabel.text= [NSString stringWithFormat:@"%@",title] ;
        titleLabel.textAlignment=1;
        titleLabel.font=[UIFont systemFontOfSize:24];
        titleLabel.backgroundColor=[UIColor clearColor];
        titleLabel.textColor=[UIColor whiteColor];
        [self addSubview:titleLabel];

        imageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, titleLabel.frame.origin.y+titleLabel.frame.size.height+10, 26,27)];
        NSArray*imgArray=[[NSArray alloc]initWithObjects:@"loading_animation1.png", @"loading_animation2.png",@"loading_animation3.png",@"loading_animation4.png",@"loading_animation5.png",@"loading_animation6.png",nil];
        imageView.animationImages=imgArray;
        imageView.animationDuration=1.0;
        imageView.animationRepeatCount=6;
        [self addSubview:imageView];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(20+26+2, (27-20)/2+imageView.frame.origin.y, self.frame.size.width-20-26-4, 20)];
        label.text=@"正在加载中，请稍后...";
        label.textAlignment=0;
        label.textColor=[UIColor whiteColor];
        label.font=[UIFont systemFontOfSize:14];
        label.backgroundColor=[UIColor clearColor];
        [self addSubview:label];
        [label release];
        [titleLabel release];
        [imgArray release];
    }
    return self;
}

-(void)stopLoading
{
    imageView.animationDuration=1.0;
    imageView.animationRepeatCount=6;
    [imageView startAnimating];
}
-(void)showLoading
{
    [imageView stopAnimating];
    [self removeFromSuperview];


}
@end
