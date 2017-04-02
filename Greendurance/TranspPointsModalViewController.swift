//
//  TranspPointsModalViewController.swift
//  Greendurance
//
//  Created by Pujita Tipnis on 4/2/17.
//  Copyright © 2017 Pujita Tipnis. All rights reserved.
//

import UIKit

class TranspPointsModalViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    
    var info = ""
    var points = Points()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //print("received total: \(total)")
        info = "Congrats ! You just earned a total of \(points.total) points !"
        textLabel.text = info
    }

    @IBAction func closeTapped(_ sender: Any) {
        
        // Dismiss the view controller (the first screen) that
        // was presented modally by the view controller
        dismiss(animated: true, completion: nil)
        
    }
    
}
