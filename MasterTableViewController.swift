//
//  MasterTableViewController.swift
//  FlyDubai
//
//  Created by Aiman Abdullah Anees on 09/07/16.
//  Copyright © 2016 Aiman Abdullah Anees. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftyJSON
import Alamofire
import CoreData

var City:String = ""


class MasterTableViewController: UITableViewController,CLLocationManagerDelegate{
    
    @IBOutlet var Label: UILabel!

    var TitleArray = ["About","Helpline","Explore","Offers"]
    var ImageArray = ["p10","p7","3","4"]
    var AllInfoArray = [String]()
    
    
    
    
    
    
    
    let LocationManager = CLLocationManager()
    
    var LocationLabel:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.LocationManager.delegate = self
        self.LocationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.LocationManager.requestWhenInUseAuthorization()
        self.LocationManager.startUpdatingLocation()
        
        
        

    }
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        CLGeocoder().reverseGeocodeLocation(manager.location!) { (placemarks, error) in
            
            if error != nil{
                print("Error: "+(error?.localizedDescription)!)
                return
                
                
            }
            if placemarks?.count>0
            {
                let pm = placemarks![0] as! CLPlacemark
                self.displayLocationInfo(pm)
                
                
                
            }
        }
    }
    
    func displayLocationInfo(placemark:CLPlacemark)
    {
        AllInfoArray = []
        self.LocationManager.stopUpdatingLocation()
        print(placemark.locality)
        print(placemark.administrativeArea)
        print(placemark.country)
        
        City = placemark.locality!
        self.LocationLabel = placemark.locality!
        
        Label.text = "Welcome to \(City)"
        
        
        let path :String = NSBundle.mainBundle().pathForResource("FlyDubai", ofType: "json")!
        let jsonData = NSData(contentsOfFile: path)
        let readableJSON = JSON(data: jsonData!, options: NSJSONReadingOptions.MutableContainers, error: nil)
        
        for i in 1...3
        {
            var city = "City"
            city += "\(i)"
            if(readableJSON["FlyDubai"][city]["name"].string == City)
            {
                AllInfoArray.append(readableJSON["FlyDubai"][city]["about"].string!)
                AllInfoArray.append(readableJSON["FlyDubai"][city]["helpline"].string!)
                AllInfoArray.append(readableJSON["FlyDubai"][city]["explore"].string!)
                AllInfoArray.append(readableJSON["FlyDubai"][city]["offers"].string!)
                
                
                
            }
        }

        
           }    
    
    
    func locationManager(manager: CLLocationManager,didFailWithError error: NSError)
    {
        print("Error: "+error.localizedDescription)
        
    }


    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return TitleArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let ImageView = cell.viewWithTag(1) as! UIImageView
        ImageView.image = UIImage(named: ImageArray[indexPath.row])
        
        var TextLabel = cell.viewWithTag(2) as! UILabel
        TextLabel.text = TitleArray[indexPath.row]
        
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let TextSelected = TitleArray[indexPath.row]
        
        var DetailVC:DetaitViewController = self.storyboard?.instantiateViewControllerWithIdentifier("DetaitViewController") as! DetaitViewController
        DetailVC.Description = AllInfoArray[indexPath.row]
        
        
        
        
        
        
        
        
        self.presentViewController(DetailVC, animated: true, completion: nil)
    }
   
}
