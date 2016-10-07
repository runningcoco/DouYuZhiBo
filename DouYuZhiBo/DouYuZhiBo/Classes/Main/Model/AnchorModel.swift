//
//  AnchorModel.swift
//  DouYuZhiBo
//
//  Created by echochief on 16/10/7.
//  Copyright © 2016年 echochief. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    
    // room_list里的数据
    var room_id : Int = 0
    
    // 房间图片url
	var vertical_src : String = ""
    
    // 判断是手机直播还是电脑直播   手机：1  电脑：0
    var isVertical : Int = 0
		
    // 房间标题
    var room_name : String = ""
    
    // 主播名字
    var nickname : String = ""
    
    // 在线人数
    var online : Int = 0
    
    // 所在城市
    var anchor_city : String = ""
    
    init(dict : [String : NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
				
}
