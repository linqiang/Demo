//
//  TMAddAddressViewController.h
//  TaoMao
//
//  Created by mac on 14-4-22.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZAreaPickerView.h"

@interface TMAddAddressViewController : UIViewController<UITextFieldDelegate,HZAreaPickerDelegate>
{
    UIView* view_bar;
    UITextField *fieldXM,*fieldSJ,*fieldYB,*fieldDQ,*fieldJD;
    BOOL                    dataPickIsShow;
    
    int    textFieldTag;
}
@property (strong, nonatomic) HZAreaPickerView *locatePicker;
@property (strong, nonatomic) NSString *ProvinceValue, *cityValue,*streetValus,*areaValue;

@end
