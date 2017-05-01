//
//  RankingViewController.swift
//  Greendurance
//
//  Created by Pujita Tipnis on 3/29/17.
//  Copyright © 2017 Pujita Tipnis. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RankingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var friends : [Friend] = []
    
    let cellId = "rankingID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let ref = FIRDatabase.database().reference().child("users").queryOrdered(byChild: "total")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            let enumerator = snapshot.children
            while let rest = enumerator.nextObject() as? FIRDataSnapshot {
                //print(rest.value!)
                
                let friend = Friend()
                
                friend.email = (rest.value! as AnyObject)["email"] as! String
                if friend.email == FIRAuth.auth()?.currentUser?.email {
                    friend.name = "You"
                } else {
                    friend.name = (rest.value! as AnyObject)["name"] as! String
                }
                
                //friend.name = (rest.value! as AnyObject)["name"] as! String
                friend.total = (rest.value! as AnyObject)["total"] as! Int
                
                self.friends.append(friend)
                self.friends.sort(by: {($0.total > $1.total)})
                
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
                
            }
        })
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserCell
        
        if friends.count == 0 {
            cell.textLabel?.text = ""
        } else {
            
            let friend = friends[indexPath.row]
            
            cell.textLabel?.text = friend.name
            cell.detailTextLabel?.text = "Total points: \(friend.total)"
            cell.detailTextLabel?.numberOfLines = 1
            
            //if friend.friendURL != nil {
            //    cell.imageView?.image = UIImage(named: "user.png")
            //} else {
            //cell.imageView?.sizeThatFits(CGSize(width: 32, height: 32))
            //cell.imageView?.image = UIImage(named: "user.png")
            //}
        }
        
        return cell
    }
    
}

class UserCell : UITableViewCell {
    
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
