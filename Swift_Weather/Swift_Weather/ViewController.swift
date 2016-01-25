//
//  ViewController.swift
//  Swift_Weather
//
//  Created by Tengfei on 16/1/22.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate {
    let locationManger:CLLocationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        locationManger.delegate = self
        if(iOS8()){
            locationManger.requestAlwaysAuthorization()
        }
        locationManger.startUpdatingHeading()
    }
    
    func iOS8() -> Bool{
        let versionStr = UIDevice .currentDevice().systemVersion
        let versionDou:Double = Double(versionStr)!
        return versionDou > 8.0
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var location:CLLocation = locations[locations.count - 1] as CLLocation
        if(location.horizontalAccuracy > 0){
            print(location.coordinate.latitude)
            print(location.coordinate.longitude)

            locationManger.stopUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("error\(error)");
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

