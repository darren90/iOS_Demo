//
//  MainViewController.swift
//  ZhiHuPlus
//
//  Created by Fengtf on 16/2/17.
//  Copyright © 2016年 ftf. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController,SDCycleScrollViewDelegate,ParallaxHeaderViewDelegate {
    
    //时间数组
    var dateArray:[String] = []

    @IBOutlet weak var titleItem: UINavigationItem!
    var cycleScrollView: SDCycleScrollView!
    var animator: ZFModalTransitionAnimator!
    var loadCircleView: PNCircleChart!//刷新控件
    var loadingView: UIActivityIndicatorView!//正在刷新控件

    var dragging = false
    var triggered = false
    
    var bannerArray:[HomeModel] = []//轮播的数组
    var dataArray: [HomeModel] = []//轮播以下的数组
    
    //查看详情后，再次进入主界面，刷新，显示为灰色字体
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = 90//UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 50
        self.tableView.showsVerticalScrollIndicator = false
   
        let leftButton = UIBarButtonItem(image: UIImage(named: "menu"), style: .Plain, target: self.revealViewController(), action: "revealToggle:")
        self.navigationItem.setLeftBarButtonItem(leftButton, animated: false)
        
        setNavBar()
        
        //设置透明NavBar
        self.navigationController?.navigationBar.lt_setBackgroundColor(UIColor.clearColor())
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        //设置刷新控件
        
        let titleItemW = (self.titleItem.title! as NSString).sizeWithAttributes(nil).width
        
        let startX = (self.view.frame.width - titleItemW - 60) / 2
        let startY:CGFloat = 12.0
        loadCircleView = PNCircleChart(frame: CGRect(x: startX, y: startY, width: 15, height: 15), total: 100, current: 0, clockwise: true, shadow: false, shadowColor: nil, displayCountingLabel: false, overrideLineWidth: 1)
        loadCircleView.backgroundColor = UIColor.clearColor()
        loadCircleView.strokeColor = UIColor.whiteColor()
        loadCircleView.strokeChart()
        loadCircleView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        self.navigationController?.navigationBar.addSubview(loadCircleView)
        
        //初始化下拉加载loadingView
        loadingView = UIActivityIndicatorView(frame: CGRect(x: startX+2.5, y: startY, width: 10, height: 10))
        self.navigationController?.navigationBar.addSubview(loadingView)
  
        getHomeData { () -> () in
            
        }
        
        testGetTime()
        
