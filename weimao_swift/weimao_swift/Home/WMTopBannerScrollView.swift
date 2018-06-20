//
//  WMTopBannerScrollView.swift
//  weimao_swift
//
//  Created by claude on 2018/6/20.
//  Copyright © 2018年 zhi. All rights reserved.
//

import UIKit

protocol TimerScrollViewDelegate{
    func scrollToIndexOfPage(index: Int)
}

class WMTopBannerScrollView: UIView, UIScrollViewDelegate {
    var count : Int = 0
    var timer : Timer!
    var timerDelegate: TimerScrollViewDelegate?
    var scrollView: UIScrollView?
    var pageCT: UIPageControl?
    

}
