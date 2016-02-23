//
//  LaunchController.swift
//  ZhiHuPlus
//
//  Created by Fengtf on 16/2/23.
//  Copyright © 2016年 ftf. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

    @IBOutlet weak var launchView: JSAnimatedImagesView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
    }
    
    func loadData(){
        APIManager.get("http://news-at.zhihu.com/api/4/start-image/1080*1776", params: nil, success: { (json) -> Void in
            print(json)
            
//            NSNotificationCenter.defaultCenter().postNotificationName(ADImageLoadSecussed, object: image)

            
            }) { (error) -> Void in
                print(error)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 

}
