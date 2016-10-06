//
//  NetworkTools.swift
//  DouYuZhiBo
//
//  Created by echochief on 16/10/6.
//  Copyright © 2016年 echochief. All rights reserved.
//


import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

class NetworkTools {
    class func requestData(_ type : MethodType, URLString : String, parameters : [String : NSString]? = nil, finishedCallback : @escaping (_ result : AnyObject) -> ()) {
        
        // 1.获取类型
        let method = type == .get ? Method.GET : Method.POST
        
        // 2.发送网络请求
        Alamofire.request(method, URLString, parameters: parameters).responseJSON { (response) in
            // 3.获取结果
            guard let result = response.result.value else {
                print(response.result.error)
                return
            }
            
            // 4.将结果回调出去
            finishedCallback(result: result)
        }
    }
}

