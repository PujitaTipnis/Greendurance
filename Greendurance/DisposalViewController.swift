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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var total : Int = 0
        let points = Points()
        let pointsRef = FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid)
        
        if indexPath.section == 0 {
            
            pointsRef.observeSingleEvent(of: .value, with: { (snapshot) in
                
                total = (snapshot.value! as AnyObject)["total"] as! Int
                total += 5
                print ("Total: \(total)")
                
                let childUpdates = ["/total" : total]
                print("Child Update: \(childUpdates)")
                pointsRef.updateChildValues(childUpdates)
                
                points.total = total
                print("points sent: \(points.total)")
                self.performSegue(withIdentifier: "disposalModalSegue", sender: points)
            })
            
            print("Delete: \(trashDisposal[indexPath.row].productName) has key \(trashDisposal[indexPath.row].key)")
            
            let ref = FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("products").child(trashDisposal[indexPath.row].key)
            
            ref.removeValue()
            
            
        } else if indexPath.section == 1 {
            
            pointsRef.observeSingleEvent(of: .value, with: { (snapshot) in
                
                total = (snapshot.value! as AnyObject)["total"] as! Int
                total += 5
                print ("Total: \(total)")
                
                let childUpdates = ["/total" : total]
                print("Child Update: \(childUpdates)")
                pointsRef.updateChildValues(childUpdates)
                
                points.total = total
                print("points sent: \(points.total)")
                self.performSegue(withIdentifier: "disposalModalSegue", sender: points)
            })
            
            print("Delete: \(recycleDisposal[indexPath.row].productName) has key \(recycleDisposal[indexPath.row].key)")
            
            let ref = FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("products").child(recycleDisposal[indexPath.row].key)
            
            ref.removeValue()
            
        } else {
            
            pointsRef.observeSingleEvent(of: .value, with: { (snapshot) in
                
                total = (snapshot.value! as AnyObject)["total"] as! Int
                total += 5
                print ("Total: \(total)")
                
                let childUpdates = ["/total" : total]
                print("Child Update: \(childUpdates)")
                pointsRef.updateChildValues(childUpdates)
                
                points.total = total
                print("points sent: \(points.total)")
                self.performSegue(withIdentifier: "disposalModalSegue", sender: points)
            })
            
            print("Delete: \(compostDisposal[indexPath.row].productName) has key \(compostDisposal[indexPath.row].key)")
            
            let ref = FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("products").child(compostDisposal[indexPath.row].key)
            
            ref.removeValue()
            
        }

        //FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("products").childByAutoId().child(disposals[indexPath.row].productName) .removeValue()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "disposalModalSegue" {
            let nextVC = segue.destination as! DisposalModalViewController
            nextVC.points = sender as! Points
        }
    }
    
    /*func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if indexPath.section == 0 {
                print("Delete: \(trashDisposal[indexPath.row].productName) has key \(trashDisposal[indexPath.row].key)")
                
                let ref = FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("products").child(trashDisposal[indexPath.row].key)
                
                ref.removeValue()
                
            } else if indexPath.section == 1 {
                print("Delete: \(recycleDisposal[indexPath.row].productName) has key \(recycleDisposal[indexPath.row].key)")
                
                let ref = FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("products").child(recycleDisposal[indexPath.row].key)
                
                ref.removeValue()
                
            } else {
                print("Delete: \(compostDisposal[indexPath.row].productName) has key \(compostDisposal[indexPath.row].key)")
                
                let ref = FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("products").child(compostDisposal[indexPath.row].key)
                
                ref.removeValue()
                
            }
            tableView.reloadData()
        }
    }*/
    
}
