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

class FactDescViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    //var fact = ""
    var fact = Fact()
    //var facts : [Fact] = []
    //var factExists : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrollView.maximumZoomScale = 6.0
        self.scrollView.minimumZoomScale = 0.5
        self.scrollView.contentSize = self.imageView.frame.size
        self.scrollView.delegate = self
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
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        
    }
    
}
