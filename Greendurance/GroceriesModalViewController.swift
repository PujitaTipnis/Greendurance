//
//  GroceriesModalViewController.swift
//  Greendurance
//
//  Created by Pujita Tipnis on 3/30/17.
//  Copyright © 2017 Pujita Tipnis. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class GroceriesModalViewController: UIViewController {
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var cosmosView: CosmosView!
    
    var info = ""
    var points = Points()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let ref = FIRDatabase.database().reference().child("users").child((FIRAuth.auth()?.currentUser?.uid)!)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            
            let badgeRef = ref.child("badges").childByAutoId()
            
            if !(snapshot.hasChild("badges")) {
                self.info = "Congrats! You just earned a total of \(self.points.total) points and your very first badge!"
                self.textLabel.text = self.info
                self.imageView.image = UIImage(named: "sprout (1).png")
                
                let badgesDetails = ["badgeName" : "Green Newbie",
                                     "badgeDesc" : "Your very first badge!",
                                     "badgeURL" : "sprout (1).png",
                                     "badgeSmallURL" : "sproutSmall.png",
                                     "points" : self.points.total,
                                     "key" : badgeRef.key] as [String : Any]
                
                badgeRef.setValue(badgesDetails)
                
            } else {
                if self.points.total >= 1500 {
                    
                    self.info = "Congrats! You have had an awesome streak of buying eco-friendly products! You just won the 'Shopping Green' badge by earning a total of \(self.points.total) points!"
                    self.textLabel.text = self.info
                    self.imageView.image = UIImage(named: "groceries.png")
                    
                    let badgesDetails = ["badgeName" : "Shopping Green",
                                         "badgeDesc" : "An awesome streak of buying green products",
                                         "badgeURL" : "groceries.png",
                                         "badgeSmallURL" : "groceriesSmall.png",
                                         "points" : self.points.total,
                                         "key" : badgeRef.key] as [String : Any]
                    
                    badgeRef.setValue(badgesDetails)
                    
                } else if self.points.total >= 500 {
                    
                    self.info = "Congrats! You are going total pro! You just won the 'Going Pro' badge by earning a total of \(self.points.total) points!"
                    self.textLabel.text = self.info
                    self.imageView.image = UIImage(named: "shield2.png")
                    
                    let badgesDetails = ["badgeName" : "Going Pro",
                                         "badgeDesc" : "A worthy badge on receiving 500 points or more",
                                         "badgeURL" : "shield2.png",
                                         "badgeSmallURL" : "shield2Small.png",
                                         "points" : self.points.total,
                                         "key" : badgeRef.key] as [String : Any]
                    
                    badgeRef.setValue(badgesDetails)
                    
                } else {
                    self.info = "Congrats! You just earned a total of \(self.points.total) points!"
                    self.textLabel.text = self.info
                    self.imageView.isHidden = true
                }
            }
        })
        
        
        
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
