//
//  AddSelectedFriendViewController.swift
//  Greendurance
//
//  Created by Pujita Tipnis on 4/9/17.
//  Copyright © 2017 Pujita Tipnis. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class AddSelectedFriendViewController: UIViewController {
    
    @IBOutlet weak var nameTextLabel: UILabel!
    @IBOutlet weak var pointsTextLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    
    var friend = Friend()
    //var friendPoints : Int = 0
    //var updatedPoints : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        nameTextLabel.text = friend.name
        
        /*let ref = FIRDatabase.database().reference().child("users").queryOrdered(byChild: "name").queryEnding(atValue: friend.name).queryLimited(toLast: 1)
         ref.observeSingleEvent(of: .value, with: { (snapshot) in
         if snapshot.childrenCount == 1 {
         let child : FIRDataSnapshot = snapshot.children.nextObject() as! FIRDataSnapshot
         print(child.value(forKey: "total"))
         
         }
         })*/
        
        //let ref = FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("badges")
        retreiveFriendDetails(name: friend.name)
        
        let ref = FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("friends")
        ref.observeSingleEvent(of: .value, with: {(snapshot) in
            print("Friends count: \(snapshot.childrenCount)")
            let enumerator = snapshot.children
            while let rest = enumerator.nextObject() as? FIRDataSnapshot {
                if (rest.value! as AnyObject)["friendName"] as! String == self.friend.name {
                    self.friend.total = (rest.value! as AnyObject)["friendTotal"] as! Int
                    self.friend.key = (rest.value! as AnyObject)["key"] as! String
                    self.followButton.setTitle("Unfollow", for: .normal)
                }
            }
        })
        
    }
    
    @IBAction func followButtonTapped(_ sender: Any) {
        
        if followButton.titleLabel?.text == "Follow" {
            //print("Button tapped \(self.friend.total)")
            
            let ref = FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("friends").childByAutoId()
            
            self.friend.key = ref.key
            
            let friendDetails = ["friendName" : friend.name,
                                 "friendTotal" : self.friend.total,
                                 "key" : self.friend.key] as [String : Any]
            
            ref.setValue(friendDetails)
            followButton.setTitle("Unfollow", for: .normal)
            //print(followButton.titleLabel?.text)
            
        } else if followButton.titleLabel?.text == "Unfollow" {
            print("Unfollow tapped")
            let ref = FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("friends").child(self.friend.key)
            
            ref.removeValue()
        }
        
    }
    
    func retreiveFriendDetails(name : String) -> Void {
        
        let ref = FIRDatabase.database().reference().child("users")
        ref.observeSingleEvent(of: .value, with: {(snapshot) in
            print("User count: \(snapshot.childrenCount)")
            let enumerator = snapshot.children
            while let rest = enumerator.nextObject() as? FIRDataSnapshot {
                if (rest.value! as AnyObject)["name"] as! String == name {
                    //print(rest.value!)
                    
                    //self.friendPoints = (rest.value! as AnyObject)["total"] as! Int
                    self.friend.total = (rest.value! as AnyObject)["total"] as! Int
                    
                    //self.updatedPoints = self.friendPoints
                    //print(self.friend.total)
                    //print(self.updatedPoints)
                    //self.pointsTextLabel.text = "\(NSString(format: "%@", (totalPoints as? CVarArg)!) as String) points"
                    self.pointsTextLabel.text = "Points Earned: \(self.friend.total)"
                }
            }
        })
    }
}
