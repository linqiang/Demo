//
//  WMHomeViewController.swift
//  weimao_swift
//
//  Created by claude on 2018/6/12.
//  Copyright © 2018年 zhi. All rights reserved.
//

import UIKit

class WMHomeViewController: UIViewController,WMCarouselDelegate {

    let bgScrollView = UIScrollView()
    
override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "首页"
        self.view.backgroundColor = UIColor.white
    self.setupBgScrollView()
}

override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
}
// MARK : -- 设置
func setupBgScrollView(){
    
    
    let data = [
        ["title":"标题1","image":UIImage(named:"banner_1") as Any],
        ["title":"标题2","image":UIImage(named:"banner_2") as Any],]
    
    
    let carousel = WMCarouselView.init(frame: CGRect(x: 0, y: 64, width: self.view.frame.size.width, height:self.view.frame.size.height / 3), direction: WMCarouselScrollDirection.left)
    carousel.registerCarouselCell(cellClass: WMTopBannerCollectionCell.classForCoder())
    
    carousel.setCurrentPageColor(color: UIColor.white)
    carousel.setDefaultPageColor(color: UIColor.lightGray)
    carousel.delegate = self 
    carousel.setAutoScrollTimeInterval(timeInterval: 2)
    carousel.setPageControlAlignment(alignment: WMCarouselPageAlignment.right)
    carousel.setCarouselData(carouselData: data as [AnyObject])
    carousel.tag = 1001;
    self.view.addSubview(carousel)
}
    
    func carouselForItemCell(carouselView: WMCarouselView, cell: AnyObject, indexItem: AnyObject) {
        let cell1: WMTopBannerCollectionCell = cell as! WMTopBannerCollectionCell
        cell1.loadData(model: indexItem as! Dictionary<String, AnyObject>)
    }
    
    func carouselDidSelectItemAtIndex(carouselView: WMCarouselView, index: Int) {
        
    }

func setupHeaderView(){
    
}
    

}