//        tableView.tableFooterView.addc
    }
    
    
    func testGetTime(){
        for i in 0...1000 {
            //1天86400秒
            let dd = NSDate().dateByAddingTimeInterval(28800 - Double(i) * 86400)

            let fm = NSDateFormatter()
            fm.dateFormat = "yyyyMMdd"//20131119
            //formate setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
            fm.timeZone = NSTimeZone.init(forSecondsFromGMT: 0)
            let dateStr = fm.stringFromDate(dd)
            print("date:\(dateStr),week:\(getWeekOfDay(dd))")
            dateArray.append(dateStr)
        }
    }
    
    func getWeekOfDay(date:NSDate) -> String {
        print("dddd2:\(date)")
        let interval = date.timeIntervalSince1970
        let days = Int(interval / 86400)
        let intValue = (days - 3) % 7
        switch intValue {
        case 0:
            return "星期日"
        case 1:
            return "星期一"
        case 2:
            return "星期二"
        case 3:
            return "星期三"
        case 4:
            return "星期四"
        case 5:
            return "星期五"
        case 6:
            return "星期六"
        default:
            break
        }
        return "未取到数据"
    }
    
    func getWeekOfDay2(dateStr:String) -> String {
        let fm = NSDateFormatter()
        fm.dateFormat = "yyyyMMdd"
        let date = fm.dateFromString(dateStr)
        print("dddate:\(date)")
        let interval = date!.timeIntervalSince1970
        let days = Int(interval / 86400)
        let intValue = (days - 3) % 7
        switch intValue {
        case 0:
            return "星期日"
        case 1:
            return "星期一"
        case 2:
            return "星期二"
        case 3:
            return "星期三"
        case 4:
            return "星期四"
        case 5:
            return "星期五"
        case 6:
            return "星期六"
        default:
            break
        }
        return "未取到数据"
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
    
    //MARK - 加载网络数据
    func getHomeData(operate: (()->())?){
        
        APIManager.get("http://news-at.zhihu.com/api/4/news/latest", params: nil, success: { (json) -> Void in
            let homeData:Array = json["stories"] as! Array<[String:AnyObject]>
            let bannerData:Array = json["top_stories"] as! Array<[String:AnyObject]>
//            print(homeData)
            for i in 0 ..< homeData.count   {
//                print(homeData[i])
                let id = String(homeData[i]["id"]!)//int 类型
                let img = homeData[i]["images"]![0] as! String
                let title = homeData[i]["title"] as! String
                self.dataArray.append(HomeModel(id: id, image: img, title: title))
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
            self.cycleScrollView.imageURLStringsGroup = imgs
            self.cycleScrollView.titlesGroup = titles
            
            self.tableView.reloadData()
            operate!()
            }) { (error) -> Void in
            operate!()
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
        
        //保证点击的是TableContentViewCell
        guard tableView.cellForRowAtIndexPath(indexPath) is HomeMainCell else {
            return
        }
        
        jump2Toetail(indexPath.row,isCell: true)
    }
    
    override func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        dragging = false
    }
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        dragging = true
    }
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        //Parallax效果
        let header = self.tableView.tableHeaderView as! ParallaxHeaderView
        header.layoutHeaderViewForScrollViewOffset(scrollView.contentOffset)
        
        //NavBar及titleLabel透明度渐变
        let color = UIColor(red: 1/255.0, green: 131/255.0, blue: 209/255.0, alpha: 1)
        let offsetY = scrollView.contentOffset.y
        let prelude: CGFloat = 90
        
//        print("offsetY:\(offsetY)")
        
        if offsetY >= -64 {
            let alpha = min(1, (64 + offsetY) / (64 + prelude))
            //titleLabel透明度渐变
            (header.subviews[0].subviews[0] as! SDCycleScrollView).titleLabelAlpha = 1 - alpha
            (header.subviews[0].subviews[0].subviews[0] as! UICollectionView).reloadData()
            //NavBar透明度渐变
            self.navigationController?.navigationBar.lt_setBackgroundColor(color.colorWithAlphaComponent(alpha))
            if loadCircleView.hidden != true {
                loadCircleView.hidden = true
            }
            if triggered == true && offsetY == -64 {
                triggered = false
            }
        } else {
            let ratio = (-offsetY - 64)*2
            if ratio <= 100 {
                if triggered == false && loadCircleView.hidden == true {
                    loadCircleView.hidden = false
                }
                loadCircleView.updateChartByCurrent(ratio)
            } else {
                if loadCircleView.current != 100 {
                    loadCircleView.updateChartByCurrent(100)
                }
                //第一次检测到松手
                if !dragging && !triggered {
                    loadCircleView.hidden = true
                    loadingView.startAnimating()
                    //进行刷新，加载网络数据
                    getHomeData { () -> () in
                        self.loadingView.stopAnimating()
                    }
                    triggered = true
                }
            }
        }
        
    }
    
    
 
    //设置滑动极限修改该值需要一并更改layoutHeaderViewForScrollViewOffset中的对应值
    func lockDirection() {
        self.tableView.contentOffset.y = -154
    }
 
//    didSelectItemAtIndex
    func cycleScrollView(cycleScrollView: SDCycleScrollView!, didSelectItemAtIndex index: Int) {
        jump2Toetail(index,isCell: false)
    }
    
    
    func jump2Toetail(index:Int, isCell:Bool){
    
        //拿到webViewController
        let detailVC = self.storyboard?.instantiateViewControllerWithIdentifier("mainDetail") as!MainDetailViewController
        detailVC.index = index
        
        let id:String = self.dataArray[index].id
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
    
    
    //设置StatusBar为白色
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}

