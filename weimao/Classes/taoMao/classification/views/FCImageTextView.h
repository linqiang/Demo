//
//  JUMapView.h
//  JiangnanUniversity
//
//  Created by on 13-5-7.
//  Copyright (c) 2013年  All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FCImageTextView : UIScrollView<UIScrollViewDelegate>
{

    UrlImageView *imageView;

}
@property (nonatomic, retain) UrlImageView *imageView;

@end
