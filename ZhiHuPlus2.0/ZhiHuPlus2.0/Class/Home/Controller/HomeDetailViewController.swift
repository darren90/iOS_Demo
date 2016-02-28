//
//  HomeDetailViewController.swift
//  ZhiHuPlus2.0
//
//  Created by Tengfei on 16/2/28.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit
import SwiftyJSON



class HomeDetailViewController: UIViewController,UIGestureRecognizerDelegate {

    @IBOutlet weak var webView: UIWebView!
    
    //暴露的参数
    var index = 1
    var detailId = ""
    
    //MARK：头部的几个自定义控件
    var topImgView:UIImageView!
    var headerView: ParallaxHeaderView!
    var blurView: GradientView!
    var titleLabel: myUILabel!
    var sourceLabel: UILabel!
    
    let loadingView: LoadingView = LoadingView(frame: CGRectMake(0, 0, KWidth, 3))

    
    
    var isHadImg = true
    let orginalHeight: CGFloat = 223
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
        
        //webView的一些设置
        webView.scrollView.delegate = self
        webView.scrollView.clipsToBounds = false
        webView.scrollView.showsHorizontalScrollIndicator = true
        webView.scrollView.showsVerticalScrollIndicator = false
//        webView.scrollView.alway = false
//        webView.scrollView.
    }
    
    
    
    
    //加载网页详情数据
    private func loadDetailData(id:String){
        let httpUrl:String = "http://news-at.zhihu.com/api/4/news/" + id
        
        //拉去数据
        APINetTools.get(httpUrl, params: nil, success: { (json) -> Void in
            print(json)
            let bodyStr = json["body"] as! String
            let cssStr:String = json["css"]!![0] as! String
            
            if let _ = JSON(json)["image"].string{
                self.imageUrl = json["image"] as! String
                self.image_source = json["image_source"] as! String
                self.share_url = json["share_url"] as! String
                self.titleStr = json["title"] as! String
                self.isHadImg = true
            }else{
                self.isHadImg = false
            }
            
            //            print(bodyStr)
            //            print(cssStr)
            
            var html = "<html> <head>"
            html += "<link rel=\"stylesheet\" href="
            html += cssStr
            html += "</head>"
            html += bodyStr
            html += "</body> </html>"
            
            
            //加载网页数据OK
            self.webView.loadHTMLString(html, baseURL: nil)
            
            self.topImgView.sd_setImageWithURL(NSURL(string: self.imageUrl))
            self.titleLabel.text =  self.titleStr
            self.sourceLabel.text = "图片：" + self.image_source
            }) { (error) -> Void in
                print("获取数据失败")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 

}


extension HomeDetailViewController:UIScrollViewDelegate,UIWebViewDelegate {
    //MARK - webView的代理
    func webViewDidStartLoad(webView: UIWebView) {
//        loadingView.startLoadProgressAnimation()
        
        print(__FUNCTION__)
    }
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        print(__FUNCTION__)
    }
    func webViewDidFinishLoad(webView: UIWebView) {
//        loadingView.endLoadProgressAnimation()
        
        print(__FUNCTION__)
    }

}