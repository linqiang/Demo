//
//  FCLoadingVIew.h
//  Flower&Cake
//
//  Created by 呵呵 on 13-7-9.
//  Copyright (c) 2013年 呵呵. All rights reserved.
//

#import "LTKView.h"

@interface FCLoadingVIew : LTKView
{

    UIImageView                 *imageView;
}
- (id)initWithFrame:(CGRect)frame addTitle:(NSString*)title;
@end
