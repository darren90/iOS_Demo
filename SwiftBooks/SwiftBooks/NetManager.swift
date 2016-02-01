//
//  NetManager.swift
//  SwiftBooks
//
//  Created by Tengfei on 16/2/1.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD
import Toast

struct NetManager {
    
    static let netError = "网络异常，请检查网络";
        
    static func GET(URLString:String, parameters:[String:NSObject]?, showHUD:Bool = true, success:((NSObject?) -> Void)?, failure:((NSError) -> Void)?) {
        
        let manager = AFHTTPSessionManager()
        manager.requestSerializer.timeoutInterval = 10
        
        let mainWindow = UIApplication.sharedApplication().delegate!.window!
        
        if showHUD {
            MBProgressHUD.showHUDAddedTo(mainWindow, animated: true)
        }
        
        manager.GET(URLString, parameters: parameters, success: { (task, responseObject) -> Void in
            if showHUD {
                MBProgressHUD.hideAllHUDsForView(mainWindow, animated: true)
            }
            success?(responseObject as? NSObject)
            }) { (task, error) -> Void in
                if showHUD {
                    MBProgressHUD.hideAllHUDsForView(mainWindow, animated: true)
                    mainWindow?.makeToast(netError)
                }
                failure?(error)
        }
    }
    
    static func POST(URLString:String, parameters:[String:NSObject]?, showHUD:Bool = true, success:((NSObject?) -> Void)?, failure:((NSError) -> Void)?) {
        
        let manager = AFHTTPSessionManager()
        manager.requestSerializer.timeoutInterval = 10
        
        let mainWindow = UIApplication.sharedApplication().delegate!.window!
        
        if showHUD {
            MBProgressHUD.showHUDAddedTo(mainWindow, animated: true)
        }
        
        manager.POST(URLString, parameters: parameters, success: { (task, responseObject) -> Void in
            if showHUD {
                MBProgressHUD.hideAllHUDsForView(mainWindow, animated: true)
            }
            success?(responseObject as? NSObject)
            }) { (task, error) -> Void in
                if showHUD {
                    MBProgressHUD.hideAllHUDsForView(mainWindow, animated: true)
                    mainWindow?.makeToast(netError)
                }
                failure?(error)
        }
    }
    
//    static func get(URLString:String,parameters:[String:NSObject]?,showHUD:Bool = true,success:((NSObject?) -> Void)?,failure:((NSError) -> Void)?){
//        
//        let manager = AFHTTPSessionManager()
//        manager.requestSerializer.timeoutInterval = 10;
//        
//        let mainWindow = UIApplication.sharedApplication().delegate?.window!
//        
//        if showHUD{
//            MBProgressHUD.showHUDAddedTo(mainWindow, animated: true)
//        }
//        
//        manager.GET(URLString, parameters: parameters, success: { (task, responseObject) -> Void in
//            if showHUD {
//                MBProgressHUD.hideHUDForView(mainWindow, animated: true)
//            }
//            success?(responseObject as? NSObject)
//            }) { (task, error) -> Void in
//                if showHUD {
//                    MBProgressHUD.hideHUDForView(mainWindow, animated: true)
//                    mainWindow?.makeToast(netError);
//                }
//                failure?(error)
//        }
//        
//    }
}
