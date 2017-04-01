//
//  DisposalViewController.swift
//  Greendurance
//
//  Created by Pujita Tipnis on 3/29/17.
//  Copyright © 2017 Pujita Tipnis. All rights reserved.
//

import UIKit

class DisposalViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "TRASH"
        } else if section == 1 {
            return "RECYCLE"
        } else {
            return "COMPOST"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 5
        } else if section == 1 {
            return 5
        } else {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*let pokemon : Pokemon
        
        if indexPath.section == 0 {
            pokemon = caughtPokemon[indexPath.row]
        } else {
            pokemon = uncaughtPokemon[indexPath.row]
        }
        
        let cell = UITableViewCell()
        cell.textLabel?.text = pokemon.name
        cell.imageView?.image = UIImage(named: pokemon.imageName!) */
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "disposeID", for: indexPath)
        
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "disposeID")
        
        /*if products.count == 0 {
            cell.textLabel?.text = " "
        } else {
            
            let product = products[indexPath.row] */
            
            cell.textLabel?.text = "Test"
            cell.detailTextLabel?.text = "+"
        //cell.imageView?.image = UIImage(named: pokemon.imageName!)
        
        return cell
    }

}
