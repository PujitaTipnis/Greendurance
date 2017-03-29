//
//  SignInViewController.swift
//  Greendurance
//
//  Created by Pujita Tipnis on 3/13/17.
//  Copyright © 2017 Pujita Tipnis. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignInViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var newUser = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func signInTapped(_ sender: Any) {
        FIRAuth.auth()?.signIn(withEmail: userNameTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            
            if error != nil {
                print("Hey we have an error:\(error)")
                FIRAuth.auth()?.createUser(withEmail: self.userNameTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                    print("We tried to create a user")
                    if error != nil {
                        print("Hey we have an error:\(error)")
                    } else {
                        print("User created successfully")
                        self.newUser = "true"
                        FIRDatabase.database().reference().child("users").child(user!.uid).child("email").setValue(user!.email!)
                        
                        self.performSegue(withIdentifier: "SignInSegue", sender: self.newUser)
                    }
                })
            } else {
                self.newUser = "false"
                print("Signed in successfully")
                self.performSegue(withIdentifier: "SignInSegue", sender: self.newUser)
            }
        })
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "SignInSegue" {
            let nextVC = segue.destination as! UINavigationController
            //let homeVC = nextVC.topViewController as! HomePageViewController
            let homeVC = nextVC.viewControllers.first as! HomePageViewController
            homeVC.newUser = newUser
            print("Preparing Segue : \(homeVC.newUser)")
        }
    }
}

