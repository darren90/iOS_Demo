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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    //查看详情后，再次进入主界面，刷新，显示为灰色字体
   
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tableView.reloadData()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(nil , forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = nil
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()

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
        cycleView.titleLabelBackgroundColor = UIColor.clearColor()
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        //保证点击的是TableContentViewCell
        guard tableView.cellForRowAtIndexPath(indexPath) is HomeCell else {
            return
        }
        
        jump2Toetail(indexPath.row,isCell: true)
    }

    override func scrollViewDidScroll(scrollView: UIScrollView) {
        //Parallax效果
        let header = self.tableView.tableHeaderView as! ParallaxHeaderView
        header.layoutHeaderViewForScrollViewOffset(scrollView.contentOffset)

    }
    
    
    func jump2Toetail(index:Int, isCell:Bool){
        //
        //拿到webViewController
        let detailVC = self.storyboard?.instantiateViewControllerWithIdentifier("homeDetail") as!HomeDetailViewController
        detailVC.index = index
        
        let id:String = self.dataArray[index].id!
        detailVC.detailId = id
        
        
        if isCell {
            //取出已经看过详情的数据
            let values = NSUserDefaults.standardUserDefaults().objectForKey(KHadReades)
            if values != nil {
                var readNewsIdArray = values as! [String]
                readNewsIdArray.append(id)
                NSUserDefaults.standardUserDefaults().setObject(readNewsIdArray, forKey: KHadReades)
                NSUserDefaults.standardUserDefaults().synchronize()
            }else {
                NSUserDefaults.standardUserDefaults().setObject([], forKey: KHadReades)
                NSUserDefaults.standardUserDefaults().synchronize()
            }
        }
        
        //对animator进行初始化
        animator = ZFModalTransitionAnimator(modalViewController: detailVC)
        self.animator.dragable = true
        self.animator.bounces = false
        self.animator.behindViewAlpha = 0.7
        self.animator.behindViewScale = 0.9
        self.animator.transitionDuration = 0.7
        self.animator.direction = ZFModalTransitonDirection.Right
        
        //设置webViewController
        detailVC.transitioningDelegate = self.animator
        
        //实施转场
        self.presentViewController(detailVC, animated: true) { () -> Void in
            
        }
    }


}

extension HomeViewController:SDCycleScrollViewDelegate,ParallaxHeaderViewDelegate{
    
    func cycleScrollView(cycleScrollView: SDCycleScrollView!, didSelectItemAtIndex index: Int) {
        jump2Toetail(index,isCell: false)
    }
    
    func lockDirection() {
        self.tableView.contentOffset.y = -CGFloat(HomeHeaderHeight)
    }
    
    
}







