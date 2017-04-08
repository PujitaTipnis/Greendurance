//
//  DisposalHelpModalViewController.swift
//  Greendurance
//
//  Created by Pujita Tipnis on 4/7/17.
//  Copyright © 2017 Pujita Tipnis. All rights reserved.
//

import UIKit

class DisposalHelpModalViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    
    let help = "This section contains the list of products you purchased and are yet to dispose after consumption. It categorizes the waste into three sections: 'Trash', 'Recycle' and 'Compost'. Once you purchase a product and win points for it under the 'Groceries' section, the product automatically gets added to this section under the relevant category based on its packaging, to make it easier for you to make waste disposal decisions."
    
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
