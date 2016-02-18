//
//  MainViewController.swift
//  ZhiHuPlus
//
//  Created by Fengtf on 16/2/17.
//  Copyright © 2016年 ftf. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {

    var bannerArray:[HomeModel] = []//轮播的数组
    var dataArray: [HomeModel] = []//轮播以下的数组
    
    override func viewDidLoad() {
        super.viewDidLoad()

      let leftButton = UIBarButtonItem(image: UIImage(named: "menu"), style: .Plain, target: self.revealViewController(), action: "revealToggle:")
      self.navigationItem.setLeftBarButtonItem(leftButton, animated: false)

        getHomeData()
    }
    
    func getHomeData(){
        
        APIManager.get("http://news-at.zhihu.com/api/4/news/latest", params: nil, success: { (json) -> Void in
            let homeData:Array = json["stories"] as! Array<[String:AnyObject]>
            let bannerData:Array = json["top_stories"] as! Array<[String:AnyObject]>
    
            for i in 0 ..< homeData.count   {
                let id = homeData[i]["id"] as! String
                let img = homeData[i]["image"] as! String
                let title = homeData[i]["title"] as! String
                self.dataArray.append(HomeModel(id: id, image: img, title: title))
            }
        
            for i in 0 ..< bannerData.count   {
                let id = bannerData[i]["id"] as! String
                let img = bannerData[i]["image"] as! String
                let title = bannerData[i]["title"] as! String
                self.bannerArray.append(HomeModel(id: id, image: img, title: title))
            }
            
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
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
