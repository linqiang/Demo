//
//  WMCarouselView.swift
//  WMCarouselSwift
//
//  Created by Glianze on 2017/11/15.
//  Copyright © 2017年 Glianze. All rights reserved.
//

import UIKit

public protocol WMCarouselDelegate:class {
    func carouselForItemCell(carouselView:WMCarouselView, cell:AnyObject, indexItem:AnyObject) -> Void
    func carouselDidSelectItemAtIndex(carouselView:WMCarouselView, index: Int) -> Void
}

public enum WMCarouselPageAlignment{
    case left
    case right
    case center
}

public enum WMCarouselScrollDirection{
    case left
    case right
    case top
    case bottom
}

open class WMCarouselView: UIView,UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate {
    
    var _carouselData : [AnyObject]!
    var cellClass : AnyClass!
    var timer : Timer!
    var autoScrollTimeInterval : Float!
    var scrollDirection : WMCarouselScrollDirection!
    var pageControlAlignment : WMCarouselPageAlignment!
    var hiddenPageControl : Bool!
    
    var currentPageColor : UIColor?
    var defaultPageColor : UIColor!
    
    private var coreView : UICollectionView!
    private var pageControl : UIPageControl!
    var backgroundView : UIImageView!
    private var this_width : Int!
    private var this_height : Int!
    
    public weak var delegate : WMCarouselDelegate?
    
    public init(frame: CGRect, direction: WMCarouselScrollDirection) {
        super.init(frame: frame)
        
        this_width = Int(frame.size.width)
        this_height = Int(frame.size.height)
        
        self.scrollDirection = direction
        
        self.resettingSelfFrame(frame: frame)
        self.instance()
        self.makeCoreUI(direction: direction);
        self.makePageControlUI(frame: frame)
    }
    
    private func resettingSelfFrame(frame: CGRect) -> Void {
        self.frame = CGRect(x: frame.origin.x,y: frame.origin.y, width: CGFloat(this_width), height: CGFloat(this_height))
    }
    
    private func instance() -> Void {
        autoScrollTimeInterval = 0
        pageControlAlignment = WMCarouselPageAlignment.center
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func makeCoreUI(direction: WMCarouselScrollDirection) -> Void {
        backgroundView = UIImageView.init(frame: CGRect(x:0.0 ,y: 0.0, width: CGFloat(this_width), height: CGFloat(this_height)))
        backgroundView.layer.masksToBounds = true
        backgroundView.layer.borderWidth = 0
        backgroundView.backgroundColor = UIColor.red
        self.backgroundView.contentMode = UIViewContentMode.scaleToFill
        self.addSubview(backgroundView)
        
        let flowLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        flowLayout.itemSize = CGSize(width: this_width, height: this_height)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        
        if direction == WMCarouselScrollDirection.left || direction == WMCarouselScrollDirection.right {
            flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        }else if direction == WMCarouselScrollDirection.top || direction == WMCarouselScrollDirection.bottom {
            flowLayout.scrollDirection = UICollectionViewScrollDirection.vertical
        }
        
        self.coreView = UICollectionView.init(frame: CGRect(x:0.0 ,y: 0.0, width: CGFloat(this_width), height: CGFloat(this_height)), collectionViewLayout: flowLayout)
        self.coreView.showsHorizontalScrollIndicator = false
        self.coreView.showsVerticalScrollIndicator = false
        self.coreView.dataSource = self
        self.coreView.delegate = self
        self.coreView.isPagingEnabled = true
        self.coreView.backgroundColor = UIColor.clear
        if #available(iOS 11.0, *) {
            self.coreView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentBehavior.never
        } else {
            // Fallback on earlier versions
        }
        self.addSubview(self.coreView)
    }
    
    private func makePageControlUI(frame: CGRect) -> Void {
        self.pageControl = UIPageControl.init(frame: CGRect(x:0.0 ,y: CGFloat(this_height - 20), width: CGFloat(this_width), height: 20.0))
        self.pageControl.backgroundColor = UIColor.clear
        self.addSubview(self.pageControl)
    }
    
