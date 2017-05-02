//
//  FactDescViewController.swift
//  Greendurance
//
//  Created by Pujita Tipnis on 3/13/17.
//  Copyright © 2017 Pujita Tipnis. All rights reserved.
//

import UIKit
import SDWebImage
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class FactDescViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    //var fact = ""
    var fact = Fact()
    //var facts : [Fact] = []
    //var factExists : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /*override func viewWillAppear(_ animated: Bool) {
        
        let ref = FIRDatabase.database().reference().child("facts")
        ref.observeSingleEvent(of: .value, with: {(snapshot) in
            let enumerator = snapshot.children
            while let rest = enumerator.nextObject() as? FIRDataSnapshot {

                if (rest.value! as AnyObject)["category"] as! String == self.fact.category || (self.fact.category == "Local Food" && (rest.value! as AnyObject)["category"] as! String == "LocalFood") {
                    
                    self.categoryLabel?.text = (rest.value! as AnyObject)["category"] as? String
                    
                    let imageURL = (rest.value! as AnyObject)["image"] as? String
                    
                    self.imageView.loadImageUsingCacheWithUrlString(urlString: imageURL!)
                    
                    self.descLabel?.text = (rest.value! as AnyObject)["desc"] as? String
                }
                
            }
        })
    }*/
    
    override func viewWillAppear(_ animated: Bool) {
        self.imageView.image = UIImage(named: fact.imageURL)
    }
    
}
