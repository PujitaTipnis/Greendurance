//
//  BadgesViewController.swift
//  Greendurance
//
//  Created by Pujita Tipnis on 3/29/17.
//  Copyright © 2017 Pujita Tipnis. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class BadgesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var badges : [Badge] = []
    let cellId = "badgeID"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(BadgeCell.self, forCellReuseIdentifier: cellId)
        
        let ref = FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("badges")
        ref.observeSingleEvent(of: .value, with: {(snapshot) in
            print("Badges count: \(snapshot.childrenCount)")
            let enumerator = snapshot.children
            while let rest = enumerator.nextObject() as? FIRDataSnapshot {
                //print(rest.value!)
                
                let badge = Badge()
                badge.badgeName = (rest.value! as AnyObject)["badgeName"] as! String
                badge.badgeDesc = (rest.value! as AnyObject)["badgeDesc"] as! String
                badge.key = (rest.value! as AnyObject)["key"] as! String
                badge.badgeURL = (rest.value! as AnyObject)["badgeURL"] as! String
                badge.badgeSmallURL = (rest.value! as AnyObject)["badgeSmallURL"] as! String
                badge.points = (rest.value! as AnyObject)["points"] as! Int
                //print("Trash key: \(disposal.key)")
                
                self.badges.append(badge)
                
                self.tableView.reloadData()
                
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
        if badges.count == 0 {
            return 1
        } else {
            return badges.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: "badgeID") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "badgeID")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! BadgeCell
        
        //let cell = UITableViewCell()
        
        if badges.count == 0 {
            cell.textLabel?.text = "No badges earned yet"
        } else {
            
            let badge = badges[indexPath.row]
            
            cell.textLabel?.text = badge.badgeName
            cell.detailTextLabel?.text = badge.badgeDesc
            cell.detailTextLabel?.numberOfLines = 3
            //print(product.imageURL)
            //cell.imageView?.sd_setImage(with: URL(string: badge.badgeURL))
            /*if let url = NSURL(string: badge.badgeURL) {
                if let data = NSData(contentsOf: url as URL) {
                    cell.imageView?.image = UIImage(data: data as Data)
                }
            } */
            //cell.imageView?.image = UIImage(named: "\(badge.badgeURL)")
            //cell.imageView?.image = UIImage(named: badge.badgeURL)
            if badge.badgeURL != nil {
                cell.imageView?.image = UIImage(named: badge.badgeSmallURL)
            } else {
                cell.imageView?.image = UIImage(named: "sproutSmall.png")
            }
        }
        
        return cell
    }

}

class BadgeCell : UITableViewCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel?.frame = CGRect(x: 64, y: textLabel!.frame.origin.y - 2, width: textLabel!.frame.width, height: textLabel!.frame.height)
        
        detailTextLabel?.frame = CGRect(x: 64, y: detailTextLabel!.frame.origin.y + 2, width: detailTextLabel!.frame.width, height: detailTextLabel!.frame.height)
        
    }
    
    let badgeImageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.image = UIImage(named: "medal.png")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 24
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        addSubview(badgeImageView)
        badgeImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        badgeImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        badgeImageView.widthAnchor.constraint(equalToConstant: 48).isActive = true
        badgeImageView.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

