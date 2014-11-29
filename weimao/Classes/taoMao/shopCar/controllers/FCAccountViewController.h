//
//  FCAccountViewController.h
//  Flower&Cake
//
//  Created by 123 on 13-7-11.
//  Copyright (c) 2013年 . All rights reserved.
//

//#import "FCViewController.h"

@interface FCAccountViewController : LTKViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
{
    UITableView                 *_tableView;
    NSMutableArray                  *_marrayTitle;
    NSMutableArray                     *_marrayTitleDetail;
    NSString                    *_stringWish;
    NSString                    *_stringAddress;
    NSString                    *_stringFreight;
    NSString                    *_sendTime;
    NSArray                 *_arrayProduct;
    NSDictionary                    *_salesAndPrices;
    float                   priceCount;
    UILabel                 *labelTitle;
    UILabel                 *gradeLabel;
    NSString                    *_payment;
    NSString                    *_orderid;
    BOOL                    _isfirst;
    NSMutableArray                  *_marrayAll;
//    Msg_FW_Transportations_Builder*  addresses;
    NSMutableArray                  *_freightAll;
    UIView *view_bar;
    
    UITextView*  textView;
    
    UILabel *title_label1;
    
    UrlImageButton*btn2;
    UIImageView*imgv2;
    UrlImageButton*btn1;
}

-(id)initWithProduct:(NSArray*)arrayProduct withSalesNumAndPrices:(NSDictionary*)salesAndPrices;
@end
