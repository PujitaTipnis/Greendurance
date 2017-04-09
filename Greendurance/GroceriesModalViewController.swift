//
//  GroceriesModalViewController.swift
//  Greendurance
//
//  Created by Pujita Tipnis on 3/30/17.
//  Copyright © 2017 Pujita Tipnis. All rights reserved.
//

import UIKit

class GroceriesModalViewController: UIViewController {
    
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var cosmosView: CosmosView!
    
    var info = ""
    var points = Points()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        info = "Congrats ! You just earned a total of \(points.total) points !"
        textLabel.text = info
        
        print(cosmosView)
    }

    @IBAction func closeTapped(_ sender: Any) {
        // Dismiss the view controller (the first screen) that
        // was presented modally by the view controller
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func okButtonTapped(_ sender: Any) {
        
    }
}
