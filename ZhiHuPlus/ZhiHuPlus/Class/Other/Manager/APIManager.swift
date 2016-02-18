//
//  APIManager.swift
//  ZhiHuPlus
//
//  Created by Fengtf on 16/2/18.
//  Copyright © 2016年 ftf. All rights reserved.
//

import UIKit
import Alamofire

class APIManager: NSObject {
    
    
    /**
     GET请求的方式
     
     - parameter url:     url
     - parameter params:  参数，字典类型
     - parameter success: 成功的回调
     - parameter fail:    失败
     */
    static func get(url:String,params:[String:AnyObject]?,success:(json:AnyObject) -> Void,fail:(error:Any) -> Void){
        let urlStr = url
        
        if let paramss = params{//有参数
            Alamofire.request(.GET, urlStr, parameters: paramss, encoding: .JSON, headers: nil).responseJSON(completionHandler: {(_, _, dataResult) -> Void in
                if let result = dataResult.value{
                    success(json: result)
                }
            })
        }else{//无参数
            Alamofire.request(.GET, urlStr).responseJSON(completionHandler: { (_, _, dataResult) -> Void in
                if let result = dataResult.value{
                    success(json: result)
                }
            })
        }
        
    }
 

    /**
     POST请求的方式
     
     - parameter url:     url
     - parameter params:  参数，字典类型
     - parameter success: 成功的回调
     - parameter fail:    失败
     */
    static func post(url:String,params:[String:AnyObject]?,success:(json:AnyObject) -> Void,fail:(error:Any) -> Void){
        
        let urlStr = url
        
        if let paramss = params{
            Alamofire.request(.POST, urlStr, parameters: paramss, encoding: .JSON, headers: nil).responseJSON(completionHandler: { (_, _, dataResult) -> Void in
                if let result = dataResult.value{
                    success(json: result)
                }
            })
        }else{
            Alamofire.request(.POST, urlStr).responseJSON(completionHandler: { (_, _, dataResult) -> Void in
                if let result = dataResult.value{
                    success(json: result)
                }
            })
        }
    }









}







