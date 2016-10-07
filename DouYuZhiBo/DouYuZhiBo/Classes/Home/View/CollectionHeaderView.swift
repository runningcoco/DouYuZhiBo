//
//  CollectionHeaderView.swift
//  DouYuZhiBo
//
//  Created by echochief on 16/10/5.
//  Copyright © 2016年 echochief. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var iconsImageView: UIImageView!

    // MARK:- 定义模型属性
    var group : AnchorGroup? {
        didSet {
            titleLabel.text = group?.tag_name
            iconsImageView.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
    }
}
