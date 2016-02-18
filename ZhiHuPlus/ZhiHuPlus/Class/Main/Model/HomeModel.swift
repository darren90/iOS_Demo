//
//  HomeModel.swift
//  ZhiHuPlus
//
//  Created by Fengtf on 16/2/18.
//  Copyright © 2016年 ftf. All rights reserved.
//

import UIKit


//"ga_prefix" = 021807;
//id = 7887694;
//images =         (
//    "http://pic2.zhimg.com/405fae7cef9c0e8f0d891a6d27b854e9.jpg"
//);
//title = "\U8bfb\U8bfb\U65e5\U62a5 24 \U5c0f\U65f6\U70ed\U95e8\Uff1a\U5feb\U53bb\U95ee\U4f60\U5bb6 Siri \U8fd9\U4e24\U4e2a\U95ee\U9898";
//type = 0;

struct HomeModel{
    var id: String
    var image: String
    var title: String
    init (id: String, image: String,title:String) {
        self.id = id
        self.image = image
        self.title = title
    }
 
}
