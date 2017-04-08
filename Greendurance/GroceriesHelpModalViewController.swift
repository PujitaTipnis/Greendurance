//
//  GroceriesHelpModalViewController.swift
//  Greendurance
//
//  Created by Pujita Tipnis on 4/7/17.
//  Copyright © 2017 Pujita Tipnis. All rights reserved.
//

import UIKit

class GroceriesHelpModalViewController: UIViewController {

    
    @IBOutlet weak var textLabel: UILabel!
    
    let help = "This section contains a list of products that a user generally buys from a Grocery Store. On your trip to a store, if you buy a grocery item, serahc for it in this list and get points for purchasing it. Each product is assigned certain points based on the user's perception of how eco-friendly the product is. Go ahead, and rate the product based on your perception too. Once you win points for tapping on a product that you just purchased, the product would appear in the 'Dispose Right' section under the category to which it belongs after consumption."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        textLabel.text = help
    }
    @IBAction func closeTapped(_ sender: Any) {
        // Dismiss the view controller (the first screen) that
        // was presented modally by the view controller
        dismiss(animated: true, completion: nil)
    }

}
