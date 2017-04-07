//
//  FactsPageViewController.swift
//  Greendurance
//
//  Created by Pujita Tipnis on 3/13/17.
//  Copyright © 2017 Pujita Tipnis. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FactsPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var factsButton: UIBarButtonItem!
    
    //var facts : [Fact] = []
    var factImage : [String] = ["air.png", "water.png", "lettuce.png", "water-drop.png", "zebra.png", "meat.png"]
    var facts : [String] = ["Air", "Plastic", "Local Food", "Water", "Wildlife", "Meat"]
    //var imageURL = ""
    //var desc = ""
    //var category = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        /*FIRDatabase.database().reference().child("facts").child.observe(FIRDataEventType.childAdded, with: {(snapshot) in
            print(snapshot)
            
            //let fact = Fact()
            var factCategory : [String] = snapshot.children.dictionaryWithValues(forKeys: snapshot.key)
            //fact.category = factCategory
            
            let fact = Fact()
            
            fact.desc = (snapshot.value! as AnyObject)["desc"] as! String
            fact.category = snapshot.key
            fact.imageURL = (snapshot.value! as AnyObject)["image"] as! String
            
            self.facts.append(fact)
            
            self.tableView.reloadData()
        }) */
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if facts.count == 0 {
            return 1
        } else {
            return facts.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        //let fact = facts[indexPath.row]
        
        cell.textLabel?.text = facts[indexPath.row]
        cell.imageView?.sizeThatFits(CGSize(width: 32, height: 32))
        cell.imageView?.image = UIImage(named: factImage[indexPath.row])
        
        //var cell = tableView.dequeueReusableCell(withIdentifier: "factID", for: indexPath)
        
        //cell = UITableViewCell(style: .value1, reuseIdentifier: "factID")
        
        //cell.textLabel?.text = "Test"
        //cell.imageView?.image = UIImage(named: <#T##String#>)
        
        /*if facts.count == 0 {
            cell.textLabel?.text = " "
        } else {
            
            let fact = facts[indexPath.row]
            
            cell.textLabel?.text = fact.category
            //cell.detailTextLabel?.text = ">"
            //print(product.imageURL)
            cell.imageView?.image = UIImage(named: fact.imageURL)
        }*/
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let fact = facts[indexPath.row]
        
        //performSegue(withIdentifier: "factDescSegue", sender: fact)
        
        let fact = Fact()
        //fact = facts[indexPath.row]
        fact.category = facts[indexPath.row]
        
        performSegue(withIdentifier: "factDescSegue", sender: fact)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "factDescSegue" {
            let nextVC = segue.destination as! FactDescViewController
            nextVC.fact = sender as! Fact
        }

    }

    @IBAction func helpTapped(_ sender: Any?) {
        print("Help tapped")
    }
}
