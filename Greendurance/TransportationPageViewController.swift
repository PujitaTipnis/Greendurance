//
//  TransportationPageViewController.swift
//  Greendurance
//
//  Created by Pujita Tipnis on 3/14/17.
//  Copyright © 2017 Pujita Tipnis. All rights reserved.
//

import UIKit

class TransportationPageViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var items = ["running.png", "train.png", "car.png", "cycling.png", "bus.png"]
    var titles = ["Walk to work", "Take the metro", "Carpool with friends", "Ride a bike to work", "Take the bus"]
    var points = ["15","10","5","15","10"]
    
    let resuseIdentifier2 = "cellTrans"
    //let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //print("Item count")
        return self.items.count
        
        // return 1
    }
    
    // make a cell for each cell indexPath
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: resuseIdentifier2, for: indexPath as IndexPath) as! TransportCollectionViewCell
        
        let btnImage = UIImage(named:self.items[indexPath.item])
        cell.transIconButton.setImage(btnImage, for: UIControlState.normal)
        cell.transIconLabel.text = self.titles[indexPath.item]
        cell.transPointsLabel.text = "Points earnable: \(self.points[indexPath.item])"
        //cell.transEarnedLabel.text = "Points earned so far: \(self.earned[indexPath.item])"
        
        cell.transIconLabel.backgroundColor = UIColor.init(red: 87/255, green: 183/255, blue: 58/255, alpha: 255/255)
        cell.transIconLabel.textColor = UIColor.white
        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.25
        cell.layer.cornerRadius = 8
        
        //cell.iconButton.tag = indexPath.row;
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.item)!")
        //let testValue = "Test"
        if (indexPath.item == 0) {
            
            print("cell \(indexPath.item) tapped")
            
        } else if (indexPath.item == 1) {
            
            print("cell \(indexPath.item) tapped")
            
        } else if (indexPath.item == 2) {
            
            print("cell \(indexPath.item) tapped")
            
        } else if (indexPath.item == 3) {
            
            print("cell \(indexPath.item) tapped")
            
        } else if (indexPath.item == 4) {
            
            print("cell \(indexPath.item) tapped")
            
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    /*
    var searchText = ""
    var transportTask : [String] = ["Walk to work", "Take the metro", "Carpool with friends", "Use bikesharing today", "Take the bus"]
    var points : [String] = ["10", "7", "5", "10", "7"]
    //var testValue = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transportTask.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "report") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "report")
        
        cell.detailTextLabel?.text = ""
        let task = transportTask[indexPath.row]

        cell.textLabel!.text = task
        //cell.textLabel!.text = testValue
        cell.detailTextLabel?.text = "Earnable points: \(points[indexPath.row])"
        //cell.imageView?.image = UIImage(data: "icon.png" as! Data)
        
        return cell
    } */
    
    @IBAction func helpTapped(_ sender: Any) {
        print("Help tapped")
    }
}
