//
//  URBAlertView.h
//  URBFlipModalViewControllerDemo
//
//  Created by Nicholas Shipes on 12/21/12.
//  Copyright (c) 2012 Urban10 Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

enum {
	URBAlertAnimationDefault = 0,
	URBAlertAnimationFade,
	URBAlertAnimationFlipHorizontal,
	URBAlertAnimationFlipVertical,
	URBAlertAnimationTumble,
	URBAlertAnimationSlideLeft,
	URBAlertAnimationSlideRight
};
typedef NSInteger URBAlertAnimation;

@interface URBAlertView : UIView

typedef void (^URBAlertViewBlock)(NSInteger buttonIndex, URBAlertView *alertView);

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, assign) BOOL darkenBackground;
@property (nonatomic, assign) BOOL blurBackground;

+ (URBAlertView *)dialogWithTitle:(NSString *)title subtitle:(NSString *)subtitle;

- (id)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle;

- (NSInteger)addButtonWithTitle:(NSString *)title;
- (void)setHandlerBlock:(URBAlertViewBlock)block;

- (void)show;
- (void)showWithCompletionBlock:(void(^)())completion;
- (void)showWithAnimation:(URBAlertAnimation)animation;
- (void)showWithAnimation:(URBAlertAnimation)animation completionBlock:(void(^)())completion;

- (void)hide;
- (void)hideWithCompletionBlock:(void(^)())completion;
- (void)hideWithAnimation:(URBAlertAnimation)animation;
- (void)hideWithAnimation:(URBAlertAnimation)animation completionBlock:(void(^)())completion;

@end
