//
//  HomeModel.swift
//  ZhiHuPlus2.0
//
//  Created by Tengfei on 16/2/28.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class HomeModel: NSObject {
    
    var id: String?
    var image: String?
    var title: String?
    
    //为了字典转模型
//    init(dict:[String:AnyObject]){
//        super.init()//用需要调用 super
//        setValuesForKeysWithDictionary(dict)
//    }
//    
//    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
//        
//    }
    
    
    init (id: String, image: String,title:String) {
        self.id = id
        self.image = image
        self.title = title
    }
    
}
