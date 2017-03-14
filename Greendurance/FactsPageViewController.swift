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
    var facts : [String] = ["Air", "Plastic", "Local Food", "Water", "Wildlife", "Meat"]
    var imageURL = ""
    var desc = ""
    var category = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        
        
        /* FIRDatabase.database().reference().child("facts").child.observe(FIRDataEventType.childAdded, with: {(snapshot) in
            print(snapshot)
            
            //let fact = Fact()
            var factCategory : [String] = snapshot.children.dictionaryWithValues(forKeys: snapshot.key)
            //fact.category = factCategory
            
            let fact = Fact()
            
            fact.desc = (snapshot.value! as AnyObject)["desc"] as! String
            fact.category = snapshot.key
            fact.imageURL = (snapshot.value! as AnyObject)["image"] as! String
            
            self.facts.append(fact) */
            
            self.tableView.reloadData()
        //})
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return facts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let fact = facts[indexPath.row]
        
        cell.textLabel?.text = fact.description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let fact = facts[indexPath.row]
        
        performSegue(withIdentifier: "factDescSegue", sender: fact)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "factDescSegue" {
            let nextVC = segue.destination as! FactDescViewController
            nextVC.fact = sender as! String
        }
    }

    @IBAction func helpTapped(_ sender: Any?) {
        print("Help tapped")
    }
}
