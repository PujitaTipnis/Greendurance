//
//  DisposalModalViewController.swift
//  Greendurance
//
//  Created by Pujita Tipnis on 4/2/17.
//  Copyright © 2017 Pujita Tipnis. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class DisposalModalViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var info = ""
    var points = Points()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //print("received total: \(points.total)")
        //info = "Congrats ! You just earned a total of \(points.total) points !"
        //textLabel.text = info
        
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
                    
                    self.info = "Congrats! You sure are a good samaritan, on your way to disposing waste the right way! You just won the 'Disposing Right' badge by earning a total of \(self.points.total) points!"
                    self.textLabel.text = self.info
                    self.imageView.image = UIImage(named: "recycle.png")
                    
                    let badgesDetails = ["badgeName" : "Disposing Right",
                                         "badgeDesc" : "A good samaritan, on your way to disposing waste the right way",
                                         "badgeURL" : "recycle.png",
                                         "badgeSmallURL" : "recycleSmall.png",
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
    }

    @IBAction func closeTapped(_ sender: Any) {
        // Dismiss the view controller (the first screen) that
        // was presented modally by the view controller
        dismiss(animated: true, completion: nil)
    }
    
}
