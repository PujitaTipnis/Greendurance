//
//  CreditsViewController.swift
//  Greendurance
//
//  Created by Pujita Tipnis on 4/6/17.
//  Copyright © 2017 Pujita Tipnis. All rights reserved.
//

import UIKit

class CreditsViewController: UIViewController {

    @IBOutlet weak var backButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        backButton.target = self.revealViewController()
        backButton.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }

}
