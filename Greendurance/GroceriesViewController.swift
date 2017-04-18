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

class GroceriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBox: UISearchBar!
    @IBOutlet weak var barcodeScanningButton: UIButton!
    
    var products : [Product] = []
    
    // For the search bar
    var searchActive : Bool = false
    //var data = ["San Francisco","New York","San Jose","Chicago","Los Angeles","Austin","Seattle"]
    var prodString : [String] = []
    var filtered : [String] = []
    
    let cellId = "productID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        searchBox.delegate = self
        
        tableView.register(ProductCell.self, forCellReuseIdentifier: cellId)
        
        let ref = FIRDatabase.database().reference().child("products")
        ref.observeSingleEvent(of: .value, with: {(snapshot) in
            //print(snapshot.childrenCount)
            let enumerator = snapshot.children
            while let rest = enumerator.nextObject() as? FIRDataSnapshot {
                //print(rest.value!)
                
                let product = Product()
                product.imageURL = (rest.value! as AnyObject)["image_url"] as! String
                product.productName = (rest.value! as AnyObject)["product_name"] as! String
                product.packaging = (rest.value! as AnyObject)["packaging"] as! String
                product.green = (rest.value! as AnyObject)["green"] as! Int
                product.totalCount = (rest.value! as AnyObject)["totalCount"] as! Int
                product.totalRating = (rest.value! as AnyObject)["totalRating"] as! Double
                
                self.products.append(product)
                self.prodString.append(product.productName)
                //print("Number of products = \(self.products.count)")
                
                // NEW
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
                //
                
                //self.tableView.reloadData()
                
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
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtered = prodString.filter({ (text) -> Bool in
            let tmp: NSString = text as NSString
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filtered.count
        }
        
        if products.count == 0 {
            return 1
        } else {
            return products.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: "productID") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "productID")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "productID", for: indexPath) as! ProductCell
        
        // if i uncomment the below line, the rows display like they should. But clicking on a cell fails the pgm
        //cell = UITableViewCell(style: .subtitle, reuseIdentifier: "productID")
        if(searchActive){
            cell.textLabel?.text = filtered[indexPath.row]
        } else {
            if products.count == 0 {
                cell.textLabel?.text = " "
            } else {
                
                let product = products[indexPath.row]
                
                cell.textLabel?.text = product.productName
                cell.detailTextLabel?.text = "Earnable points: \(product.green) points"
                //print(product.imageURL)
                //cell.imageView?.sd_setImage(with: URL(string: product.imageURL))
                /* if let url = NSURL(string: product.imageURL) {
                 if let data = NSData(contentsOf: url as URL) {
                 cell.imageView?.image = UIImage(data: data as Data)
                 }
                 } */
                //cell.imageView?.image = UIImage(named: "medal.png")
                //cell.imageView?.contentMode = .scaleAspectFill
                
                let productImageUrl = product.imageURL
                
                cell.productImageView.loadImageUsingCacheWithUrlString(urlString: productImageUrl)
                
                /*let url = NSURL(string: urlString)
                 var request = URLRequest(url:url! as URL);
                 request.httpMethod = "GET"
                 let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
                 
                 //download hit an error so lets return out
                 if error != nil {
                 print(error)
                 return
                 }
                 
                 //download successful
                 DispatchQueue.main.async(execute: {
                 self.image = UIImage(data: data!)
                 })
                 
                 }).resume()
                 } */
                
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var total : Int = 0
        let points = Points()
        let totalRef = FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid)
        
        var product = Product()
        product = products[indexPath.row]
        
        if (product.packaging.contains("vegetable")) {
            //product.green += 15
            product.disposalCategory = "compost"
            
        } else if (product.packaging.contains("glass")) {
            //product.green += 10
            product.disposalCategory = "trash"
            
        } else if (product.packaging.contains("paper")) {
            //product.green += 15
            product.disposalCategory = "recycle"
            
        } else if (product.packaging.contains("plastic")) {
            //product.green += 5
            product.disposalCategory = "recycle"
            
        } else if (product.packaging.contains("can")) {
            //product.green += 5
            product.disposalCategory = "recycle"
            
        }
        
        //print(productSelected)
        
        let ref = FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("products").childByAutoId()
        
        let productSelected = ["productName" : product.productName,
                               "packaging" : product.packaging,
                               "disposalCategory" : product.disposalCategory,
                               "key" : ref.key]
        
        ref.setValue(productSelected)
        
        totalRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            total = (snapshot.value! as AnyObject)["total"] as! Int
            total += product.green
            print ("Total: \(total)")
            
            let childUpdates = ["/total" : total]
            print("Child Update: \(childUpdates)")
            totalRef.updateChildValues(childUpdates)
            
            points.total = total
            points.receivedFor = product.productName
            points.totalCount = product.totalCount
            points.totalRating = product.totalRating
            self.performSegue(withIdentifier: "productModalSegue", sender: points)
        })
        
        //FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("products").childByAutoId().setValue(product.disposalCategory, forKey: "disposalCategory")
        
        print(product.disposalCategory)
        
        //performSegue(withIdentifier: "productModalSegue", sender: points)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "productModalSegue" {
            let nextVC = segue.destination as! GroceriesModalViewController
            nextVC.points = sender as! Points
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    @IBAction func barcodeScannerTapped(_ sender: Any) {
        print("Barcode button tapped")
        self.performSegue(withIdentifier: "barcodeSegue", sender: nil)
    }
}

class ProductCell : UITableViewCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel?.frame = CGRect(x: 64, y: textLabel!.frame.origin.y - 2, width: textLabel!.frame.width, height: textLabel!.frame.height)
        
        detailTextLabel?.frame = CGRect(x: 64, y: detailTextLabel!.frame.origin.y + 2, width: detailTextLabel!.frame.width, height: detailTextLabel!.frame.height)
    }
    
    let productImageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.image = UIImage(named: "medal.png")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 24
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        addSubview(productImageView)
        productImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        productImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        productImageView.widthAnchor.constraint(equalToConstant: 48).isActive = true
        productImageView.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
