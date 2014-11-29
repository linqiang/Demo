//
//  LTKSeachResultViewController.h
//  LvTongKa
//
//  Created by 123 on 13-8-27.

//

#import "LTKViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "EGORefreshTableFooterView.h"
#import "TMBabyListView.h"
#import "TMStoreListView.h"

@interface LTKSeachResultViewController : LTKViewController<UISearchBarDelegate, UISearchDisplayDelegate,UIScrollViewDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,EGORefreshTableDelegate,UINavigationBarDelegate>

{

    UITextField                     *seachField;//搜索内容
    UIScrollView                    *_scrollView;
    UILabel                 *hotLabel;
    UITableView                 *_tableView;
    NSString                    *_keyWords;
    NSMutableArray                  *_marrayAll;
    TMAppDelegate                  *appDelegate;
    BOOL                isSeachFirst;
    UIView                  *navigation;
    UIView                  *seachBarView;
    NSString                    *_seachString;
    
    
    UIView                  *view_bar;
//    UIView                  *seachBar;
    UrlImageButton              *fourBtn;
    UILabel                 *fourLab;
    UIButton*BtnItem1,*BtnItem2;
    UIImageView *tabBarArrow;
    UIImageView* imageViewToolBar;
    
    UIButton*seachBtn;
    TMBabyListView *list;
    TMStoreListView *storeList;
    UIImageView*seachImageView;
    BOOL _isFirstView;

}
@property(nonatomic, strong) UISearchBar *searchBar;
@property(nonatomic, strong) UISearchDisplayController *strongSearchDisplayController;
-(id)initSeachKeyWords:(NSString*)keyWords addSeachString:(NSString*)string;
@end
