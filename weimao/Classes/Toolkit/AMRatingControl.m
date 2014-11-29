//
//  AMRatingControl.m
//  RatingControl
//


#import "AMRatingControl.h"


// Constants :
//static const CGFloat kFontSize = 20;
//static const NSInteger kStarWidthAndHeight = 20;
static const NSString *kDefaultEmptyChar = @"☆";
static const NSString *kDefaultSolidChar = @"★";
@interface AMRatingControl (Private)

- (id)initWithLocation:(CGPoint)location
            emptyImage:(UIImage *)emptyImageOrNil
            solidImage:(UIImage *)solidImageOrNil
            emptyColor:(CGColorRef )emptyColor
            solidColor:(CGColorRef )solidColor
          andMaxRating:(NSInteger)maxRating;

@end


@implementation AMRatingControl


/**************************************************************************************************/
#pragma mark - Getters & Setters

@synthesize rating = _rating;
- (void)setRating:(NSInteger)rating
{
    _rating = (rating < 0) ? 0 : rating;
    _rating = (rating > _maxRating) ? _maxRating : rating;
    [self setNeedsDisplay];
}


/**************************************************************************************************/
#pragma mark - Birth & Death
//-(CGFloat)setFontSize:(CGFloat)kFontSize
//{
//    _fontSize=kFontSize;
//    return _fontSize;
//}
//-(NSInteger)setStarWidth:(NSInteger)kStarWidthAndHeight
//{
//    _starWidth=kStarWidthAndHeight;
//    return _starWidth;
//}
- (id)initWithLocation:(CGPoint)location andMaxRating:(NSInteger)maxRating
{
    return [self initWithLocation:location
                       emptyImage:nil
                       solidImage:nil
                       emptyColor:nil
                       solidColor:nil
                     andMaxRating:maxRating
            ];
}

- (id)initWithLocation:(CGPoint)location
            emptyImage:(UIImage *)emptyImageOrNil
            solidImage:(UIImage *)solidImageOrNil
          andMaxRating:(NSInteger)maxRating
         andFontSize:(CGFloat)fontSize
         andStartWidth:(NSInteger)width
               isTouch:(BOOL)isTouch

{
    _starWidth=width;
    _fontSize=fontSize;
    _emptyImage=emptyImageOrNil;
    _solidImage=solidImageOrNil;
	return [self initWithLocation:location
                       emptyImage:emptyImageOrNil
                       solidImage:solidImageOrNil
                       emptyColor:nil
                       solidColor:nil
                     andMaxRating:maxRating
            ];
}

- (id)initWithLocation:(CGPoint)location
            emptyColor:(CGColorRef )emptyColor
            solidColor:(CGColorRef )solidColor
          andMaxRating:(NSInteger)maxRating
           andFontSize:(CGFloat)fontSize
         andStartWidth:(NSInteger)width
               isTouch:(BOOL)isTouch
{

    _emptyColor=emptyColor;
    _solidColor=solidColor;
    _fontSize=fontSize;
    _starWidth=width;
    _isTouch=isTouch;
    return [self initWithLocation:location
                       emptyImage:nil
                       solidImage:nil
                       emptyColor:_emptyColor
                       solidColor:_solidColor
                     andMaxRating:maxRating
            ];
}

- (void)dealloc
{
	_emptyImage = nil,
	_solidImage = nil;
    _emptyColor = nil;
    _solidColor = nil;
    [super dealloc];
}


/**************************************************************************************************/
#pragma mark - View Lifecycle

- (void)drawRect:(CGRect)rect
{

	CGPoint currPoint = CGPointZero;
	
	for (int i = 0; i < _rating; i++)
	{
		if (_solidImage)
        {
            [_solidImage drawAtPoint:currPoint];
        }
		else
        {

            CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), _solidColor);
            [kDefaultSolidChar drawAtPoint:currPoint withFont:[UIFont boldSystemFontOfSize:_fontSize]];
        }
			
		currPoint.x += _starWidth;
	}
	
	NSInteger remaining = _maxRating - _rating;
	
	for (int i = 0; i < remaining; i++)
	{
		if (_emptyImage)
        {
			[_emptyImage drawAtPoint:currPoint];
        }
		else
        {
            CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), _emptyColor);
			[kDefaultEmptyChar drawAtPoint:currPoint withFont:[UIFont boldSystemFontOfSize:_fontSize]];
        }
		currPoint.x += _starWidth;
	}
}


/**************************************************************************************************/
#pragma mark - UIControl

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self handleTouch:touch ];

	return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event 
{
    [self handleTouch:touch];
    
	return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self sendActionsForControlEvents:UIControlEventEditingDidEnd];
}


/**************************************************************************************************/
#pragma mark - Private Methods

- (id)initWithLocation:(CGPoint)location
            emptyImage:(UIImage *)emptyImageOrNil
            solidImage:(UIImage *)solidImageOrNil
            emptyColor:(CGColorRef )emptyColor
            solidColor:(CGColorRef)solidColor
          andMaxRating:(NSInteger)maxRating
{
    if (self = [self initWithFrame:CGRectMake(location.x,
                                              location.y,
                                              (maxRating * _starWidth),
                                              _starWidth)])
	{
		_rating = 0;
		self.backgroundColor = [UIColor clearColor];
		self.opaque = YES;
		
		_emptyImage = emptyImageOrNil;
		_solidImage =  solidImageOrNil;
        _emptyColor =emptyColor;
        _solidColor = solidColor;
        _maxRating = maxRating;
	}
	
	return self;
}

- (void)handleTouch:(UITouch *)touch
{
    if (_isTouch==YES) {

        CGFloat width = self.frame.size.width;
        CGRect section = CGRectMake(0, 0, (width / _maxRating), self.frame.size.height);

        CGPoint touchLocation = [touch locationInView:self];

        if (touchLocation.x < 0)
            {
            if (_rating != 0)
                {
                _rating = 0;
                [self sendActionsForControlEvents:UIControlEventEditingChanged];
                }
            }
        else if (touchLocation.x > width)
            {
            if (_rating != _maxRating)
                {
                _rating = _maxRating;
                [self sendActionsForControlEvents:UIControlEventEditingChanged];
                }
            }
        else
            {
            for (int i = 0 ; i < _maxRating ; i++)
                {
                if ((touchLocation.x > section.origin.x) && (touchLocation.x < (section.origin.x + section.size.width)))
                    {
                    if (_rating != (i+1))
                        {
                        _rating = i+1;
                        [self sendActionsForControlEvents:UIControlEventEditingChanged];
                        }
                    break;
                    }
                section.origin.x += section.size.width;
                }
            }
        [self setNeedsDisplay];
        

    }

}

@end
