//
//  WMTabBarMainViewController.swift
//  weimao_swift
//
//  Created by claude on 2018/6/12.
//  Copyright © 2018年 zhi. All rights reserved.
//

import UIKit
class WMTabBarMainViewController: WMTabBarViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.initChildVc()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initChildVc(){
        let homeVc = WMHomeViewController()
        let classificationVc = WMClassificationViewController()
        let MineVc = WMMineViewController()
        let findVc = WMSearchViewController()
        let shoppingCarVc = WMShoppingCarViewController()
        self.selectColor = UIColor.red
        self.normalColor = UIColor.brown
        
        
        self.setupChildVC(childVC: homeVc, imageName: "btn_home_normal", selectImageName: "btn_home_selected")
        self.setupChildVC(childVC: classificationVc, imageName: "btn_classfic_normal", selectImageName: "btn_classfic_selected")
        self.setupChildVC(childVC: MineVc, imageName: "btn_mine_normal", selectImageName: "btn_mine_selected")
        self.setupChildVC(childVC: findVc, imageName: "btn_search_normal", selectImageName: "btn_search_selected")
        self.setupChildVC(childVC: shoppingCarVc, imageName: "btn_shopCar_normal", selectImageName: "btn_shopCar_selected")
        
    }

}
