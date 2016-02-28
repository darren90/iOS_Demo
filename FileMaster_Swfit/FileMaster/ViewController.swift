//
//  ViewController.swift
//  FileMaster
//
//  Created by Fengtf on 16/2/24.
//  Copyright © 2016年 ftf. All rights reserved.
//

import UIKit


 
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
    func readeFile(sender: UIButton) {
        let path = ( NSHomeDirectory() as NSString ).stringByAppendingPathComponent("Documents")
        let fm = NSFileManager.defaultManager()
        
        var array:[String] = []
        do {
            array = try fm.contentsOfDirectoryAtPath(path)
        }catch {
            print(error)
        }
        for name in array {
            print("name:\(name),,,path:\(path.stringByAppendingString("/\(name)"))")
        }
    }
    
    func writeFile(sender: UIButton) {
        let path = ( NSHomeDirectory() as NSString ).stringByAppendingPathComponent("Documents")
        let fm = NSFileManager.defaultManager()
        let fileName = path.stringByAppendingString("/rrr.png")
        
        let image = createImage()
        let data = UIImagePNGRepresentation(image)
        fm.createFileAtPath(fileName, contents: data, attributes: nil)
    }
    
    func createImage() -> UIImage{
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 300, height: 320), false, 0.0)
        let ctx = UIGraphicsGetCurrentContext()
        let imageRect = CGRect(x: 0.0, y: 0.0, width: 300, height: 320)
        //        UIColor.brownColor().setFill()
        CGContextFillRect(ctx, imageRect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }


}

