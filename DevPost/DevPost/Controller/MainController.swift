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

class MainController: UITableViewController {
    
    var posts = [Posts]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItems()
        
        tableView.register(MainCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 75
        tableView.separatorColor = .opaqueSeparator
        tableView.separatorInset = .init(top: 0, left: 10, bottom: 0, right: 10)
        tableView.showsVerticalScrollIndicator = false
        
        // MARK: - IS USER LOGGED IN?
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(isUserLoggedIn), with: nil, afterDelay: 0)
        } else {
            // TODO: Set user info
        }
    
        observeUser()
    }
    
    // MARK: - Observe posts from Firebase
    func observeUser() {
        Database.database().reference().child("posts").observe(.childAdded) { (snapshot) in
            if let postObject = snapshot.value as? [String:Any] {
                let post = Posts(dict: postObject)
                self.posts.append(post)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - LOGOUT
    @objc func handleLogout() {
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

extension MainController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MainCell
        cell.post = posts[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postDisplayController = PostDisplayController()
        postDisplayController.posts = posts[indexPath.row]
        navigationController?.pushViewController(postDisplayController, animated: true)
    }
}