    public func setCurrentPageColor(color: UIColor) -> Void {
        self.pageControl.currentPageIndicatorTintColor = color
    }
    
    public func setDefaultPageColor(color: UIColor) -> Void {
        self.pageControl.pageIndicatorTintColor = color
    }
    
    public func setPageControlAlignment(alignment: WMCarouselPageAlignment) -> Void {
        pageControlAlignment = alignment
    }
    
    public func setHiddenPageControl(hidden: Bool) -> Void {
        pageControl.isHidden = hidden
    }
    
    private func settingPageControlAlignment() -> Void {
        let pointSize : CGSize = pageControl.size(forNumberOfPages: _carouselData.count)
        var page_x : Float = 0.0
        if (pageControlAlignment == WMCarouselPageAlignment.left) {
            page_x = Float((pageControl.bounds.size.width - pointSize.width) / 2) ;
        }else if (pageControlAlignment == WMCarouselPageAlignment.right){
            page_x = Float(-(pageControl.bounds.size.width - pointSize.width) / 2) ;
        }else if (pageControlAlignment == WMCarouselPageAlignment.center){
            page_x = 0;
        }
        pageControl.bounds = CGRect(x: CGFloat(page_x), y: pageControl.bounds.origin.y,width: pageControl.bounds.size.width, height: pageControl.bounds.size.height)
    }
    
    public func setCarouselData(carouselData: [AnyObject]) -> Void {
        if !carouselData.isEmpty {
            _carouselData = self.remakeCarouselData(data: carouselData)
            self.coreView.reloadData()
            self.pageControl.numberOfPages = carouselData.count
        }
        settingPageControlAlignment()
        
        if scrollDirection == WMCarouselScrollDirection.left || scrollDirection == WMCarouselScrollDirection.right {
            self.coreView.contentOffset = CGPoint(x: this_width, y: 0)
        }else if scrollDirection == WMCarouselScrollDirection.top || scrollDirection == WMCarouselScrollDirection.bottom {
            self.coreView.contentOffset = CGPoint(x: 0, y: this_height)
        }
    }
    
    private func remakeCarouselData(data: [AnyObject]) -> [AnyObject] {
        var carousel_data : [AnyObject] = [AnyObject]()
        carousel_data.append(data.last!)
        for item in data {
            carousel_data.append(item)
        }
        carousel_data.append(data.first!)
        return carousel_data
    }
    
    public func registerCarouselCell(cellClass: AnyClass) -> Void {
        self.cellClass = cellClass
        coreView.register(self.cellClass, forCellWithReuseIdentifier: NSStringFromClass(self.cellClass))
    }
    
    public func setAutoScrollTimeInterval(timeInterval: Float) -> Void {
        self.autoScrollTimeInterval = timeInterval
        self.createTimer()
    }
    
