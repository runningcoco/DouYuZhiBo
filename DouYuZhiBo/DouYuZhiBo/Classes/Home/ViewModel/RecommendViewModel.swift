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
    fileprivate lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    fileprivate lazy var prettyGroup : AnchorGroup = AnchorGroup()
}

// Mark: - 发送网络请求
extension RecommendViewModel {
    func requestData(_ finishCallback : @escaping () -> ()) {
        
        let para = ["limit" : "4", "offset" : "0", "time" : NSDate.getCurrentTime() as NSString]
		
        // 创建Group
        let Datagroup = DispatchGroup()
		Datagroup.enter()
        
        // 1.请求推荐数据 
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", para: ["time" : NSDate.getCurrentTime() as NSString]) { (result) in
                // 将result转成字典
                guard let resultDict = result as? [String : NSObject] else { return }
            
                // 获取dict里的数组
                guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
                self.bigDataGroup.tag_name = "热门"
                self.bigDataGroup.icon_name = "home_header_hot"
            
                for dict in dataArray {
                    let anchor = AnchorModel(dict: dict)
                    self.bigDataGroup.anchors.append(anchor)
                    
                }
                // 请求完数据后group leave
                Datagroup.leave()
            
        }
        
        
        // 2.请求颜值数据
        Datagroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", para: para) { (result) in
                // 将result转成字典
                guard let resultDict = result as? [String : NSObject] else { return }
            
                // 获取dict里的数组
                guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
                self.prettyGroup.tag_name = "颜值"
                self.prettyGroup.icon_name = "home_header_phone"
            
                for dict in dataArray {
                    let anchor = AnchorModel(dict: dict)
                    self.prettyGroup.anchors.append(anchor)
                    
                }
                Datagroup.leave()
        }
        
        
        
        
        // 3. 请求后面部分的游戏数据
        Datagroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", para: para) { (result) in
            
                // 将result转成字典
                guard let resultDict = result as? [String : NSObject] else { return }
            
                // 获取dict里的数组
                guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
                // 遍历数组，获取字典，将字典转成model对象
                for dic in dataArray {
                    let group = AnchorGroup(dict: dic)
                    self.anchorGroups.append(group)
                }
                Datagroup.leave()
        }
            // 所有的数据都请求到,然后排序
            Datagroup.notify(queue: DispatchQueue.main) {
                self.anchorGroups.insert(self.prettyGroup, at: 0)
                self.anchorGroups.insert(self.bigDataGroup, at: 0)
                
                finishCallback()
        }
        
    }
}
