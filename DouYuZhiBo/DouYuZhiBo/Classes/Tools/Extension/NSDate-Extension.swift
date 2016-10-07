//
//  NSDate-Extension.swift
//  DouYuZhiBo
//
//  Created by echochief on 16/10/7.
//  Copyright © 2016年 echochief. All rights reserved.
//

import Foundation

extension NSDate {
    class func getCurrentTime() -> String {
        
        let nowDate = NSDate()
        let interval =  Int(nowDate.timeIntervalSince1970)
        
        return "(\(interval))"
    }
}
