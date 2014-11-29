//
//  LTKSeachViewController.h
//  LvTongKa
//
//  Created by 123 on 13-8-27.

//

#import "LTKViewController.h"

@interface LTKSeachViewController : LTKViewController<UIScrollViewDelegate,UITextFieldDelegate,EScrollerViewDelegate>
{
    UITextField                     *seachField;//搜索内容
    UIScrollView                    *_scrollView;
    NSArray                     *_array;

    NSString                        *_keyWord;
    NSMutableArray                      *_marrayHotKeyWords;
    UILabel                     *hotLabel;
    UIButton                    *button;
    UIView                  *view_bar;
    UIView                  *seachBar;
    UrlImageButton              *fourBtn;
    UILabel                 *fourLab;
    UIButton*BtnItem1,*BtnItem2;
    UIImageView *tabBarArrow;
    UIImageView* imageViewToolBar;
    
}
@property(nonatomic,retain)NSMutableArray *_scrol_marray;//焦点数组
@property(nonatomic,strong)UISearchBar*searchBar;
@property(nonatomic,strong)UISearchDisplayController*strongSearchDisplayController;

-(id)initSeachKeyWord:(NSString*)keyWord;


@end
