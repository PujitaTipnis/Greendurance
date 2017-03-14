//
//  FactDescViewController.swift
//  Greendurance
//
//  Created by Pujita Tipnis on 3/13/17.
//  Copyright © 2017 Pujita Tipnis. All rights reserved.
//

import UIKit
import SDWebImage

class FactDescViewController: UIViewController {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    
    var desc : [String : String] = ["Air" : "Inhaling air pollution takes away at least 1-2 years of a typical human life.", "Plastic" : "Over the last ten years we have produced more plastic than during the whole of the last century.", "Local Food" : "According to the Council on the Environment of New York City (CENYC); Transporting food long distances uses tremendous energy; it takes 435 fossil fuel calories to fly a 5 calorie strawberry from California to New York.", "Water" : "About 6800 gallons of water is required to grow a days food for a family of four.", "Wildlife":"Between 35,000 to 50,000 African Elephants are Poached a Year.", "Meat":"Producing just one hamburger uses enough fossil fuel to drive a small car 20 miles. Of all raw materials and fossil fuels used in the U.S., more than one-third are devoted to raising animals for food."]
    
    var imageURL : [String : String] = ["Air" : "https://firebasestorage.googleapis.com/v0/b/greendurance.appspot.com/o/chimney-324561_960_720.jpg?alt=media&token=0cc98d8f-d926-4e89-995a-73fdf64d15ce", "Plastic" : "https://firebasestorage.googleapis.com/v0/b/greendurance.appspot.com/o/Recyclables.JPG?alt=media&token=684aec7f-efbc-4fb5-be41-02972f5964ef", "Local Food" : "https://firebasestorage.googleapis.com/v0/b/greendurance.appspot.com/o/Ecologically_grown_vegetables.jpg?alt=media&token=33fb8bda-cd93-4b6d-bc6a-90fccf95785d", "Water" : "https://firebasestorage.googleapis.com/v0/b/greendurance.appspot.com/o/drops-of-water-578897_960_720.jpg?alt=media&token=0d959c4a-dcd7-41ba-980c-676fa8b26d57", "Wildlife" : "https://firebasestorage.googleapis.com/v0/b/greendurance.appspot.com/o/Working_Elephant_Vietnam.jpg?alt=media&token=a58e1dc5-4567-4a13-8132-ea68abb28044", "Meat" : "https://firebasestorage.googleapis.com/v0/b/greendurance.appspot.com/o/hamburger-895831_960_720.jpg?alt=media&token=0cc498e5-157e-4d88-9ae9-aef0212d0547"]
    
    var fact = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        categoryLabel.text = fact
        imageView.sd_setImage(with: URL(string: imageURL[fact]!))
        imageView.backgroundColor = UIColor.clear
        descLabel.text = desc[fact]!
    }
    
}
