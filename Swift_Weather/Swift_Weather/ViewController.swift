//
//  ViewController.swift
//  Swift_Weather
//
//  Created by Tengfei on 16/1/22.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    let locationManger:CLLocationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        
        if(iOS8()){
            locationManger.requestAlwaysAuthorization()
        }
        locationManger.startUpdatingHeading()
    }
    
    func iOS8() -> Bool{
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

