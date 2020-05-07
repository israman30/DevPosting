//
//  FirebaseServices.swift
//  DevPost
//
//  Created by Israel Manzo on 5/6/20.
//  Copyright © 2020 Israel Manzo. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import ProgressHUD

class FirebaseServices {
    
    static func createUser(with email: String, password: String, username: String) {
        ProgressHUD.show("Sign up")
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            handleError(error)
            
            // Create user object
            guard let uid = user?.user.uid else { return }
            let values = [
                "username": username,
                "email":email
            ]
            let ref = Database.database().reference().child("users")
            ref.child(uid).setValue(values)
            ProgressHUD.dismiss()
        }
    }
    
    static func loginUser(with email: String, password: String) {
        ProgressHUD.show("Login up")
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            guard let user = user?.user.uid else { return }
            if user.isEmpty {
                handleError(error)
            }
            // Login user
            ProgressHUD.dismiss()
        }
    }
    
    
    // MARK: - ERROR HANDLING CREATING/LOGIN A USER
    static func handleError(_ error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            ProgressHUD.showError("Wrong user information..!")
            return
        }
    }
}