    private func createTimer() -> Void {
        timer = Timer.scheduledTimer(timeInterval: Double(self.autoScrollTimeInterval), target: self, selector: #selector(self.autoCarouselScroll), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode:RunLoopMode.commonModes)
    }
    
    @objc func autoCarouselScroll() -> Void {
        if scrollDirection == WMCarouselScrollDirection.left {
            self.autoCarouselScrollWithDirection(direction: WMCarouselScrollDirection.left)
        } else if scrollDirection == WMCarouselScrollDirection.right {
            self.autoCarouselScrollWithDirection(direction: WMCarouselScrollDirection.right)
        } else if scrollDirection == WMCarouselScrollDirection.top {
            self.autoCarouselScrollWithDirection(direction: WMCarouselScrollDirection.top)
        } else if scrollDirection == WMCarouselScrollDirection.bottom {
            self.autoCarouselScrollWithDirection(direction: WMCarouselScrollDirection.bottom)
        }
    }
    
    private func autoCarouselScrollWithDirection(direction: WMCarouselScrollDirection) -> Void {
        var contentPoint: CGPoint = CGPoint(x:0.0, y:0.0)
        
        if direction == WMCarouselScrollDirection.left {
            contentPoint = CGPoint(x: self.coreView.contentOffset.x + CGFloat(this_width), y: 0.0)
        } else if direction == WMCarouselScrollDirection.right {
            contentPoint = CGPoint(x: self.coreView.contentOffset.x - CGFloat(this_width), y: 0.0)
        } else if direction == WMCarouselScrollDirection.top {
            contentPoint = CGPoint(x: 0.0, y: self.coreView.contentOffset.y + CGFloat(this_height))
        } else if direction == WMCarouselScrollDirection.bottom {
            contentPoint = CGPoint(x: 0.0, y: self.coreView.contentOffset.y - CGFloat(this_height))
        }
        self.coreView.setContentOffset(contentPoint, animated: true)
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _carouselData.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(cellClass), for: indexPath)
        self.delegate?.carouselForItemCell(carouselView: self, cell: cell, indexItem: self._carouselData[indexPath.row])
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.carouselDidSelectItemAtIndex(carouselView: self, index: indexPath.row-1)
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.pageControl.currentPage = fetchCurrentPage();
        if scrollDirection == WMCarouselScrollDirection.left || scrollDirection == WMCarouselScrollDirection.right {
            self.carouselHorizontalDidScroll(scrollView: scrollView)
        }else if scrollDirection == WMCarouselScrollDirection.top || scrollDirection == WMCarouselScrollDirection.bottom {
            self.carouselVerticalDidScroll(scrollView: scrollView)
        }
    }
    
    private func carouselHorizontalDidScroll(scrollView: UIScrollView) -> Void {
        if scrollView.contentOffset.x <= 0 {
            scrollView.contentOffset = CGPoint(x: Int(this_width) * (_carouselData.count - 2), y: 0);
        } else if Float(scrollView.contentOffset.x) >= Float(this_width) * (Float(_carouselData.count - 1)) {
            scrollView.contentOffset = CGPoint(x: Int(this_width), y: 0);
        }
    }
    
    private func carouselVerticalDidScroll(scrollView: UIScrollView) -> Void {
        if scrollView.contentOffset.y <= 0 {
            scrollView.contentOffset = CGPoint(x: 0, y: this_height * (_carouselData.count - 2))
        } else if Float(scrollView.contentOffset.y) >= Float(this_height) * (Float(_carouselData.count - 1)) {
            scrollView.contentOffset = CGPoint(x: CGFloat(0), y: CGFloat(this_height));
        }
    }
    
    private func fetchCurrentPage() -> Int {
        
        var contentOffset:CGFloat = 0
        var widthOrHeight:CGFloat = 0
        
        if scrollDirection == WMCarouselScrollDirection.left || scrollDirection == WMCarouselScrollDirection.right {
            contentOffset = coreView.contentOffset.x
            widthOrHeight = CGFloat(this_width)
        }else if scrollDirection == WMCarouselScrollDirection.top || scrollDirection == WMCarouselScrollDirection.bottom {
            contentOffset = coreView.contentOffset.y
            widthOrHeight = CGFloat(this_height)
        }
        
        let page : Int = Int((contentOffset + widthOrHeight * CGFloat(0.5)) / widthOrHeight) - 1;
        
        if contentOffset > widthOrHeight * CGFloat(_carouselData.count - 2) + widthOrHeight * 0.5 {
            return 0
        }else if contentOffset < widthOrHeight * 0.5 {
            return _carouselData.count - 3
        }
        
        return page
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timer.invalidate()
        timer = nil
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if autoScrollTimeInterval != 0.0 {
            self.createTimer()
        }
    }
    
    deinit {
        timer = nil
    }
    
}

