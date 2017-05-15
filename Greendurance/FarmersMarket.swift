//
//  FarmersMarket.swift
//  Greendurance
//
//  Created by Pujita Tipnis on 5/15/17.
//  Copyright © 2017 Pujita Tipnis. All rights reserved.
//

import Foundation
import MapKit
import AddressBook

class FarmersMarket: NSObject, MKAnnotation {
    let title: String?
    let address: String
    let schedule: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, address: String, schedule: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.address = address
        self.schedule = schedule
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return address
    }
    
    // annotation callout info button opens this mapItem in Maps app
    func mapItem() -> MKMapItem {
        let addressDictionary = [String(kABPersonAddressStreetKey): subtitle]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary)
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title!
        
        return mapItem
    }
    
    class func fromJSON(json: [JSONValue]) -> FarmersMarket? {
        // 1
        var title: String
        if let titleOrNil = json[1].string {
            title = titleOrNil
        } else {
            title = ""
        }
        let address = json[2].string
        let schedule = json[5].string
        
        // 2
        let latitude = (json[6].string! as NSString).doubleValue
        let longitude = (json[7].string! as NSString).doubleValue
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        // 3
        return FarmersMarket(title: title, address: address!, schedule: schedule!, coordinate: coordinate)
    }
}
