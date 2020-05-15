//
//  MainController.swift
//  DevPost
//
//  Created by Israel Manzo on 4/24/20.
//  Copyright © 2020 Israel Manzo. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import ProgressHUD
import GoogleSignIn

class MainController: UIViewController {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        return cv
    }()
    
    var posts = [Posts]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItems()
        collectionViewCellRegiterWithDataSourceAndDelegates()
        
        // MARK: - IS USER LOGGED IN?
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(isUserLoggedIn), with: nil, afterDelay: 0)
        }
        observeUser()
        setNavUsername()
    }
    
    // MARK: - Sset nvabar with current username
    func setNavUsername() {
        let titleView = UIView(frame: .init(x: 0, y: 0, width: 200, height: 20))
        let usernameLabel = UILabel()
        usernameLabel.textColor = UIColor.darkColor()
        FirebaseServices.fetchUser { (user) in
            usernameLabel.text = user.username
        }
        usernameLabel.textAlignment = .center
        titleView.addSubview(usernameLabel)
        usernameLabel.frame = titleView.frame
        navigationItem.titleView = titleView
    }
    
    // MARK: - Observe posts from Firebase
    func observeUser() {
        FirebaseServices.observeUserPost { (posts) in
            self.posts.append(posts)
            self.posts.sort(by: { $0.date.compare($1.date) == .orderedDescending })
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - LOGOUT 
    @objc func handleLogout() {
        GIDSignIn.sharedInstance().signOut()
        logOutUser()
    }
    
    func logOutUser() {
        do {
            try Auth.auth().signOut()
            isUserLoggedIn()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Go to LoginController if user == nil
    @objc func isUserLoggedIn() {
        let loginController = LoginController()
        loginController.modalPresentationStyle = .fullScreen
        present(loginController, animated: true, completion: nil)
    }
    
    // MARK: - Present PostController
    @objc func handleAdd() {
        let postController = PostController()
        present(postController, animated: true, completion: nil)
    }

}


