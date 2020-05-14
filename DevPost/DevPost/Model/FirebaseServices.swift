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
                "email": email
            ]
            let ref = Database.database().reference().child("users")
            ref.child(uid).setValue(values)
            ProgressHUD.dismiss()
        }
    }
    
    static func loginUser(with email: String, password: String, vc: UIViewController) {
        ProgressHUD.show("Login up")
        // MARK: - Check if user exit before login into Firebase
        Database.database().reference().child("users").queryOrdered(byChild: "email")
            .queryEqual(toValue: email).observe(.value) { (snapshot) in
                // if user exist: login a user
            if snapshot.exists() {
                Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                    guard let user = user?.user.uid else { return }
                    if user.isEmpty {
                        handleError(error)
                    }
                    // Login user and dismiss login constroller
                    ProgressHUD.dismiss()
                    vc.dismiss(animated: true, completion: nil)
                }
                // else: show error message
            } else {
                ProgressHUD.showError("User does not exist\n Please signup with username and email")
                return
            }
        }
    }
    
    static func updatePassword(with newPassword: String) {
        Auth.auth().currentUser?.updatePassword(to: newPassword, completion: { (error) in
            handleError(error)
            ProgressHUD.showSuccess("Password has been updated. Please logout and login again. Thank you!")
        })
    }
    
    static func updateUserInfo(with username: String) {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        let updatedValues = [
            "username":username
        ]
        Database.database().reference().child("users").child(uid).setValue(updatedValues)
        ProgressHUD.showSuccess("User updated")
    }
    
    static func deleteUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Auth.auth().currentUser?.delete(completion: { (error) in
            handleError(error)
            Database.database().reference().child("users").child(uid).removeValue()
        })
    }
    
    static func fetchUser(closure: @escaping(User) -> ()) {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            guard let uid = auth.currentUser?.uid else { return }
            Database.database().reference().child("users").child(uid).observe(.value) { (snapshot) in
                if let dict = snapshot.value as? [String:Any] {
                    let user = User(dict: dict)
                    closure(user)
                }
            }
        }
    }
    
    static func observeUserPost(closure: @escaping(Posts) -> ()) {
        ProgressHUD.show()
        Database.database().reference().child("posts").observe(.childAdded) { (snapshot) in
            if let postObject = snapshot.value as? [String:Any] {
                let posts = Posts(dict: postObject)
                
                DispatchQueue.main.async {
                    closure(posts)
                }
            }
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
