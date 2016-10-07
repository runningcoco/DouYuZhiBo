//
//  RecommendViewModel.swift
//  DouYuZhiBo
//
//  Created by echochief on 16/10/7.
//  Copyright © 2016年 echochief. All rights reserved.
//

import UIKit

class RecommendViewModel {
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
}

// Mark: - 发送网络请求
extension RecommendViewModel {
    func requestData() {
    
        // 1.请求推荐数据 
        
        
        // 2.请求颜值数据
        
        
        // 3. 请求后面部分的游戏数据
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", para: ["limit" : "4", "offset" : "0", "time" : NSDate.getCurrentTime() as NSString]) { (result) in
            
                // 将result转成字典
                guard let resultDict = result as? [String : NSObject] else { return }
            
                // 获取dict里的数组
                guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
                // 遍历数组，获取字典，将字典转成model对象
                for dic in dataArray {
                    let group = AnchorGroup(dict: dic)
                    self.anchorGroups.append(group)
                }
            
                for group in self.anchorGroups {
                    for anchor in group.anchors {
                        print(anchor.nickname)
                    }
                }
            
        }
    }
}
