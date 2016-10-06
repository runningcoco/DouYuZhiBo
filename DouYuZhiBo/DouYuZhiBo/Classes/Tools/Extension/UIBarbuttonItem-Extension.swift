//
//  UIBarbuttonItem-Extension.swift
//  DouYuZhiBo
//
//  Created by echochief on 16/10/3.
//  Copyright © 2016年 echochief. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    /*
    class func createItem(imageName : String, highlightImageName : String, size : CGSize) -> UIBarButtonItem {
            let btn = UIButton()
            btn.setImage(UIImage.init(named: imageName), for: .normal)
            btn.setImage(UIImage.init(named: highlightImageName), for: .highlighted)
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
            return UIBarButtonItem(customView: btn)
    }
    */
    
    
    // 遍历构造函数：1.convenience开头  2.必须明确的调用一个设计的构造函数(self)
    convenience init(imageName : String, highImageName : String = "", size : CGSize = CGSize.zero) {
        
            let btn = UIButton()
        
            btn.setImage(UIImage(named: imageName), for: UIControlState())
        if highImageName != "" {
            btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        
            if size == CGSize.zero {
                btn.sizeToFit()
            } else {
                btn.frame = CGRect(origin: CGPoint.zero, size: size)
            }
        
            self.init(customView : btn)
    }
   
     
}
