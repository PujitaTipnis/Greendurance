//
//  User.swift
//  Greendurance
//
//  Created by Pujita Tipnis on 4/4/17.
//  Copyright © 2017 Pujita Tipnis. All rights reserved.
//

import Foundation
import FirebaseAuth

struct User {
    
    let uid: String
    let email: String
    
    init(authData: FIRUser) {
        uid = authData.uid
        email = authData.email!
    }
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
    
}
