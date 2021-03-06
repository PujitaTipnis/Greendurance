//
//  HomePageViewController.swift
//  Greendurance
//
//  Created by Pujita Tipnis on 3/13/17.
//  Copyright © 2017 Pujita Tipnis. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class HomePageViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var welcomeDescLabel: UILabel!
    @IBOutlet weak var spiderImageView: UIImageView!
    @IBOutlet weak var welcomeOldUserLabel: UILabel!
    
    @IBOutlet weak var leafImageView: UIImageView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var progressStatusLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var rankingButton: UIButton!
    @IBOutlet weak var rankingLabel: UILabel!
    
    let resuseIdentifier = "cell"
    var items = ["groceriesBtn.png", "bicycle-rider.png", "trash-container-for-recycle.png", "medal.png", "open-book-top-view.png", "icon.png"]
    var titles = ["Shop Green", "Ride Clean", "Dispose", "Badges", "Facts & Tips", "Friends"]
    //var newUser : Bool = false
    var total : Int = 0
    var statusTotal : Int = 0
    var statusTotalPct : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //let currUser = FIRAuth.auth()?.currentUser
        
        //print("User = \(currUser)")
        //welcomeLabel.text = "Welcome \(FIRAuth.auth()!.currentUser!.email!)"
        
        // Slider Menu code
        
        menuButton.target = self.revealViewController()
        menuButton.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.rankingButton.isHidden = true
        self.pointsLabel.isHidden = true
        self.leafImageView.isHidden = true
        //self.progressView.isHidden = true
        //self.progressStatusLabel.isHidden = true
        self.progressView.progress = 0
        self.progressView.setProgress(0, animated: true)
        
        self.rankingLabel.isHidden = true
        
        self.welcomeLabel.isHidden = true
        self.welcomeDescLabel.isHidden = true
        self.spiderImageView.isHidden = true
        self.welcomeOldUserLabel.isHidden = true
        
        self.collectionView.isScrollEnabled = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //print("View appeared")
        FIRAuth.auth()?.addStateDidChangeListener { auth, user in
            if let user = user {
                // User is signed in.
                
                //print("login happened")
                //print ("See here: \(String(describing: user.email))")
                
                let ref = FIRDatabase.database().reference().child("users").child((FIRAuth.auth()?.currentUser?.uid)!)
                
                ref.child("name").observeSingleEvent(of: .value, with: { (snapshot) in
                    let userName = snapshot.value as! String
                    self.welcomeLabel.text = "Welcome \(userName)"
                    self.welcomeOldUserLabel.text = "Welcome \(userName)"
                    print (userName)
                })
                
                ref.child("total").observeSingleEvent(of: .value, with: { (snapshot) in
                    self.pointsLabel.isHidden = false
                    self.leafImageView.isHidden = false
                    
                    self.statusTotal = snapshot.value as! Int
                    
                    self.pointsLabel.text = "\(NSString(format: "%@", snapshot.value as! CVarArg) as String) \n points"
                    //self.pointsLabel.backgroundColor = UIColor(patternImage: UIImage(named: "leaf.png")!)
                    
                    
                    if self.pointsLabel.text == "0 \n points" {
                        // No points earned yet
                        
                        self.rankingButton.isHidden = true
                        self.pointsLabel.isHidden = true
                        self.leafImageView.isHidden = true
                        
                        //self.progressView.isHidden = true
                        self.progressStatusLabel.isHidden = false
                        self.progressStatusLabel.text = "0 %"
                        
                        self.rankingLabel.isHidden = true
                        
                        self.welcomeLabel.isHidden = false
                        self.welcomeDescLabel.isHidden = false
                        self.spiderImageView.isHidden = false
                        self.welcomeOldUserLabel.isHidden = true
                        
                    } else {
                        // Earned more than zero points
                        
                        self.rankingButton.isHidden = false
                        
                        //self.progressView.isHidden = false
                        self.progressStatusLabel.isHidden = false
                        self.statusTotalPct = Int((Double(self.statusTotal) / 5000.00) * 100.00)
                        self.progressStatusLabel.text = "\(String(describing: self.statusTotalPct)) %"
                        
                        //print (self.statusTotalPct)
                        self.progressView.setProgress(Float(Double(self.statusTotalPct) / 100.00), animated: true)
                        //self.progressView.progress = Float(self.statusTotalPct)
                        
                        self.rankingLabel.text = "Ranking"
                        
                        self.welcomeLabel.isHidden = true
                        self.welcomeDescLabel.isHidden = true
                        self.spiderImageView.isHidden = true
                        self.welcomeOldUserLabel.isHidden = false
                    }
                })
                
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
        // return 3
    }
    
    // make a cell for each cell indexPath
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: resuseIdentifier, for: indexPath as IndexPath) as! IconCollectionViewCell
        
        let btnImage = UIImage(named:self.items[indexPath.item])
        cell.iconButton.setImage(btnImage, for: UIControlState.normal)
        cell.iconButton.isEnabled = false
        cell.iconLabel.text = self.titles[indexPath.item]
        
        cell.iconLabel.backgroundColor = UIColor.init(red: 87/255, green: 183/255, blue: 58/255, alpha: 255/255)
        cell.iconLabel.textColor = UIColor.white
        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.25
        
        //cell.layer.cornerRadius = 8
        
        //cell.iconButton.tag = indexPath.row;
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.item)!")
        let testValue = "Test"
        if (indexPath.item == 0) {
            
            self.performSegue(withIdentifier: "GroceryPageSegue", sender: nil)
            
        } else if (indexPath.item == 1) {
            
            self.performSegue(withIdentifier: "TransportPageSegue", sender: nil)
            
        } else if (indexPath.item == 2) {
            
            self.performSegue(withIdentifier: "DisposalPageSegue", sender: nil)
            
        } else if (indexPath.item == 3) {
            
            self.performSegue(withIdentifier: "BadgesPageSegue", sender: nil)
            
        } else if (indexPath.item == 4) {
            
            self.performSegue(withIdentifier: "FactsPageSegue", sender: nil)
            
        } else if (indexPath.item == 5) {
            
            self.performSegue(withIdentifier: "FriendsPageSegue", sender: nil)
            
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2;
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
     if segue.identifier == "TransportPageSegue" {
     let nextVC = segue.destination as! TransportationPageViewController
     nextVC.testValue = (sender as? String)!
     }
     }*/
    
    @IBAction func rankingButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func activityButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func challengeButtonTapped(_ sender: Any) {
        
    }
}
