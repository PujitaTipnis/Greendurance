//
//  GroceriesModalViewController.swift
//  Greendurance
//
//  Created by Pujita Tipnis on 3/30/17.
//  Copyright © 2017 Pujita Tipnis. All rights reserved.
//

import UIKit

class GroceriesModalViewController: UIViewController {

    
    var product = Product()
    
    @IBOutlet weak var textLabel: UILabel!
    
    var info = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        info = "Congrats ! You just earned \(product.green) more points for purchasing \(product.productName) !"
        textLabel.text = info
    }

    @IBAction func closeTapped(_ sender: Any) {
        // Dismiss the view controller (the first screen) that
        // was presented modally by the view controller
        dismiss(animated: true, completion: nil)
    }
}
