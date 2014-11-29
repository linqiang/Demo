//
//  FPTouchView.h
//
//  .
//  Copyright (c) 2012 Fifty Pixels Ltd. All rights reserved.
//
//   

#import <UIKit/UIKit.h>

typedef void (^FPTouchedOutsideBlock)();
typedef void (^FPTouchedInsideBlock)();

@interface FPTouchView : UIView
{
    FPTouchedOutsideBlock _outsideBlock;
    FPTouchedInsideBlock  _insideBlock;
}

-(void)setTouchedOutsideBlock:(FPTouchedOutsideBlock)outsideBlock;

-(void)setTouchedInsideBlock:(FPTouchedInsideBlock)insideBlock;

@end
