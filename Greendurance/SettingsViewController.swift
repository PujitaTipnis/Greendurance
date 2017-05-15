//
//  SettingsViewController.swift
//  Greendurance
//
//  Created by Pujita Tipnis on 4/5/17.
//  Copyright © 2017 Pujita Tipnis. All rights reserved.
//

import UIKit
import MapKit

class SettingsViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet var mapView: MKMapView!
    
    let regionRadius: CLLocationDistance = 1000
    var farmersMktArray = [FarmersMarket]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        backButton.target = self.revealViewController()
        backButton.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        mapView.delegate = self
        
        let initialLocation = CLLocation(latitude: 38.9877839, longitude: -76.9448365)
        centerMapOnLocation(location: initialLocation)
        
        // show farmers market on map
        loadInitialData()
        //print(farmersMktArray.count)
        /*let farmersMarket = FarmersMarket(title: "1.2 The Farmers Market at Maryland",
                                          address: "on Union Street in front of the Cole Student Activities Center, College Park, Maryland, 20742",
                                          schedule: "03.19.2014 to 11.16.2016 Wed: 11:00 AM-3:00 PM;<br> <br> <br> ",
                                          coordinate: CLLocationCoordinate2D(latitude: 38.987320, longitude: -76.946601)) */
        
        mapView.addAnnotations(farmersMktArray)
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func loadInitialData() {
        // 1
        let fileName = Bundle.main.path(forResource: "farmersMarketCP", ofType: "json");
        var readError : NSError?
        var data: NSData = try! NSData(contentsOfFile: fileName!, options: NSData.ReadingOptions.mappedIfSafe)
        
        // 2
        var error: NSError?
        let jsonObject: NSDictionary = try! JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
        
        // 3
        if let jsonObject = jsonObject as? [String: AnyObject], error == nil,
            // 4
            let jsonData = JSONValue.fromObject(object: jsonObject as AnyObject)?["results"]?.array {
            for fmJSON in jsonData {
                if let fmJSON = fmJSON.array,
                    // 5
                    let farmersMarket = FarmersMarket.fromJSON(json: fmJSON) {
                    farmersMktArray.append(farmersMarket)
                }
            }
        }
    }
    
}
