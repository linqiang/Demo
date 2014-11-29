//
//  FCImageTextViewController.h
//  Flower&Cake
//
//  Created by 呵呵 on 13-7-7.
//  Copyright (c) 2013年 呵呵. All rights reserved.
//


#import "FCImageTextView.h"

@interface FCImageTextViewController : LTKViewController<UIScrollViewDelegate,UIGestureRecognizerDelegate,UITextViewDelegate,UIAlertViewDelegate>
{
    UIView                  *view_bar;
    UIScrollView                    *_scrollView;
    NSMutableArray                 *arrayImages;//接口数据
    BOOL                    isFullScreen;//是否全屏
    //    UITextField                 *textFeild;
    BOOL                    isTouch;//判断是否点击，单击事件
    UrlImageView                 *imageView;
    UILabel                 *label;
    UILabel                 *priceLabel;
    UITextView                  *textView;
    NSUInteger                  pageCount;
    NSArray                 *arrayTitle;
    NSArray                 *_urlArray;
    NSString                    *_price;
    NSString                    *_expain;
    NSString                    *_productid;
    NSString                    *_memberPrice;
    NSString                    *_promptPrice;

}
@property (nonatomic, retain) FCImageTextView   *zoomScrollView;
//图片放大缩小
-(id)initWithImages:(NSArray*)urlArray
           addPrice:(NSString*)price
         addExplain:(NSString *)expain
       addProductID:(NSString*)productid
     addpromptPrice:(NSString*)promptPrice
     addmemberPrice:(NSString*)memberPrice
         addProduct:(id)product

;
@end
