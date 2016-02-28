//
//  LoadingView.swift
//  ZhiHuPlus
//
//  Created by Fengtf on 16/2/23.
//  Copyright © 2016年 ftf. All rights reserved.
//

import UIKit

class LoadingView: UIView {

    var viewWidth: CGFloat = 0
    override var frame: CGRect {
        willSet {
            if frame.size.width == viewWidth {
                self.hidden = true
            }
            super.frame = frame
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        viewWidth = frame.size.width
        backgroundColor = UIColor(red: 48/255.0, green:  197/255.0, blue:  255/255.0, alpha: 1.0)
        self.frame.size.width = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startLoadProgressAnimation() {
        self.frame.size.width = 0
        hidden = false
        weak var tmpSelf = self
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            tmpSelf!.frame.size.width = tmpSelf!.viewWidth * 0.6
            }) { (finish) -> Void in
                let time = dispatch_time(DISPATCH_TIME_NOW,Int64(0.4 * Double(NSEC_PER_SEC)))
                dispatch_after(time, dispatch_get_main_queue(), { () -> Void in
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        tmpSelf!.frame.size.width = tmpSelf!.viewWidth * 0.8
                    })
                })
        }
        
    }
    
    func endLoadProgressAnimation() {
        weak var tmpSelf = self
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            tmpSelf!.frame.size.width = tmpSelf!.viewWidth
            }) { (finish) -> Void in
                tmpSelf!.hidden = true
        }
    }
}
