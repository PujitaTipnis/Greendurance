//
//  DisposalViewController.swift
//  Greendurance
//
//  Created by Pujita Tipnis on 4/6/17.
//  Copyright © 2017 Pujita Tipnis. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class DisposalViewControllerOldold: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var trashCount = 0
    var recycleCount = 0
    var compostCount = 0
    
    var trashDisposal : [Disposal] = []
    var recycleDisposal : [Disposal] = []
    var compostDisposal : [Disposal] = []
    
    var disposals = [Disposal]()
    var disposalDictionary = [NSDictionary]()
    
    var timer: Timer?
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.checkIfUserIsLoggedIn()
        
        self.observeDisposalItems()
        
        tableView.allowsMultipleSelectionDuringEditing = true
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
            return
        }
        
        let disposal = self.disposals[indexPath.row]
        
        let disposalId = disposal.key
        
        FIRDatabase.database().reference().child("users").child(uid).child("products").child(disposalId).removeValue { (error, ref) in
            if error != nil {
                print("failed to delete the disposal item")
                return
            }
            
            
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "TRASH"
        } else if section == 1 {
            return "RECYCLE"
        } else {
            return "COMPOST"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return trashCount
        } else if section == 1 {
            return recycleCount
        } else {
            return compostCount
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let disp : Disposal
        
        if indexPath.section == 0 {
            disp = trashDisposal[indexPath.row]
        } else if indexPath.section == 1 {
            disp = recycleDisposal[indexPath.row]
        } else {
            disp = compostDisposal[indexPath.row]
        }
        
        let cell = UITableViewCell()
        cell.textLabel?.text = disp.productName
        
        return cell
    }
    
    func observeDisposalItems() {
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
            return
        }
        
        let ref = FIRDatabase.database().reference().child("users").child(uid).child("products")
        
        ref.observeSingleEvent(of: .childAdded, with: { (snapshot) in
            
            let dispID = snapshot.key
            FIRDatabase.database().reference().child("users").child(uid).child("products").child(dispID).observeSingleEvent(of: .childAdded, with: { (snapshot) in
                
                let disposalID = snapshot.key
                //self.fetchDisposalWithDispID(disposalID)
            
            }, withCancel: nil)
        }, withCancel: nil)
    }
    
    func checkIfUserIsLoggedIn() {
        
    }
    
  /*  func fetchDisposalWithDispID(disposalID: String) {
        
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
            return
        }
        
        let dispRef = FIRDatabase.database().reference().child("users").child(uid).child("products").child(disposalID)
        
        dispRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            let enumerator = snapshot.children
            while let rest = enumerator.nextObject() as? FIRDataSnapshot {
                //print(rest.value!)
                
                let disposal = Disposal()
                disposal.productName = (rest.value! as AnyObject)["productName"] as! String
                disposal.disposalCategory = (rest.value! as AnyObject)["disposalCategory"] as! String
                disposal.key = (rest.value! as AnyObject)["key"] as! String
                //print("Trash key: \(disposal.key)")
                
                if (disposal.disposalCategory == "trash") {
                    
                    self.trashCount += 1
                    self.trashDisposal.append(disposal)
                    
                } else if (disposal.disposalCategory == "recycle") {
                    
                    self.recycleCount += 1
                    self.recycleDisposal.append(disposal)
                    
                } else if (disposal.disposalCategory == "compost") {
                    
                    self.compostCount += 1
                    self.compostDisposal.append(disposal)
                    
                }
            
            self.disposalDictionary = tempItems
            self.attemptReloadOfTableView()
            
        }, withCancel: nil)
    }
    
    func attemptReloadOfTableView() {
        self.timer?.invalidate()
        
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector (self.handleReloadTable), userInfo: nil, repeats: false)
    }
    
    func handleReloadTable() {
        
        self.disposals = Array(self.disposalDictionary.values)
        self.disposals.sort { (disposal1, disposal2) -> Bool in
            return disposal1.productName > disposal2.productName
        }
        
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
        })
    } */
}
