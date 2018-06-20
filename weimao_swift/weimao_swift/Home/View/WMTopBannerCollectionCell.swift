//
//  WMTopBannerCollectionCell.swift
//  weimao_swift
//
//  Created by claude on 2018/6/20.
//  Copyright © 2018年 zhi. All rights reserved.
//

import UIKit

class WMTopBannerCollectionCell: UICollectionViewCell {
    var bannerImg : UIImageView!
    var textLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        bannerImg = UIImageView.init(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        bannerImg.backgroundColor = UIColor.orange
        self.contentView.addSubview(bannerImg)
        
        textLabel = UILabel.init(frame: CGRect(x: 0, y: self.frame.size.height - 40, width: self.frame.size.width, height: 40))
        textLabel.backgroundColor = UIColor.black
        textLabel.alpha = 0.5
        textLabel.textColor = UIColor.white
        self.contentView.addSubview(textLabel)
        
    }
    
    
    func loadData(model: Dictionary<String, AnyObject>) -> Void {
        bannerImg.image = (model["image"] as! UIImage)
        textLabel.text = (model["title"] as! String)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
