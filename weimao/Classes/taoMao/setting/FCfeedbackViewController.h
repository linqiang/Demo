//
//  FCfeedbackViewController.h
//  FCset
//
//  Created by Skyler on 13-6-24.
//  Copyright (c) 2013年 SK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FCfeedbackViewController : LTKViewController<UITextFieldDelegate,UITextViewDelegate>
{
    UITextField * tf_LinkWay;
    UITextView * tv_FeedBackContent;
    
}

@end
