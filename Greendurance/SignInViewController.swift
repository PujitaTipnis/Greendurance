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
        // 1
        FIRAuth.auth()!.addStateDidChangeListener() { auth, user in
            // 2
            if user != nil {
                // 3
                self.performSegue(withIdentifier: "SignInSegue", sender: nil)
            }
        }
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        FIRAuth.auth()!.signIn(withEmail: userNameTextField.text!, password: passwordTextField.text!)
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Register", message: "Register", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            // 1
            let fullNameField = alert.textFields![0]
            let emailField = alert.textFields![1]
            let passwordField = alert.textFields![2]
            
            // 2
            FIRAuth.auth()?.createUser(withEmail: emailField.text!, password: passwordField.text!, completion: {(user, error) in
                if error == nil {
                    // 3
                    FIRDatabase.database().reference().child("users").child(user!.uid).child("email").setValue(user!.email!)
                    FIRDatabase.database().reference().child("users").child(user!.uid).child("total").setValue(0)
                    FIRDatabase.database().reference().child("users").child(user!.uid).child("name").setValue(fullNameField.text)
                    
                    FIRAuth.auth()!.signIn(withEmail: self.userNameTextField.text!, password: self.passwordTextField.text!)
                }
            })
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addTextField { textFullName in
            textFullName.placeholder = "Enter your full name"
        }
        
        alert.addTextField { textEmail in
            textEmail.placeholder = "Enter your email"
        }
        
        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Enter your password"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
}

extension SignInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTextField {
            passwordTextField.becomeFirstResponder()
        }
        if textField == passwordTextField {
            textField.resignFirstResponder()
        }
        return true
    }
    
}

