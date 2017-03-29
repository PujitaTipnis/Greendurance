//
//  TransportationPageViewController.swift
//  Greendurance
//
//  Created by Pujita Tipnis on 3/14/17.
//  Copyright © 2017 Pujita Tipnis. All rights reserved.
//

import UIKit

class TransportationPageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
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
    }
    
    @IBAction func helpTapped(_ sender: Any) {
        print("Help tapped")
    }
}
