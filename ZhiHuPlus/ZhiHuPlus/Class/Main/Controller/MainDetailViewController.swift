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
    @IBOutlet weak var webView: UIWebView!
    
    var index = 1
    var detailId = ""
    
    //接口返回的数据
    var imageUrl = ""//图片
    var image_source = ""
    var share_url = ""
    var type = ""
    var titleStr = ""
    

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
            print(json)
            let bodyStr = json["body"] as! String
            let cssStr:String = json["css"]!![0] as! String
            
            self.imageUrl = json["image"] as! String
            self.image_source = json["image_source"] as! String
            self.share_url = json["share_url"] as! String
            self.titleStr = json["title"] as! String
            
//            print(bodyStr)
//            print(cssStr)
            
            var html = "<html> <head>"
            html += "<link rel=\"stylesheet\" href="
            html += cssStr
            html += "</head>"
            html += bodyStr
            html += "</body> </html>"
           
//            print(html)
//            let url:NSURL = NSURL(string: html)!
//            let reqest:NSURLRequest = NSURLRequest(URL:url)
//            self.webView.loadRequest(reqest)
           
            //加载网页数据OK
            self.webView.loadHTMLString(html, baseURL: nil)
        }) { (error) -> Void in
            print("获取数据失败")
        }
    }

    func webViewDidStartLoad(webView: UIWebView) {
        print(__FUNCTION__)
    }
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        print(__FUNCTION__)
    }
    func webViewDidFinishLoad(webView: UIWebView) {
        print(__FUNCTION__)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 

}
/**

css =     (
"http://news-at.zhihu.com/css/news_qa.auto.css?v=77778"
);
"ga_prefix" = 021918;
id = 7893543;
image = "http://pic4.zhimg.com/f736ad28bdf27bd5369030858713dbcb.jpg";
"image_source" = "TFBOYS-\U6613\U70ca\U5343\U73ba / \U65b0\U6d6a\U5fae\U535a";
js =     (
);
"share_url" = "http://daily.zhihu.com/story/7893543";
title = "\U6613\U70ca\U5343\U73ba\U90fd\U4e0a\U9ad8\U4e2d\U4e86\Uff0c\U751f\U75c5\U8fd8\U5f97\U770b\U513f\U79d1\Uff0c\U6ca1\U9519";
type = 0;


*/











