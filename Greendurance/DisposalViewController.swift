//
//  DisposalViewController.swift
//  Greendurance
//
//  Created by Pujita Tipnis on 3/29/17.
//  Copyright © 2017 Pujita Tipnis. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class DisposalViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var disposals : [Disposal] = []
    var trashCount = 0
    var recycleCount = 0
    var compostCount = 0
    var trashDisposal : [Disposal] = []
    var recycleDisposal : [Disposal] = []
    var compostDisposal : [Disposal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        //set firebase reference to current user and pull disposal details
        
        let ref = FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("products")
        ref.observeSingleEvent(of: .value, with: {(snapshot) in
            print("Disposal items count: \(snapshot.childrenCount)")
            let enumerator = snapshot.children
            while let rest = enumerator.nextObject() as? FIRDataSnapshot {
                //print(rest.value!)
                
                let disposal = Disposal()
                disposal.productName = (rest.value! as AnyObject)["productName"] as! String
                disposal.disposalCategory = (rest.value! as AnyObject)["disposalCategory"] as! String
                
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
                
                self.disposals.append(disposal)
                
                self.tableView.reloadData()
                
            }
        })
        
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
        //cell.imageView?.image = UIImage(named: pokemon.imageName!)
        
        return cell
        
        /*var cell = tableView.dequeueReusableCell(withIdentifier: "disposeID", for: indexPath)
        
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "disposeID")
        
        /*if products.count == 0 {
            cell.textLabel?.text = " "
        } else {
            
            let product = products[indexPath.row] */
            
            cell.textLabel?.text = "Test"
            cell.detailTextLabel?.text = "+"
        //cell.imageView?.image = UIImage(named: pokemon.imageName!)
        
        return cell */
    }
    
    func getAllTrashValues() -> Int {
        
        var trashCount = 0
        
        let ref = FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("products")
        ref.observeSingleEvent(of: .value, with: {(snapshot) in
            print("Disposal items count: \(snapshot.childrenCount)")
            let enumerator = snapshot.children
            while let rest = enumerator.nextObject() as? FIRDataSnapshot {
                //print(rest.value!)
                
                let disposal = Disposal()
                disposal.disposalCategory = (rest.value! as AnyObject)["disposalCategory"] as! String
                
                if disposal.disposalCategory == "trash" {
                    trashCount += 1
                }
            }
        })
        print ("Trash count = \(trashCount)")
        return trashCount
    }

}
