//
//  ProfileController.swift
//  DevPost
//
//  Created by Israel Manzo on 5/5/20.
//  Copyright © 2020 Israel Manzo. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ProfileController: UIViewController {
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.font = .systemFont(ofSize: 30)
        label.textAlignment = .center
        label.isEnabled = true
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "johndoe@mail.com"
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    let editProfileButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Edit Profile", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        btn.backgroundColor = UIColor.darkColor()
        btn.customBorder()
        btn.addTarget(self, action: #selector(handleEditProfile), for: .touchUpInside)
        return btn
    }()
    
    let deleteAccountButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Delete Account", for: .normal)
        btn.setTitleColor(.redColor(), for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        btn.addTarget(self, action: #selector(handleDeleteAccount), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - userInfo holds user info to be passed into the textFields efit controller
    var userInfo: User?
    
    @objc func handleEditProfile() {
        let editProfileController = EditProfileController()
        editProfileController.user = userInfo
        present(editProfileController, animated: true, completion: nil)
    }
    
    @objc func handleDeleteAccount() {
        print(123)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setProfileView()
        fetchUserInfo()
    }
    
    // MARK: - Fetch user info from Firebase Database + it's displayed on UI + uses userInfo to pass the object to edit profile fields
    func fetchUserInfo() {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            guard let uid = auth.currentUser?.uid else { return }
            Database.database().reference().child("users").child(uid).observe(.value) { (snapshot) in
                if let dict = snapshot.value as? [String:Any] {
                    let user = User(dict: dict)
                    self.setProfileUI(with: user.username, email: user.email)
                    self.userInfo = user
                }
            }
        }
    }
    
    // MARK: - Function helps to display user info in the UI when user is fetched from db
    func setProfileUI(with username: String, email: String) {
        usernameLabel.text = username
        emailLabel.text = email
    }

}
