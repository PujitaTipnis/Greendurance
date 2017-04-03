//
//  FriendsViewController.swift
//  Greendurance
//
//  Created by Pujita Tipnis on 3/29/17.
//  Copyright © 2017 Pujita Tipnis. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class FriendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var friends : [Friend] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        let ref = FIRDatabase.database().reference().child("users")
        ref.observeSingleEvent(of: .value, with: {(snapshot) in
            print("Friends count: \(snapshot.childrenCount)")
            let enumerator = snapshot.children
            while let rest = enumerator.nextObject() as? FIRDataSnapshot {
                //print(rest.key)
                
                let friend = Friend()
                //friend.name = (rest.value! as AnyObject)["fullName"] as! String
                friend.email = (rest.value! as AnyObject)["email"] as! String
                friend.key = rest.key
                friend.total = (rest.value! as AnyObject)["total"] as! Int
                //print("Trash key: \(disposal.key)")
                
                self.friends.append(friend)
                
                self.tableView.reloadData()
                
            }
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if friends.count == 0 {
            return 1
        } else {
            return friends.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendID") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "friendID")
        
        //let cell = UITableViewCell()
        
        if friends.count == 0 {
            cell.textLabel?.text = " "
        } else {
            
            let friend = friends[indexPath.row]
            
            cell.textLabel?.text = friend.email
            cell.detailTextLabel?.text = "Total points earned: \(friend.total)"
            //print(product.imageURL)
            //cell.imageView?.sd_setImage(with: URL(string: badge.badgeURL))
            /*if let url = NSURL(string: badge.badgeURL) {
             if let data = NSData(contentsOf: url as URL) {
             cell.imageView?.image = UIImage(data: data as Data)
             }
             } */
            cell.imageView?.image = UIImage(named: "user.png")
        }
        
        return cell
    }

}
