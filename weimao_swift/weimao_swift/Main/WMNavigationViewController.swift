//
//  WMNavigationViewController.swift
//  weimao_swift
//
//  Created by claude on 2018/6/13.
//  Copyright © 2018年 zhi. All rights reserved.
//

import UIKit

public enum TabBarHideStyle {
    case animation
    case normal
}

class WMNavigationViewController: UINavigationController, UINavigationControllerDelegate {
    var tabbarHideStyle = TabBarHideStyle.normal

    override  public func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar .setBackgroundImage(UIImage.init(), for: UIBarMetrics.compactPrompt)
        self.navigationBar.shadowImage = UIImage.init()
        
        
        self.delegate = self
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override init(rootViewController: UIViewController) {
        
        super.init(rootViewController: rootViewController)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder :) has not been implemented")
    }
    
    // pushViewController
    override public func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            let rootVC = self.viewControllers[0]
            if tabbarHideStyle == TabBarHideStyle.animation {
                UIView.animate(withDuration: 0.35) {
                    rootVC.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 64)
                }
                
            }else{
                viewController.hidesBottomBarWhenPushed = true
            }
            
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    // MARK: -- popToRootViewCotnroller
    
    public override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        super.popToRootViewController(animated: animated)
        tabBarHandler()
        return nil
    }
    
    // MARK : -- popViewController
    
    public override func popViewController(animated: Bool) -> UIViewController? {
        super.popViewController(animated: animated)
        tabBarHandler()
        return self.viewControllers[0]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: -- UINavigationControllerDelegate - tabbar重影
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        for tabBar in (tabBarController?.tabBar.subviews)! {
            if tabBar.isKind(of: NSClassFromString("UITabBarButton")!) {
                self.tabBarController?.tabBar.backgroundImage = UIImage.init()
                self.tabBarController?.tabBar.shadowImage = UIImage.init()
                tabBar.removeFromSuperview()
            }
        }
    }
    // handler tabbar
    func tabBarHandler(){
        if self.viewControllers.count == 1 {
            let rootVc = self.viewControllers[0]
            if tabbarHideStyle == TabBarHideStyle.animation{
                UIView.animate(withDuration: 0.35) {
                    rootVc.tabBarController?.tabBar.transform = CGAffineTransform.identity
                }
            }else{
                
                let rootVc = self.viewControllers[0]
                rootVc.hidesBottomBarWhenPushed = false
            }
        }
    }


}
