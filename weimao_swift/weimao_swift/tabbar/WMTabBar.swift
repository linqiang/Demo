//
//  WMTabBar.swift
//  weimao_swift
//
//  Created by claude on 2018/6/12.
//  Copyright © 2018年 zhi. All rights reserved.
//

import UIKit

public protocol WMTabBarDelegate{
    func tabbar(_ tabbar: WMTabBar, fromWithItem: Int, toWhichItem: Int)
}

public class WMTabBar: UIView {

    var tabBarButtons: NSMutableArray = []
    var selectedButton = WMTabBarButton()
    var wmTabBarDelegate: WMTabBarDelegate! = nil
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(Coder: ) has not implemented")
    }
    
    // FIXME : 这里的selector和后面的查看效果
    func addTabBarButtonWith(item: UITabBarItem, selector: UIColor, normoalColor: UIColor) -> Void{
        let button = WMTabBarButton()
        button.item = item
        self.tabBarButtons.add(button)
        button.addTarget(self, action: #selector(buttonDidTouch), for: .touchDown)
        self.addSubview(button)
        
        // 默认选中
        if self.tabBarButtons.count == 1 {
            self.buttonDidTouch((self.tabBarButtons[0] as? WMTabBarButton)!)
        }
    }
    
    @objc func buttonDidTouch(_ button: WMTabBarButton) -> Void {
        wmTabBarDelegate.tabbar(self, fromWithItem: self.selectedButton.tag, toWhichItem: button.tag)
        self.selectedButton.isSelected = false
        button.isSelected = true
        self.selectedButton = button
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        // 按钮
        let buttonW = self.frame.size.width / CGFloat(self.tabBarButtons.count)
        let buttonH = self.frame.size.height
        let buttonY = 0
        
        if self.tabBarButtons.count > 0 {
            for index in 0...self.tabBarButtons.count - 1 {
                // 取出按钮
                let button: UIButton = self.tabBarButtons[index] as! UIButton
                
                let buttonX = CGFloat(index) * buttonW
                button.frame = CGRect(x: buttonX, y: CGFloat(buttonY), width: buttonW, height: buttonH)
                self.addSubview(button)
                
                //绑定Tag
                button.tag = index
            }
        }
    }
}
