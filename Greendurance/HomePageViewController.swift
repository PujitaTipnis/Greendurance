//
//  HomePageViewController.swift
//  Greendurance
//
//  Created by Pujita Tipnis on 3/13/17.
//  Copyright © 2017 Pujita Tipnis. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomePageViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var badgesButton: UIBarButtonItem!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    let resuseIdentifier = "cell"
    var items = ["groceriesBtn.png", "bicycle-rider.png", "trash-container-for-recycle.png", "medal.png", "open-book-top-view.png", "icon.png"]
    var titles = ["Shop Green", "Ride Clean", "Dispose", "Badges", "Facts & Tips", "Friends"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        welcomeLabel.text = "Welcome \(FIRAuth.auth()!.currentUser!.email!)"
        
    }

    @IBAction func logoutTapped(_ sender: Any) {
        // Dismiss the view controller (the first screen) that
        // was presented modally by the view controller
        dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    // make a cell for each cell indexPath
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: resuseIdentifier, for: indexPath as IndexPath) as! IconCollectionViewCell
        
        // use the outlet in our custom class to get a reference to the Button in our cell
        //cell.IconButton.sd_setImage(with: URL(string: self.items[indexPath.count]))
        //cell.MyLabel.text = self.items[indexPath.item]
        //cell.iconButton.setImage(UIImage(named: self.items[indexPath.item]), for: UIControlState.normal)
        
        let btnImage = UIImage(named:self.items[indexPath.item])
        cell.iconButton.setImage(btnImage, for: UIControlState.normal)
        //cell.iconButton.setBackgroundImage(btnImage, for: UIControlState.normal)
        //cell.iconButton.setTitle("Button", for: UIControlState.normal)
        cell.iconLabel.text = self.titles[indexPath.item]
        
        return cell
        
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.item)!")
    }
}
