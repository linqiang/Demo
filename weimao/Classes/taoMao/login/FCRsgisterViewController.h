//
//  FCRsgisterViewController.h
//  Flower&Cake
//
//

#import "LTKViewController.h"

@interface FCRsgisterViewController : LTKViewController<UITextFieldDelegate>
{
    NSMutableArray                 *_array;
    NSString                    *_url;
    UITextField                    *fieldCheck;
    NSData                  *responseData;
    UIImage                 *_image;
    UIImageView                 *checkImage;
    UIImageView                 *imageView;
    UITextField                 *field;
    UILabel                     *label;
    UIView                      *view_bar;
}

@end
