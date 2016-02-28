//
//  HomeViewController.swift
//  ZhiHuPlus2.0
//
//  Created by Tengfei on 16/2/28.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {
    private let HomeIdentifier = "HomeIdentifier"
    private let HomeHeaderHeight = 154
    
    var bannerArray:[HomeModel] = []//轮播的数组
    var dataArray: [HomeModel] = []//轮播以下的数组
    
    var cycleView: SDCycleScrollView!
    var animator: ZFModalTransitionAnimator!
    var loadCircleView: PNCircleChart!//刷新控件
    var loadingView: UIActivityIndicatorView!//正在刷新控件
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        tableView.rowHeight = 90//UITableViewAutomaticDimension
        tableView.showsVerticalScrollIndicator = true
        
        let leftButton = UIBarButtonItem(image: UIImage(named: "menu"), style: .Plain, target: self, action: "drawLeft")
        self.navigationItem.setLeftBarButtonItem(leftButton, animated: false)
        
        setHeader()
        
        getHomeData { () -> () in
            
        }
    }
    
    func setHeader(){
         cycleView = SDCycleScrollView(frame: CGRect(x: 0, y: 0, width: KWidth, height: HomeHeaderHeight))
        cycleView.infiniteLoop = true
        cycleView.delegate = self
        cycleView.autoScrollTimeInterval = 5.0
        cycleView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic
        cycleView.titleLabelTextFont = UIFont.systemFontOfSize(21)
        cycleView.titleLabelHeight = 60
        cycleView.titleLabelAlpha = 1
        
        let headerView : ParallaxHeaderView = ParallaxHeaderView.parallaxHeaderViewWithSubView(cycleView, forSize: CGSize(width: KWidth, height: HomeHeaderHeight)) as! ParallaxHeaderView
        headerView.delegate = self
        self.tableView.tableHeaderView = headerView
    }
    

    //MARK - 加载网络数据
    func getHomeData(operate: (()->())?){
        
        APINetTools.get(APIZ_Latest, params: nil, success: { (json) -> Void in
            let homeData:Array = json["stories"] as! Array<[String:AnyObject]>
            let bannerData:Array = json["top_stories"] as! Array<[String:AnyObject]>
//            print(homeData)
            for i in 0 ..< homeData.count   {
                let homeId = String(homeData[i]["id"]!)
                let img = homeData[i]["images"]![0] as! String
                let title = homeData[i]["title"] as! String
    
                self.dataArray.append(HomeModel(id: homeId, image: img, title: title))
            }
            
            var imgs:[String] = []
            var titles:[String] = []
            
            for i in 0 ..< bannerData.count   {
                //                 print(bannerData[i])
                let id = String(bannerData[i]["id"]!)
                let img = bannerData[i]["image"] as! String
                let title = bannerData[i]["title"] as! String
                imgs.append(img)
                titles.append(title)
                self.bannerArray.append(HomeModel(id: id, image: img, title: title))
            }
            self.cycleView.imageURLStringsGroup = imgs
            self.cycleView.titlesGroup = titles
            
            self.tableView.reloadData()
            operate!()
            }) { (error) -> Void in
                operate!()
        }
    }
    

    func drawLeft(){
        self.mm_drawerController .toggleDrawerSide(.Left, animated: true, completion: nil)
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
        return dataArray.count ?? 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(HomeIdentifier) as! HomeCell
        let model = dataArray[indexPath.row]
        cell.model = model
        return cell
    }


}

extension HomeViewController:SDCycleScrollViewDelegate,ParallaxHeaderViewDelegate{
    
    func cycleScrollView(cycleScrollView: SDCycleScrollView!, didSelectItemAtIndex index: Int) {
        
    }
    
    func lockDirection() {
        
    }
}







