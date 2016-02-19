//
//  MainDetailViewController.swift
//  ZhiHuPlus
//
//  Created by Fengtf on 16/2/19.
//  Copyright © 2016年 ftf. All rights reserved.
//

import UIKit
import Alamofire

class MainDetailViewController: UIViewController ,UIScrollViewDelegate,UIWebViewDelegate,UIGestureRecognizerDelegate{
    var index = 1
    var detailId = ""
    
    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        //避免因含有navBar而对scrollInsets做自动调整
        self.automaticallyAdjustsScrollViewInsets = false
        
        //避免webScrollView的ContentView过长 挡住底层View
        self.view.clipsToBounds = true
        
        //隐藏默认返回button但保留左划返回
        self.navigationItem.hidesBackButton = true
        self.navigationController?.interactivePopGestureRecognizer?.enabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        self.webView.delegate = self
        //对scrollView做基本配置
        self.webView.scrollView.delegate = self
        self.webView.scrollView.clipsToBounds = false
        self.webView.scrollView.showsHorizontalScrollIndicator = true;
        self.webView.scrollView.showsVerticalScrollIndicator = false
    
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
 
        loadDetailData(detailId)
    }
    
    //加载网页详情数据
    private func loadDetailData(id:String){
        let httpUrl:String = "http://news-at.zhihu.com/api/4/news/" + id

        //拉去数据
        APIManager.get(httpUrl, params: nil, success: { (json) -> Void in
//            print(json)
            let bodyStr = json["body"] as! String
            let cssStr:String = json["css"] as! String
            
            print(bodyStr)
            print(cssStr)
            
            var html = "<html> <head>"
            html += "<link rel=\"stylesheet\" href="
            html += cssStr
            html += "</head>"
            html += bodyStr
            html += "</body> </html>"
           
            print(html)
            //
        }) { (error) -> Void in
            print("获取数据失败")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 

}











