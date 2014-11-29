#import <UIKit/UIKit.h>
#import "QBPopupMenu.h"
#import "ZSYPopoverListView.h"


@interface CustomTabBar : UITabBarController <ZSYPopoverListDatasource,ZSYPopoverListDelegate>
{
    NSMutableArray                      *buttons;
    int                     currentSelectedIndex;
    UIImageView                    *slideBg;                
    UIImageView                     * tabBarArrow;    //tabbar下面的动画线条，
    BOOL                    isFullScreen;//是否全屏
    QBPopupMenu                   *  popupMenu;
    QBPopupMenu                     *popupMenuLogin;

    BOOL                    done;
        //Timer的使用：
    NSTimer                     *connectionTimer;  //timer对象
//    id                  <FCCustomTarBarDelegate>delegate;
    UIImageView                 *_imageView5;
    BOOL _isLoading;
}
@property (nonatomic, retain) UIImageView                   * tabBarArrow;
@property (nonatomic,assign) int                    currentSelectedIndex;
@property (nonatomic,retain) NSMutableArray                     *buttons;
@property (nonatomic, retain) QBPopupMenu               *popupMenu;
@property (nonatomic, retain) QBPopupMenu               *popupMenuLogin;
//@property(nonatomic,retain)id<FCCustomTarBarDelegate>_delegate;
- (void)hideRealTabBar;
- (void)customTabBar;
- (void)selectedTab:(UIButton *)button;

@end









