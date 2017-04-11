//
//  NewbieModalViewController.swift
//  Greendurance
//
//  Created by Pujita Tipnis on 4/9/17.
//  Copyright © 2017 Pujita Tipnis. All rights reserved.
//

import UIKit

class NewbieModalViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    let message = "Congrats! You just won your very first badge!"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        textLabel.text = message
        imageView?.image = UIImage(named: "sprout (1).png")
    }

    @IBAction func closeTapped(_ sender: Any) {
        // Dismiss the view controller (the first screen) that
        // was presented modally by the view controller
        dismiss(animated: true, completion: nil)
    }
}
