//
//  NetworkTools.swift
//  DouYuZhiBo
//
//  Created by echochief on 16/10/6.
//  Copyright © 2016年 echochief. All rights reserved.
//


import UIKit
import Alamofire

enum MethodType : String {
    case get
    case post
}

class NetworkTools {
    class func requestData(_ type : MethodType, URLString : String, para : [String : NSString]? = nil ,finishedCallback : @escaping ( _ result : AnyObject) -> ()) {
        
        // 1.获取类型
        let methodU = type == .get ? HTTPMethod.get : HTTPMethod.post
        // 把GET/POST 转化成小写 get/post
		let str = "//"

        let methodL = methodU.rawValue.lowercased()
        let urlStr = URLString.appending(str).appending(methodL)
		
        /*
        // 2.发送网络请求 JSONSerialization.ReadingOptions
        Alamofire.request(urlStr, parameters: para, encoding: URLEncoding.default).responseJSON { (response) in
        
        // 3.获取结果
           guard let result = response.result.value else {
              print(urlStr)
              print(response.result.error)
              return

        }
        */

        Alamofire.request(urlStr, method: methodU, parameters: para, encoding: URLEncoding.default, headers: ["Content-Type":"application/json"]).responseJSON { (response) in
            // 3.获取结果
           guard let result = response.result.value else {
              print(urlStr)
              print(response.result.error)
              return

        }
     
        // 4.将结果回调出去
        finishedCallback(result as AnyObject)
        }
    }
}

