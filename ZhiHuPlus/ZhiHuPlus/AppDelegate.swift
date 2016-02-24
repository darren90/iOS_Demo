//
//  AppDelegate.swift
//  ZhiHuPlus
//
//  Created by Fengtf on 16/2/17.
//  Copyright © 2016年 ftf. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var sideArray: [SideModel] = []//侧边栏的条目



    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        addNotification()

        let launchVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("launchhhhhhhhh") as! LaunchViewController

        window = UIWindow(frame: UIScreen.mainScreen().bounds)
//        window?.backgroundColor = UIColor.whiteColor()
        window?.rootViewController = launchVC
        window!.makeKeyAndVisible()
        print(window?.rootViewController)
        
        getThemesData()
        return true
    }
    
    
    func addNotification() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "LunchLoadHadOk:", name: LunchLoadNotication, object: nil)
    }

    
    // MARK: - Action
    func LunchLoadHadOk(noti: NSNotification) {
        
        let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! SWRevealViewController
        
        window?.rootViewController = mainVC
        window!.makeKeyAndVisible()

    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


    
    func getThemesData(){
        
        APIManager.get("http://news-at.zhihu.com/api/4/themes", params: nil, success: { (json) -> Void in
            
            let data = json["others"]
//            print(data)

            for i in 0..<data!!.count {
                let ID = String(data!![i]["id"])
                let name = String(data!![i]["name"])
                self.sideArray.append(SideModel(id: ID, name: name))
            }
//            print(self.sideArray)

            }) { (error) -> Void in
                
        }
        
//        Alamofire.request(.GET, "http://news-at.zhihu.com/api/4/themes").responseJSON { (_, _, dataResult) -> Void in
//            guard dataResult.error == nil else{
//                print("捕获数据失败")
//                return
//            }
//            
//            let data = JSON(dataResult.value!)["others"]
//            print(data)
//            
//            for i in 0..<data.count {
//                let ID = String(data[i]["id"])
//                let name = String(data[i]["name"])
//                self.sideArray.append(SideModel(id: ID, name: name))
//            }
//            
//        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
























