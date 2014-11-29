//
//  EScrollerView.h
//  icoiniPad
//
//  Created by Ethan on 12-11-24.
//
//

#import <UIKit/UIKit.h>

@protocol EScrollerViewDelegate <NSObject>
@optional
-(void)EScrollerViewDidClicked:(NSUInteger)index;

@end

@interface EScrollerView : UIView<UIScrollViewDelegate> {
	CGRect viewSize;
	UIScrollView *scrollView;
	NSArray *imageArray;
    NSMutableArray *titleArray;
    UIPageControl *pageControl;
    id<EScrollerViewDelegate> delegate;
    int currentPageIndex;
    UILabel *noteTitle;


}
@property(nonatomic,retain)id<EScrollerViewDelegate> delegate;
@property(nonatomic,retain)NSArray *daoHangArray;
-(id)initWithFrameRect:(CGRect)rect scrolArray:(NSArray *)array needTitile:(BOOL)isNeedTitle;
@end
