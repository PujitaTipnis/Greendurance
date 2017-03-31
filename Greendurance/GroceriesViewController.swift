//
//  GroceriesViewController.swift
//  Greendurance
//
//  Created by Pujita Tipnis on 3/29/17.
//  Copyright © 2017 Pujita Tipnis. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class GroceriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBox: UISearchBar!
    @IBOutlet weak var barcodeScanningButton: UIButton!
    
    var products : [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        let ref = FIRDatabase.database().reference().child("products")
        ref.observeSingleEvent(of: .value, with: {(snapshot) in
            print(snapshot.childrenCount) // I got the expected number of items
            let enumerator = snapshot.children
            while let rest = enumerator.nextObject() as? FIRDataSnapshot {
                //print(rest.value!)
                
                let product = Product()
                product.imageURL = (rest.value! as AnyObject)["image_url"] as! String
                product.productName = (rest.value! as AnyObject)["product_name"] as! String
                product.packaging = (rest.value! as AnyObject)["packaging"] as! String
                product.green = (rest.value! as AnyObject)["green"] as! UInt32
                
                self.products.append(product)
                //print("Number of products = \(self.products.count)")
                
                self.tableView.reloadData()

            }
        })
        
        /*let productsRef = FIRDatabase.database().reference().child("products")
        print("Test= \(productsRef.child("0"))")
         
        productsRef.childByAutoId().observe(FIRDataEventType.childAdded, with: {(snapshot) in
            print(snapshot)
            
            let product = Product()
            product.imageURL = (snapshot.value! as AnyObject)["image_url"] as! String
            product.productName = (snapshot.value! as AnyObject)["product_name"] as! String
            product.packaging = (snapshot.value! as AnyObject)["packaging"] as! String
            product.green = (snapshot.value! as AnyObject)["green"] as! UInt32
            
            self.products.append(product)
            print("Number of products = \(self.products.count)")
            
            self.tableView.reloadData()
        }) */
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if products.count == 0 {
            return 1
        } else {
            return products.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: "productID") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "productID")

        var cell = tableView.dequeueReusableCell(withIdentifier: "productID", for: indexPath)
    
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "productID")
        
        if products.count == 0 {
            cell.textLabel?.text = " "
        } else {
            
            let product = products[indexPath.row]
            
            cell.textLabel?.text = product.productName
            cell.detailTextLabel?.text = "Earnable points: \(product.green) points"
            //print(product.imageURL)
            cell.imageView?.image = UIImage(named: "medal.png")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var product = Product()
        product = products[indexPath.row]
        
        performSegue(withIdentifier: "productModalSegue", sender: product)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "productModalSegue" {
            let nextVC = segue.destination as! GroceriesModalViewController
            nextVC.product = sender as! Product
        }
    }

    @IBAction func barcodeScannerTapped(_ sender: Any) {
        print("Barcode button tapped")
    }
}
