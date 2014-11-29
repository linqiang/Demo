//
//  MJRefreshBaseView.m
//  weibo
//
//  Created by mj on 13-3-4.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MJRefreshBaseView.h"

#define kBundleName @"MJRefresh.bundle"
#define kSrcName(file) [kBundleName stringByAppendingPathComponent:file]

@interface  MJRefreshBaseView()
// 合理的Y值
- (CGFloat)validY;
// view的类型
- (int)viewType;
@end

@implementation MJRefreshBaseView

#pragma mark - 初始化方法
- (id)initWithScrollView:(UIScrollView *)scrollView
{
    if (self = [super init]) {
        self.scrollView = scrollView;
    }
    return self;
}

#pragma mark 初始化
- (void)initial
{
    // 1.自己的属性
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.backgroundColor = [UIColor clearColor];
    
    // 2.时间标签
    [self addSubview:_lastUpdateTimeLabel = [self labelWithFontSize:12]];
    
    // 3.状态标签
    [self addSubview:_statusLabel = [self labelWithFontSize:13]];
    
    // 4.箭头图片
    UIImageView *arrowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:kSrcName(@"arrow.png")]];
    arrowImage.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [self addSubview:_arrowImage = arrowImage];
    
    // 5.指示器
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityView.bounds = arrowImage.bounds;
    activityView.autoresizingMask = arrowImage.autoresizingMask;
    [self addSubview:_activityView = activityView];
    
    // 6.设置默认状态
    [self setState:RefreshStateNormal];
    
#ifdef NeedAudio
    // 7.加载音频
    _pullId = [self loadId:@"pull.wav"];
    _normalId = [self loadId:@"normal.wav"];
    _refreshingId = [self loadId:@"refreshing.wav"];
    _endRefreshId = [self loadId:@"end_refreshing.wav"];
#endif
}

#pragma mark 构造方法
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initial];
    }
    return self;
}

#pragma mark 创建一个UILabel
- (UILabel *)labelWithFontSize:(CGFloat)size
{
    UILabel *label = [[UILabel alloc] init];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label.font = [UIFont boldSystemFontOfSize:size];
    label.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

#ifdef NeedAudio  
#pragma mark 加载音效id
- (SystemSoundID)loadId:(NSString *)filename
{
    SystemSoundID ID;
    NSBundle *bundle = [NSBundle mainBundle];
    NSURL *url = [bundle URLForResource:kSrcName(filename) withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &ID);
    return ID;
}
#endif

#pragma mark 设置frame
- (void)setFrame:(CGRect)frame
{
    frame.size.height = kViewHeight;
    [super setFrame:frame];
    
    CGFloat statusY = 5;
    CGFloat w = frame.size.width;
    if (w == 0 || _statusLabel.frame.origin.y == statusY) return;
    
    // 1.状态标签
    CGFloat statusX = 0;
    CGFloat statusHeight = 20;
    CGFloat statusWidth = w;
    _statusLabel.frame = CGRectMake(statusX, statusY, statusWidth, statusHeight);
    
    // 2.时间标签
    CGFloat lastUpdateY = statusY + statusHeight + 5;
    _lastUpdateTimeLabel.frame = CGRectMake(statusX, lastUpdateY, statusWidth, statusHeight);
    
    // 3.箭头
    CGFloat arrowX = w * 0.5 - 100;
    _arrowImage.center = CGPointMake(arrowX, frame.size.height * 0.5);
    
    // 4.指示器
    _activityView.center = _arrowImage.center;
}

- (void)removeFromSuperview
{
    [self.superview removeObserver:self forKeyPath:@"contentOffset" context:nil];
    [super removeFromSuperview];
}

#pragma mark - UIScrollView相关
#pragma mark 设置UIScrollView
- (void)setScrollView:(UIScrollView *)scrollView
{
    // 移除之前的监听器
    [_scrollView removeObserver:self forKeyPath:@"contentOffset" context:nil];
    // 设置scrollView
    _scrollView = scrollView;
    [_scrollView addSubview:self];
    // 监听contentOffset
    [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark 监听UIScrollView的contentOffset属性
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{    
    if ([@"contentOffset" isEqualToString:keyPath]) {
        CGFloat offsetY = _scrollView.contentOffset.y * self.viewType;
        CGFloat validY = self.validY;
        if (!self.userInteractionEnabled || self.alpha <= 0.01 || self.hidden
            || _state == RefreshStateRefreshing
            || offsetY <= validY) return;
        
        // 即将刷新 && 手松开
        if (_scrollView.isDragging) {
            CGFloat validOffsetY = validY + kViewHeight;
            if (_state == RefreshStatePulling && offsetY <= validOffsetY) {
                // 转为普通状态
#ifdef NeedAudio
                AudioServicesPlaySystemSound(_normalId);
#endif
                [self setState:RefreshStateNormal];
            } else if (_state == RefreshStateNormal && offsetY > validOffsetY) {
                // 转为即将刷新状态
#ifdef NeedAudio
                AudioServicesPlaySystemSound(_pullId);
#endif
                [self setState:RefreshStatePulling];
            }
        } else {
            if (_state == RefreshStatePulling) {
                // 开始刷新
#ifdef NeedAudio
                AudioServicesPlaySystemSound(_refreshingId);
#endif
                [self setState:RefreshStateRefreshing];
            }
        }
    }
}

#pragma mark 设置状态
- (void)setState:(RefreshState)state
{
    switch (state) {
		case RefreshStateNormal:
            _arrowImage.hidden = NO;
			[_activityView stopAnimating];
			break;
            
        case RefreshStatePulling:
            break;
            
		case RefreshStateRefreshing:
			[_activityView startAnimating];
			_arrowImage.hidden = YES;
            _arrowImage.transform = CGAffineTransformIdentity;
            
            // 通知代理
            if ([_delegate respondsToSelector:@selector(refreshViewBeginRefreshing:)]) {
                [_delegate refreshViewBeginRefreshing:self];
            }
            
            // 回调
            if (_beginRefreshingBlock) {
                _beginRefreshingBlock(self);
            }
			break;
	}
}

#pragma mark - 状态相关
#pragma mark 是否正在刷新
- (BOOL)isRefreshing
{
    return RefreshStateRefreshing == _state;
}
#pragma mark 开始刷新
- (void)beginRefreshing
{
    [self setState:RefreshStateRefreshing];
}
#pragma mark 结束刷新
- (void)endRefreshing
{
    [self setState:RefreshStateNormal];
}
@end