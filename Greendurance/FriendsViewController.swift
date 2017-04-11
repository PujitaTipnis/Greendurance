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
    
    let cellId = "friendID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(FriendCell.self, forCellReuseIdentifier: cellId)
        
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let ref = FIRDatabase.database().reference().child("users").child((FIRAuth.auth()?.currentUser?.uid)!).child("friends")
        ref.observeSingleEvent(of: .value, with: {(snapshot) in
            print("Friends count: \(snapshot.childrenCount)")
            let enumerator = snapshot.children
            while let rest = enumerator.nextObject() as? FIRDataSnapshot {
                //print("Friend Rest key: \(rest.key)")
                
                let friend = Friend()
                friend.name = (rest.value! as AnyObject)["friendName"] as! String
                friend.email = (rest.value! as AnyObject)["friendEmail"] as! String
                friend.key = rest.key
                friend.total = (rest.value! as AnyObject)["friendTotal"] as! Int
                
                self.friends.append(friend)
                
                /*DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })*/
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: "friendID") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "friendID")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! FriendCell
        
        //let cell = UITableViewCell()
        
        if friends.count == 0 {
            cell.textLabel?.text = "No friends added yet"
        } else {
            
            let friend = friends[indexPath.row]
            
            cell.textLabel?.text = friend.name
            cell.detailTextLabel?.text = "Total points earned: \(friend.total)"
            //cell.imageView?.image = UIImage(named: "user.png")
            
            //let friendProfileUrl = product.imageURL
            //let friendProfileUrl = "user.png"
            
            //cell.friendImageView.loadImageUsingCacheWithUrlString(urlString: friendProfileUrl)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if friends.count != 0 {
            let friend = Friend()
            friend.name = friends[indexPath.row].name
            self.performSegue(withIdentifier: "myFriendsSegue", sender: friend)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "myFriendsSegue" {
                let nextVC = segue.destination as! AddSelectedFriendViewController
                nextVC.friend = sender as! Friend
                nextVC.navigationItem.leftItemsSupplementBackButton = true
        }
        
    }
    
}

class FriendCell : UITableViewCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel?.frame = CGRect(x: 64, y: textLabel!.frame.origin.y - 2, width: textLabel!.frame.width, height: textLabel!.frame.height)
        
        detailTextLabel?.frame = CGRect(x: 64, y: detailTextLabel!.frame.origin.y + 2, width: detailTextLabel!.frame.width, height: detailTextLabel!.frame.height)
    }
    
    let friendImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "user.png")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 24
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        addSubview(friendImageView)
        friendImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        friendImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        friendImageView.widthAnchor.constraint(equalToConstant: 48).isActive = true
        friendImageView.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

