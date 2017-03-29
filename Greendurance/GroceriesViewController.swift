//
//  GroceriesViewController.swift
//  Greendurance
//
//  Created by Pujita Tipnis on 3/29/17.
//  Copyright © 2017 Pujita Tipnis. All rights reserved.
//

import UIKit

class GroceriesViewController: UIViewController {

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        artistAlbumLabel.text = "Let's scan an album!"
        yearLabel.text = ""
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(setLabels(_:)), name: "AlbumNotification", object: nil)
    }

}
