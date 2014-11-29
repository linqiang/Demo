//
//  AMRatingControl.h
//  RatingControl
//


#import <UIKit/UIKit.h>


@interface AMRatingControl : UIControl
{
	UIImage *_emptyImage, *_solidImage;
    CGColorRef _emptyColor, _solidColor;
    NSInteger _maxRating;
    CGFloat _fontSize;
    NSInteger _starWidth;
    BOOL _isTouch;

}


/**************************************************************************************************/
#pragma mark - Getters and Setters

@property (nonatomic, assign) NSInteger rating;


/**************************************************************************************************/
#pragma mark - Birth & Death

/**
 * @param location : position of the rating control in your view
 * The control will manage its own width/height (kind of like UIActivityIndicator)
 * @param maxRating
 */
- (id)initWithLocation:(CGPoint)location andMaxRating:(NSInteger)maxRating;

/**
 * @param location : position of the rating control in your view
 * The control will manage its own width/height (kind of like UIActivityIndicator)
 * @param emptyColor & solidColor
 * @param maxRating
 */
- (id)initWithLocation:(CGPoint)location
            emptyColor:(CGColorRef )emptyColor
            solidColor:(CGColorRef )solidColor
          andMaxRating:(NSInteger)maxRating
           andFontSize:(CGFloat)fontSize
         andStartWidth:(NSInteger)width
               isTouch:(BOOL)isTouch
;

/**
 * @param location : position of the rating control in your view
 * The control will manage its own width/height (kind of like UIActivityIndicator)
 * @param emptyImage & solidImage can both be nil, or not even a dot or a star (a any images you want!)
 * If either of these parameters are nil, the class will draw its own stars
 * @param maxRating
 */
- (id)initWithLocation:(CGPoint)location
            emptyImage:(UIImage *)emptyImageOrNil
            solidImage:(UIImage *)solidImageOrNil
          andMaxRating:(NSInteger)maxRating
           andFontSize:(CGFloat)fontSize
         andStartWidth:(NSInteger)width
               isTouch:(BOOL)isTouch;


@end
