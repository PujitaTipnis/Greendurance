//
//  GroceriesViewController.swift
//  Greendurance
//
//  Created by Pujita Tipnis on 3/29/17.
//  Copyright © 2017 Pujita Tipnis. All rights reserved.
//

import UIKit

class GroceriesViewController: UIViewController {
    
    @IBOutlet weak var productTableView: UITableView!
    @IBOutlet weak var searchBox: UISearchBar!
    @IBOutlet weak var barcodeScanningButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }

    @IBAction func barcodeScannerTapped(_ sender: Any) {
    }
}
