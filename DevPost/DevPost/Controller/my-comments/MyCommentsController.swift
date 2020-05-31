//
//  MyCommentsController.swift
//  DevPost
//
//  Created by Israel Manzo on 5/20/20.
//  Copyright © 2020 Israel Manzo. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import ProgressHUD

class MyCommentsController: UIViewController {
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.rowHeight = 60
        tv.backgroundColor = UIColor.mainColor()
        tv.separatorColor = .clear
        return tv
    }()
    
    var myPost: [Posts] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavbarItems()
        
        myCommentsRegisteringCellWithDelegateAndDataSource()
        
        setMyCommentView()

        fetchPostForCurrentUser()
    }
    
    // MARK: - Fetch post by user id for current user
    func fetchPostForCurrentUser() {
        // Get current user
        Auth.auth().addStateDidChangeListener { (auth, user) in
            guard let user = user?.uid else { return }
            // Observe post for current user
            FirebaseServices.observeUserPost { (post) in
                // Check if user id match with post user id then append to the array
                if user == post.userId {
                    self.myPost.append(post)
                    self.myPost.sort(by: { $0.date.compare($1.date) == .orderedDescending })
                    self.tableView.reloadData()
                } else {
                    self.tableView.reloadData()
                }
            }
            self.myPost = []
        }
    }
    
}




