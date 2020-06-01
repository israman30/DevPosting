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
    
    lazy var refreshController: UIRefreshControl = {
        let rc = UIRefreshControl()
        rc.tintColor = UIColor.greenColor()
        rc.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        return rc
    }()
    
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
        
        // MARK: RefresControl for iOS versions
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshController
        } else {
            tableView.addSubview(refreshController)
        }
    }
    
    // TODO: RELOAD ONLY CURRENT USER POSTS
    // MARK: - Refresh controller + refresh table view data after user post is edited
    @objc func refreshData() {
        tableView.refreshControl?.beginRefreshing()
        var newPosts = [Posts]()
        Auth.auth().addStateDidChangeListener { (auth, user) in
            guard let user = user?.uid else { return }
            FirebaseServices.observeUserPost { (post) in
                if user == post.userId {
                    newPosts.append(post)
                    self.myPost = newPosts
                    self.tableView.reloadData()
                }
            }
        }
        tableView.refreshControl?.endRefreshing()
    }
    
    // MARK: - Fetch post by user id for current user
    func fetchPostForCurrentUser() {
        FirebaseServices.fetchCurrentUserPost { (post) in
            guard let post = post else { return }
            self.myPost.append(post)
            self.myPost.sort(by: { $0.date.compare($1.date) == .orderedDescending })
            self.tableView.reloadData()
        }
    }
    
    @objc func handleRefresTapped() {
        refreshData()
    }
}




