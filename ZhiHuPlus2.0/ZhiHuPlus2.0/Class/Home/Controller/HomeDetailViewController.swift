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
    
    let loadingView: LoadingView = LoadingView(frame: CGRectMake(0, 0, CGFloat(KWidth), 3))
    
    
    var isHadImg = true
    let orginalHeight: CGFloat = 223
    var imageUrl = ""//图片
    var image_source = ""
    var share_url = ""
    var type = ""
    var titleStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDetailData(detailId)
        
        //避免因含有navBar而对scrollInsets做自动调整
        self.automaticallyAdjustsScrollViewInsets = false
        
        //避免webScrollView的ContentView过长 挡住底层View
        self.view.clipsToBounds = true
        
        //隐藏默认返回button但保留左划返回
        self.navigationItem.hidesBackButton = true
        self.navigationController?.interactivePopGestureRecognizer?.enabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        //webView的一些设置
        webView.addSubview(loadingView)//添加进度条
        webView.scrollView.delegate = self
        webView.scrollView.clipsToBounds = false
        webView.scrollView.showsHorizontalScrollIndicator = true
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.alwaysBounceVertical = true
        webView.scrollView.alwaysBounceHorizontal = false
        
        setUPSubViews()
    }
    
    
    private func setUPSubViews (){
        blurView = GradientView(frame: CGRectMake(0, -85, self.view.frame.width, orginalHeight + 85), type: TRANSPARENT_GRADIENT_TWICE_TYPE)
        
        //设置顶部图片
        topImgView = UIImageView(frame: CGRectMake(0, 0, self.view.frame.width, orginalHeight))
        topImgView.contentMode = .ScaleAspectFill
        topImgView.addSubview(blurView)
        
        
        //设置顶部图片上的titleLabel
        titleLabel = myUILabel(frame: CGRectMake(15, orginalHeight - 80, self.view.frame.width - 30, 60))
        titleLabel.font = UIFont(name: "STHeitiSC-Medium", size: 21)
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.shadowColor = UIColor.blackColor()
        titleLabel.shadowOffset = CGSizeMake(0, 1)
        titleLabel.verticalAlignment = VerticalAlignmentBottom
        titleLabel.numberOfLines = 0
        topImgView.addSubview(titleLabel)
        
        //设置Image上的Image_sourceLabel
        sourceLabel = UILabel(frame: CGRectMake(15, orginalHeight - 22, self.view.frame.width - 30, 15))
        sourceLabel.font = UIFont(name: "HelveticaNeue", size: 9)
        sourceLabel.textColor = UIColor.lightTextColor()
        sourceLabel.textAlignment = NSTextAlignment.Right
        topImgView.addSubview(sourceLabel)
        
        
        //将其添加到ParallaxView
        headerView = ParallaxHeaderView.parallaxWebHeaderViewWithSubView(topImgView, forSize: CGSizeMake(self.view.frame.width, orginalHeight)) as! ParallaxHeaderView
        headerView.delegate = self
        
        //将ParallaxView添加到webView下层的scrollView上
        self.webView.scrollView.addSubview(headerView)
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


extension HomeDetailViewController:UIScrollViewDelegate,UIWebViewDelegate ,ParallaxHeaderViewDelegate{
    //MARK - webView的代理
    func webViewDidStartLoad(webView: UIWebView) {
        loadingView.startLoadProgressAnimation()
        
        print(__FUNCTION__)
    }
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        print(__FUNCTION__)
    }
    func webViewDidFinishLoad(webView: UIWebView) {
        loadingView.endLoadProgressAnimation()
        
        print(__FUNCTION__)
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        //        print("offsetY:\(offsetY)")
        if offsetY < 0 {//设置图片的放大效果
            //不断设置titleLabel及sourceLabel以保证frame正确
            titleLabel.frame = CGRectMake(15, orginalHeight - 80 - offsetY, self.view.frame.width - 30, 60)
            sourceLabel.frame = CGRectMake(15, orginalHeight - 20 - offsetY, self.view.frame.width - 30, 15)
            //保证frame正确
            blurView.frame = CGRectMake(0, -85 - offsetY, self.view.frame.width, orginalHeight + 85)
            
            topImgView.bringSubviewToFront(titleLabel)
            topImgView.bringSubviewToFront(sourceLabel)
        }
        
        headerView.layoutWebHeaderViewForScrollViewOffset(scrollView.contentOffset)
    }

    //MARK  - ParallaxHeaderViewDelegate代理
    //设置滑动极限 修改该值需要一并更改layoutWebHeaderViewForScrollViewOffset中的对应值
    func lockDirection() {
        self.webView.scrollView.contentOffset.y = -85
    }
}