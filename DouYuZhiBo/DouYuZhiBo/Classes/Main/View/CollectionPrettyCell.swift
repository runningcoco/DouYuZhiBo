//
//  CollectionPrettyCell.swift
//  DouYuZhiBo
//
//  Created by echochief on 16/10/6.
//  Copyright © 2016年 echochief. All rights reserved.
//

import UIKit

class CollectionPrettyCell: UICollectionViewCell {
   
   // cell上各种控件
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var onlineBtn: UIButton!
    
    @IBOutlet weak var nickNameLabel: UILabel!
    
    @IBOutlet weak var cityBtn: UIButton!
    
    
    var anchor : AnchorModel? {
    
        didSet {
            
            guard let anchor = anchor else { return }
            
            // 取出在线人数的显示文字
            var onlineStr : String = ""
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online / 10000))万在线"
            } else {
                onlineStr = "\(anchor.online)在线"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
    
            // 主播大名的显示
            nickNameLabel.text = anchor.nickname
            
            // 所在城市
            cityBtn.setTitle(anchor.anchor_city, for: .normal)
            
            // 设置封面图片
            
        }
    }
}
