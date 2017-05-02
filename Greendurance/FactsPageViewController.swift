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
    var factImage : [String] = ["co2.png", "water.png", "river.png", "lettuce.png", "hen.png", "forest.png", "ecology (1).png", "cloud.png", "tag.png", "oil.png", "truck.png", "renewable-energy.png", "banana.png", "solar-panels (1).png", "water.png", "lettuce.png"]
    
    var facts : [String] = ["Pollution", "Plastic Bottles", "Why Grasslands are important", "Why shop local?", "The truth about Factory Farms", "Benefits of Urban Forests", "Sustainable Planet", "Attitudes toward Climate Change", "Think Green before you Shop", "Greenwashing", "Reuse, Reduce, and Relocate", "Energy Independence", "Food Waste and Hunger", "The Truth about Solar Energy", "Think before you Drink", "Why Buying Local is Worth Every Cent"]
    
    var factInfographic : [String] = ["pollution01.jpg", "plastic01.jpg", "grasslands01.jpg", "local01.png", "animal01.jpg", "forest01.jpg", "sustainability01.jpg", "climate01.jpg", "shopgreen01.jpg", "greenwashing01.jpeg", "relocate01.jpg", "energy01.jpg", "foodwaste01.jpg", "solarenergy01.png", "plastic02.jpg", "local02.jpg"]
    
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
        cell.imageView?.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        
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
        fact.imageURL = factInfographic[indexPath.row]
        
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
