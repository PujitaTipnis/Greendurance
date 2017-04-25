//
//  TranspPointsModalViewController.swift
//  Greendurance
//
//  Created by Pujita Tipnis on 4/2/17.
//  Copyright © 2017 Pujita Tipnis. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class TranspPointsModalViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var badgeTextLabel: UILabel!
    
    var info = ""
    var points = Points()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //print("received total: \(total)")
        //info = "Congrats ! You just earned a total of \(points.total) points !"
        //textLabel.text = info
        
        let ref = FIRDatabase.database().reference().child("users").child((FIRAuth.auth()?.currentUser?.uid)!)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            
            let badgeRef = ref.child("badges").childByAutoId()
            
            if !(snapshot.hasChild("badges")) {
                self.info = "Congrats! You just earned a total of \(self.points.total) points and your very first badge!"
                self.textLabel.text = self.info
                self.imageView.image = UIImage(named: "sprout (1).png")
                self.badgeTextLabel.text = "Green Newbie Badge"
                
                let badgesDetails = ["badgeName" : "Green Newbie",
                                     "badgeDesc" : "Your very first badge!",
                                     "badgeURL" : "sprout (1).png",
                                     "badgeSmallURL" : "sproutSmall.png",
                                     "points" : self.points.total,
                                     "key" : badgeRef.key] as [String : Any]
                
                badgeRef.setValue(badgesDetails)
                
            } else {
                if self.points.total >= 2500 {
                    
                    self.info = "Congrats! You have become a complete expert! You just won the ultimate badge and have earned a total of \(self.points.total) points!"
                    self.textLabel.text = self.info
                    self.imageView.image = UIImage(named: "winner.png")
                    self.badgeTextLabel.text = "A Complete Expert Badge"
                    
                    let badgesDetails = ["badgeName" : "A Complete Expert",
                                         "badgeDesc" : "A commendable achievement on earning 2500 points or more",
                                         "badgeURL" : "winner.png",
                                         "badgeSmallURL" : "winnerSmall.png",
                                         "points" : self.points.total,
                                         "key" : badgeRef.key] as [String : Any]
                    
                    badgeRef.setValue(badgesDetails)
                    
                } else if self.points.total >= 1500 {
                    
                    self.info = "Congrats! You just made an achievement on travelling green! You just won the 'Travel Clean' badge by earning a total of \(self.points.total) points!"
                    self.textLabel.text = self.info
                    self.imageView.image = UIImage(named: "electric-car.png")
                    self.badgeTextLabel.text = "Travel Clean Badge"
                    
                    let badgesDetails = ["badgeName" : "Travel Clean",
                                         "badgeDesc" : "An achievement on traveling green",
                                         "badgeURL" : "electric-car.png",
                                         "badgeSmallURL" : "electric-carSmall.png",
                                         "points" : self.points.total,
                                         "key" : badgeRef.key] as [String : Any]
                    
                    badgeRef.setValue(badgesDetails)
                    
                } else {
                    self.info = "Congrats! You just earned a total of \(self.points.total) points!"
                    self.textLabel.text = self.info
                    self.imageView.isHidden = true
                    self.badgeTextLabel.isHidden = true
                }
            }
        })
    }

    @IBAction func closeTapped(_ sender: Any) {
        
        // Dismiss the view controller (the first screen) that
        // was presented modally by the view controller
        dismiss(animated: true, completion: nil)
        
    }
    
}
