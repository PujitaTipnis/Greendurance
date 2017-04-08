//
//  TranspModalViewController.swift
//  Greendurance
//
//  Created by Pujita Tipnis on 3/14/17.
//  Copyright © 2017 Pujita Tipnis. All rights reserved.
//

import UIKit

class TranspModalViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    
    let help = "This section contains tasks related to eco-friendly transportation choices. If you performed any of thes mentioned tasks today, tap on it and win the assigned points."
    
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
