//
//  DataService.swift
//  Greendurance
//
//  Created by Pujita Tipnis on 3/29/17.
//  Copyright © 2017 Pujita Tipnis. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class DataService {
    
    static let dataService = DataService()
    
    private(set) var PACKAGING_OPENFOODPROD = ""
    private(set) var NAME_OPENFOODPROD = ""
    
    static func searchAPI(codeNumber: String) {
        
        // The URL we will use to get out album data from Discogs
        let openFoodProdURL = "\(OPENFOODPROD_AUTH_URL)/\(codeNumber).json"
       
    
        Alamofire.request(openFoodProdURL)
            .responseJSON { response in
                
                var json = JSON(response.result.value!)
                
                let packagingValue = "\(json["results"][0]["packaging"])"
                let productName = "\(json["results"][0]["product_name"])"
                
                self.dataService.PACKAGING_OPENFOODPROD = packagingValue
                self.dataService.NAME_OPENFOODPROD = productName
                
                // Post a notification to let AlbumDetailsViewController know we have some data.
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ProductNotification"), object: nil)
        }
    }
    
}
