#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImage (MCCategory)

/*
 * Resizes and/or rotates an image.
 */
- (UIImage*)transformWidth:(CGFloat)width height:(CGFloat)height rotate:(BOOL)rotate;
- (UIImage*)scaleToSize:(CGSize)size;
/**
 * Draws the image using content mode rules.
 */
- (void)drawInRect:(CGRect)rect contentMode:(UIViewContentMode)contentMode;

/**
 * Draws the image as a rounded rectangle.
 */
- (void)drawInRect:(CGRect)rect radius:(CGFloat)radius;
- (void)drawInRect:(CGRect)rect radius:(CGFloat)radius contentMode:(UIViewContentMode)contentMode;
//图片处理成圆角显示
- (UIImage *) roundCorners: (UIImage*) img;
@end
