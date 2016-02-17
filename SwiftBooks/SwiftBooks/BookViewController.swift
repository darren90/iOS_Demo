//
//  BookViewController.swift
//  SwiftBooks
//
//  Created by Tengfei on 16/2/1.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class BookViewController: UIViewController {
    
    let identifierBookCell = "BookCell"
    let KeyBooks = "books"
    let URLString = "https://api.douban.com/v2/book/search"
    var tag = "Swift"
    var books = [Book]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetManager.GET(URLString, parameters: ["tag":tag,"start":0,"count":10], success: { (responseObject) -> Void in
            print(responseObject)
//            self.books = []
//            if let dict = responseObject as? [String:NSObject],array = dict[self.KeyBooks] as? [[String:NSObject]] {
//                for dict in array {
//                    self.books.append(Book(dict: dict))
//                }
//                self.tableView.reloadData()
//            }
            }) { (error) -> Void in
                print(error)
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

