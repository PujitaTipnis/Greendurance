//
//  MenuViewController.swift
//  Greendurance
//
//  Created by Pujita Tipnis on 4/5/17.
//  Copyright © 2017 Pujita Tipnis. All rights reserved.
//

import UIKit
import FirebaseAuth

class MenuViewController: UITableViewController {

    var menuArray = [String]()
    var menuSegue = [String]()
    var menuImages = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        menuSegue = ["Home","Settings","Credits","TermsConditions","PrivacyPolicy","SignOut"]
        menuArray = ["Home","Settings","Credits","Terms & Conditions","Privacy Policy","Sign Out"]
        menuImages = ["home.png","settings.png","gift.png","file.png","padlock.png","logout.png"]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: menuSegue[indexPath.row], for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = menuArray[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = UIColor.darkGray
        
        self.tableView.backgroundColor = UIColor.darkGray
        
        cell.imageView?.image = UIImage(named: menuImages[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 5 {
            do {
                try FIRAuth.auth()?.signOut()
                print("Signed out successfully")
            } catch {}
        }
    }
}
