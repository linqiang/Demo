//
//  WMTabBarButton.swift
//  weimao_swift
//
//  Created by claude on 2018/6/12.
//  Copyright © 2018年 zhi. All rights reserved.
//

import UIKit

class WMTabBarButton: UIButton {

    let tabBarImageRatio = 0.5
    var item : UITabBarItem = UITabBarItem(){
        didSet{
            self.setImage(self.item.image, for: .normal)
            self.setImage(self.item.selectedImage, for: .selected)
        }
    }
    
    override var isHighlighted: Bool{
        set {}
        get{
            return false
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)


    }
    
 
    // MARK: - image
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
//        let imageH = contentRect.size.height * CGFloat(tabBarImageRatio)
        let imageH = contentRect.size.height
        let imageW = contentRect.size.width
        return CGRect(x: 0, y: 0, width: imageW, height: imageH)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
