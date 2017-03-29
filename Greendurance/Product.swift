//
//  Product.swift
//  Greendurance
//
//  Created by Pujita Tipnis on 3/29/17.
//  Copyright © 2017 Pujita Tipnis. All rights reserved.
//

import Foundation

class Product {
    
    private(set) var prodName: String!
    private(set) var prodPackaging: String!
    
    init(prodName: String, prodPackaging: String) {
        
        // Add a little extra text to the album information
        self.prodName = "Product Name: \n\(prodName)"
        self.prodPackaging = "Packaging Info: \(prodPackaging)"
    }
    
}
