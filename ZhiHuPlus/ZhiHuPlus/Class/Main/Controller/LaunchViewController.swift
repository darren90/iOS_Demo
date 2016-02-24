//
//  LaunchController.swift
//  ZhiHuPlus
//
//  Created by Fengtf on 16/2/23.
//  Copyright © 2016年 ftf. All rights reserved.
//

import UIKit
import SwiftyJSON

class LaunchViewController: UIViewController {

//    @IBOutlet weak var launchView: JSAnimatedImagesView!
    
    @IBOutlet weak var lunchImgView: UIImageView!
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var themLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
//        loadData()
    }
    
    func loadData(){
        APIManager.get("http://news-at.zhihu.com/api/4/start-image/1080*1776", params: nil, success: { (json) -> Void in
            print(json)
            
            let imgStr = JSON(json)["img"].string
            if let imgUrl:String = imgStr {
//                 print(self.lunchImgView)
                
//                self.lunchImgView = UIImageView(image: UIImage(named: "DemoLaunchImage"))
                self.lunchImgView.sd_setImageWithURL(NSURL(string: imgUrl), completed: { (_, _, _, _) -> Void in
                    
                    self.lunchImgView.transform = CGAffineTransformMakeScale(1.0, 1.0)

                    UIView.animateWithDuration(2.0, animations: { () -> Void in
                        self.lunchImgView.transform = CGAffineTransformMakeScale(1.3, 1.3)
                        self.view.alpha = 0.8
                        
                        }, completion: { (_) -> Void in
//                            self.view.alpha = 0.2
                            NSNotificationCenter.defaultCenter().postNotificationName(LunchLoadNotication, object: nil)
//                            let time = dispatch_time(DISPATCH_TIME_NOW,Int64(0.5 * Double(NSEC_PER_SEC)))
//                            dispatch_after(time, dispatch_get_main_queue(), { () -> Void in
//                                
//                                UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.Fade)
//                                
//                                let time1 = dispatch_time(DISPATCH_TIME_NOW,Int64(0.5 * Double(NSEC_PER_SEC)))
//                                dispatch_after(time1, dispatch_get_main_queue(), { () -> Void in
//                                    NSNotificationCenter.defaultCenter().postNotificationName(LunchLoadNotication, object: nil)
//                                })
//                            })
                    })
                })
            }else{
                self.lunchImgView.image = UIImage(named: "DemoLaunchImage")
                NSNotificationCenter.defaultCenter().postNotificationName(LunchLoadNotication, object: nil)
            }

            }) { (error) -> Void in
                print(error)
                self.lunchImgView.image = UIImage(named: "DemoLaunchImage")
                NSNotificationCenter.defaultCenter().postNotificationName(LunchLoadNotication, object: nil)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 

}
