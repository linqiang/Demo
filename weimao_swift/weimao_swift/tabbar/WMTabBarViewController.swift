//
//  WMTabBarViewController.swift
//  weimao_swift
//
//  Created by claude on 2018/6/12.
//  Copyright © 2018年 zhi. All rights reserved.
//

import UIKit

open class WMTabBarViewController: UITabBarController, WMTabBarDelegate {
   
    
    
    public weak var customTabBar = WMTabBar()
    public var selectColor = UIColor.blue
    public var normalColor = UIColor.black
    public var tabBarHiddenStyle = TabBarHideStyle.normal

    override open func viewDidLoad() {
        super.viewDidLoad()
       
        self.setUpTabbar()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for child in self.tabBar.subviews {
            if child.isKind(of: UIControl.self){
                child.removeFromSuperview()
            }
        }
    }
    
    func setUpTabbar() -> Void{
        
        let customTabBar = WMTabBar(frame: self.tabBar.bounds)
        customTabBar.wmTabBarDelegate = self
        self.tabBar.addSubview(customTabBar)
        self.customTabBar = customTabBar
    }
    
    
    // MARK: -- TabbarDelegate
    public func tabbar(_ tabbar: WMTabBar, fromWithItem: Int, toWhichItem: Int) {
        self.selectedIndex = toWhichItem
    }
 
    
    public func setupChildVC(childVC: UIViewController, imageName: String, selectImageName:String){
        childVC.tabBarItem.image = UIImage(named: imageName)
        childVC.tabBarController?.tabBar.backgroundImage = UIImage.init()
        childVC.tabBarController?.tabBar.shadowImage = UIImage.init()
        childVC.tabBarItem.selectedImage = UIImage(named: selectImageName)? .withRenderingMode(.alwaysOriginal)
        let navigationControl = WMNavigationViewController(rootViewController: childVC)
        navigationControl.tabbarHideStyle = tabBarHiddenStyle
        self.addChildViewController(navigationControl)
        self.customTabBar!.addTabBarButtonWith(item: childVC.tabBarItem, selector: selectColor, normoalColor: normalColor)
    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  

}
