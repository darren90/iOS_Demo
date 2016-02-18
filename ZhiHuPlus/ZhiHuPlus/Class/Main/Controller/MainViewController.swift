//
//  MainViewController.swift
//  ZhiHuPlus
//
//  Created by Fengtf on 16/2/17.
//  Copyright © 2016年 ftf. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController,SDCycleScrollViewDelegate,ParallaxHeaderViewDelegate {

    var cycleScrollView: SDCycleScrollView!
    
    var bannerArray:[HomeModel] = []//轮播的数组
    var dataArray: [HomeModel] = []//轮播以下的数组
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = 90//UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 50
        self.tableView.showsVerticalScrollIndicator = false
        
        //设置透明NavBar
        self.navigationController?.navigationBar.lt_setBackgroundColor(UIColor.clearColor())
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        setNavBar()

        let leftButton = UIBarButtonItem(image: UIImage(named: "menu"), style: .Plain, target: self.revealViewController(), action: "revealToggle:")
        self.navigationItem.setLeftBarButtonItem(leftButton, animated: false)

        getHomeData()
    }
    
    
    func setNavBar(){
        //配置无限循环scrollView
        cycleScrollView = SDCycleScrollView(frame: CGRectMake(0, 0, self.tableView.frame.width, 154), imageURLStringsGroup: nil)
        
        cycleScrollView.infiniteLoop = true
        cycleScrollView.delegate = self
        cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated
        cycleScrollView.autoScrollTimeInterval = 6.0;
        cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic
        cycleScrollView.titleLabelTextFont = UIFont(name: "STHeitiSC-Medium", size: 21)
        cycleScrollView.titleLabelBackgroundColor = UIColor.clearColor()
        cycleScrollView.titleLabelHeight = 60
        
        //alpha在未设置的状态下默认为0
        cycleScrollView.titleLabelAlpha = 1
        
        //将其添加到ParallaxView
        let headerSubview: ParallaxHeaderView = ParallaxHeaderView.parallaxHeaderViewWithSubView(cycleScrollView, forSize: CGSizeMake(self.tableView.frame.width, 154)) as! ParallaxHeaderView
        headerSubview.delegate  = self
        
        //将ParallaxView设置为tableHeaderView
        self.tableView.tableHeaderView = headerSubview
    }
    
    func getHomeData(){
        
        APIManager.get("http://news-at.zhihu.com/api/4/news/latest", params: nil, success: { (json) -> Void in
            let homeData:Array = json["stories"] as! Array<[String:AnyObject]>
            let bannerData:Array = json["top_stories"] as! Array<[String:AnyObject]>
//            print(homeData)
            for i in 0 ..< homeData.count   {
//                print(homeData[i])
                let id = String(homeData[i]["id"])//int 类型
                let img = homeData[i]["images"]![0] as! String
                let title = homeData[i]["title"] as! String
                self.dataArray.append(HomeModel(id: id, image: img, title: title))
            }
        
            var imgs:[String] = []
            var titles:[String] = []
            
            for i in 0 ..< bannerData.count   {
//                 print(bannerData[i])
                let id = String(bannerData[i]["id"])
                let img = bannerData[i]["image"] as! String
                let title = bannerData[i]["title"] as! String
                imgs.append(img)
                titles.append(title)
                self.bannerArray.append(HomeModel(id: id, image: img, title: title))
            }
            self.cycleScrollView.imageURLStringsGroup = imgs
            self.cycleScrollView.titlesGroup = titles
            
            self.tableView.reloadData()
            }) { (error) -> Void in
                
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.dataArray.count;
    }

  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("homeMain") as! HomeMainCell
        let model = self.dataArray[indexPath.row]
        cell.setModel(model)
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    
    
    
 
    //设置滑动极限修改该值需要一并更改layoutHeaderViewForScrollViewOffset中的对应值
    func lockDirection() {
        self.tableView.contentOffset.y = -154
    }
 
//    didSelectItemAtIndex
    func cycleScrollView(cycleScrollView: SDCycleScrollView!, didSelectItemAtIndex index: Int) {
        
    }

}




//拓展NavigationController以设置StatusBar
extension UINavigationController {
    public override func childViewControllerForStatusBarStyle() -> UIViewController? {
        return self.topViewController
    }
    public override func childViewControllerForStatusBarHidden() -> UIViewController? {
        return self.topViewController
    }
}

