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
    @IBOutlet weak var ratingTextLabel: UILabel!
    
    var info = ""
    var points = Points()
    var userRating : Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.ratingTextLabel.text = "Would you like to rate the eco-friendliness of this product differently?"
        self.cosmosView.didTouchCosmos = didTouchCosmos
        self.cosmosView.didFinishTouchingCosmos = didFinishTouchingCosmos
        self.cosmosView.settings.fillMode = .half
            
        self.cosmosView.rating = self.points.totalRating
        print ("Existing rating is \(self.points.totalRating)")
        
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
        
    }
    
    @IBAction func okButtonTapped(_ sender: Any) {
        updateRating()
        // Dismiss the view controller (the first screen) that
        // was presented modally by the view controller
        dismiss(animated: true, completion: nil)
    }
    
    private func updateRating() {
        // cosmosView.rating is the default rating value
        print("Updated rating to \(cosmosView.rating)")
        var idx = 0
        
        let totalRef = FIRDatabase.database().reference().child("products")
        totalRef.observeSingleEvent(of: .value, with: {(snapshot) in
            //print(snapshot.childrenCount)
            let enumerator = snapshot.children
            while let rest = enumerator.nextObject() as? FIRDataSnapshot {
                //print(rest.value!)
                
                let product = Product()
                product.productName = (rest.value! as AnyObject)["product_name"] as! String
                product.totalCount = (rest.value! as AnyObject)["totalCount"] as! Int
                product.totalRating = (rest.value! as AnyObject)["totalRating"] as! Double
                
                idx += 1
                
                //print("\(product.productName) and \(self.points.receivedFor)")
                
                if product.productName == self.points.receivedFor {
                    //print("points for \(product.productName)")
                    
                    if (self.userRating != nil) {
                        let count = product.totalCount + 1
                        let total = (product.totalRating + self.userRating) / Double(count)
                        let childUpdates = ["/\(idx-1)/totalRating" : total, "/\(idx-1)/totalCount" : count] as [String : Any]
                        
                        print("Child Update: \(childUpdates)")
                        totalRef.updateChildValues(childUpdates)
                    }
                }
                
            }
        })
        /*totalRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            total = (snapshot.value! as AnyObject)["total"] as! Int
            total += product.green
            print ("Total: \(total)")
            
            let childUpdates = ["/total" : total]
            print("Child Update: \(childUpdates)")
            totalRef.updateChildValues(childUpdates)
            
            points.total = total
            self.performSegue(withIdentifier: "productModalSegue", sender: points)
        }) */
    }
    
    private class func formatValue(_ value: Double) -> String {
        return String(format: "%.2f", value)
    }
    
    private func didTouchCosmos(_ rating: Double) {
        // this is the value the user picked
        
        self.userRating = rating
        print("User's rating is \(self.userRating)")
        
        //ratingSlider.value = Float(rating)
        //ratingLabel.text = ViewController.formatValue(rating)
        //ratingLabel.textColor = UIColor(red: 133/255, green: 116/255, blue: 154/255, alpha: 1)
    }
    
    private func didFinishTouchingCosmos(_ rating: Double) {
        //ratingSlider.value = Float(rating)
        //self.ratingLabel.text = ViewController.formatValue(rating)
        //ratingLabel.textColor = UIColor(red: 183/255, green: 186/255, blue: 204/255, alpha: 1)
        print("Finished touching cosmos view")
    }
}
