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
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var rankingButton: UIButton!
    @IBOutlet weak var rankingLabel: UILabel!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var challengeLabel: UILabel!
    
    let resuseIdentifier = "cell"
    var items = ["groceriesBtn.png", "bicycle-rider.png", "trash-container-for-recycle.png", "medal.png", "open-book-top-view.png", "icon.png"]
    var titles = ["Shop Green", "Ride Clean", "Dispose", "Badges", "Facts & Tips", "Friends"]
    //var newUser : Bool = false
    var total : Int = 0
    
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
        
        /*if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }*/
        
        // Decide what needs to be displayed for logout button
      /*  let currUser = FIRAuth.auth()?.currentUser
        if currUser != nil {
            // Customer is signed-in
            
        } */
        
        // Changeeeeee
        //logoutButton.isEnabled = false
        
        let currUser = FIRAuth.auth()?.currentUser
        //print("Total = \(total)"
        //print("Sender = \(newUser)")
        //if (newUser == "false") {
        if currUser == nil {
            
            rankingButton.isHidden = false

            pointsLabel.isHidden = true
            
            rankingLabel.text = "Ranking"
            activityLabel.text = "Activities"
            challengeLabel.text = "Challenges"
            
            welcomeLabel.isHidden = true
            welcomeDescLabel.isHidden = true
            spiderImageView.isHidden = true
            
        } else {
            
            rankingButton.isHidden = true
            pointsLabel.isHidden = true
            
            rankingLabel.isHidden = true
            activityLabel.isHidden = true
            challengeLabel.isHidden = true
            
            welcomeLabel.isHidden = false
            welcomeDescLabel.isHidden = false
            spiderImageView.isHidden = false
            
        }
        
    }
    
    /*override func viewWillAppear(_ animated: Bool) {
        
    }*/

    @IBAction func logoutTapped(_ sender: Any) {
        // Dismiss the view controller (the first screen) that
        // was presented modally by the view controller
        do {
            try FIRAuth.auth()?.signOut()
            print("Signed out successfully")
            
            rankingButton.isHidden = true
            pointsLabel.isHidden = true
            
            rankingLabel.isHidden = true
            activityLabel.isHidden = true
            challengeLabel.isHidden = true
            
            welcomeLabel.isHidden = false
            welcomeDescLabel.isHidden = false
            spiderImageView.isHidden = false
            
        } catch {}
        
        //dismiss(animated: true, completion: nil)
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
