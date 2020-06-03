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
    // MARK: - **************** SIGN UP USER ****************
    static func createUser(with email: String, password: String, username: String, vc: UIViewController) {
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
            vc.dismiss(animated: true, completion: nil)
        }
        
    }
    // MARK: - **************** LOGIN UP USER ****************
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
    // MARK: - **************** UPDATE PASSWORD ****************
    static func updatePassword(with newPassword: String) {
        Auth.auth().currentUser?.updatePassword(to: newPassword, completion: { (error) in
            handleError(error)
            ProgressHUD.showSuccess("Password has been updated. Please logout and login again. Thank you!")
        })
    }
    // MARK: - **************** UPDATE USER INFO ****************
    static func updateUserInfo(with username: String, title: String, repo: String) {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        let updatedValues = [
            "username":username,
            "title":title,
            "repo" : repo
        ]
        Database.database().reference().child("users").child(uid).updateChildValues(updatedValues)
        ProgressHUD.showSuccess("User updated")
    }
    // MARK: - **************** DELETE USER ****************
    
    static func deleteUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Auth.auth().currentUser?.delete(completion: { (error) in
            handleError(error)
            Database.database().reference().child("users").child(uid).removeValue()
        })
    }
    // MARK: - **************** FETCH USER ****************
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
    
    static func uploadPost(with title: String, detailPost: String, username: String, userId: String, postId: String) {
        let values = [
            "title": title,
            "detailPost": detailPost,
            "date": TimeString.setDate(),
            "username": username,
            "userId": userId,
            "postId": postId
        ]

        let posts = Database.database().reference().child("posts").child(postId)
        
        posts.setValue(values)
    }
    // MARK: - **************** OBSERVE USER POST ****************
    static func observeUserPost(closure: @escaping(Posts) -> ()) {
        Database.database().reference().child("posts").observe(.childAdded) { (snapshot) in
            ProgressHUD.show()
            if snapshot.exists() {
                if let postObject = snapshot.value as? [String:Any] {
                    let posts = Posts(dict: postObject)
                    
                    DispatchQueue.main.async {
                        closure(posts)
                    }
                }
            } else {
                ProgressHUD.dismiss()
            }
            ProgressHUD.dismiss()
        }
    }
    // MARK: - **************** FETCH CURRENT USER POST ****************
    static func fetchCurrentUserPost(closure: @escaping(Posts?) -> ()) {
        // Get current user
        Auth.auth().addStateDidChangeListener { (auth, user) in
            guard let user = user?.uid else { return }
            // Observe post for current user
            FirebaseServices.observeUserPost { (post) in
                // Check if user id match with post user id then append to the array
                if user == post.userId {
                    closure(post)
                } else {
                    closure(nil)
                }
            }
        }
    }
    
    static func editUserPost(with postId: String, title: String, detailPost: String, vc: UIViewController) {

        let updatedValues = [
            "title":title,
            "detailPost":detailPost,
            "date": "Updated on \(TimeString.setDate())"
        ]
        Database.database().reference().child("posts").child(postId).updateChildValues(updatedValues)
        vc.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - **************** POST COMMENT ****************
    static func postComment(user: String, userId: String, comment: String, postId: String, vc: UIViewController) {
        
        if comment.isEmpty { ProgressHUD.showError("Please enter a comment"); return }

        let commentId = UUID().uuidString
        let values = [
            "by":user,
            "userId":userId,
            "comment":comment,
            "postId":postId,
            "commentId":commentId,
            "date":TimeString.setDate()
        ]
        print(values)
        Database.database().reference().child("comments").child(commentId).setValue(values)
        vc.dismissView()
    }
    
    // MARK: - ERROR HANDLING CREATING/LOGIN A USER
    static func handleError(_ error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            ProgressHUD.showError(error.localizedDescription)
            return
        }
    }
}
