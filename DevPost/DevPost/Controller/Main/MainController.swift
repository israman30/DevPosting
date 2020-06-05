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
    
    let searchBar = UISearchBar()
    
    lazy var refreshController: UIRefreshControl = {
        let rc = UIRefreshControl()
        rc.tintColor = UIColor.greenColor()
        rc.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        return rc
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        cv.alwaysBounceVertical = true
        return cv
    }()
    
    var posts = [Posts]()
    var filteredPosts = [Posts]()
    var showResult = false
    
    var heightConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSearchBar()
        setNavigationItems()
        collectionViewCellRegiterWithDataSourceAndDelegates()
        
        // MARK: - IS USER LOGGED IN?
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(isUserLoggedIn), with: nil, afterDelay: 0)
        }
        observeUser()
        setNavUsername()
        
        // MARK: RefresControl for iOS version types
        if #available(iOS 10.0, *) {
            collectionView.refreshControl = refreshController
        } else {
            collectionView.addSubview(refreshController)
        }
    }
    
    // MARK: - Hidding searchBar handler { constraint animation }
    @objc func handleShowSearchIcon() {
        if heightConstraint?.constant == 0 {
            heightConstraint?.constant = 40
        } else {
            heightConstraint?.constant = 0
        }
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    // MARK: - Refresh controller + refreshing collection view after user has deleted a post
    @objc func refreshData() {
        collectionView.refreshControl?.beginRefreshing()
        var newPosts = [Posts]()
        DispatchQueue.main.async {
            FirebaseServices.observeUserPost { (post) in
                newPosts.append(post)
                self.posts = newPosts
                self.collectionView.reloadData()
            }
        }
        collectionView.refreshControl?.endRefreshing()
    }
    
    // MARK: - Refresh data with navbar button tap using refredData()
    @objc func handleRefresh() {
        refreshData()
    }
    
    // MARK: - Sset navbar with current username { using custo view + fetch username }
    func setNavUsername() {
        let titleView = UIView(frame: .init(x: 0, y: 0, width: 200, height: 20))
        let usernameLabel = UILabel()
        usernameLabel.font = .boldSystemFont(ofSize: 17)
        usernameLabel.textColor = UIColor.darkColor()
        FirebaseServices.fetchUser { (user) in
            usernameLabel.text = user.username
        }
        usernameLabel.textAlignment = .center
        titleView.addSubview(usernameLabel)
        usernameLabel.frame = titleView.frame
        navigationItem.titleView = titleView
    }
    
    // MARK: - Observe posts from Firebase + render collection view
    func observeUser() {
        FirebaseServices.observeUserPost { (posts) in
            self.posts.append(posts)
            self.posts.sort(by: { $0.date.compare($1.date) == .orderedDescending })
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - LOGOUT { Google signout + custom signout }
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
    
    // MARK: - Present PostController handler { presents controller that holds the logic for adding a post }
    @objc func handleAdd() {
        let postController = PostController()
        present(postController, animated: true, completion: nil)
    }

}

// MARK: - SEARCH BAR DELEGATE EXTENSION
extension MainController: UISearchBarDelegate {
    
    // MARK: - Search filtered text method for search post title
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredPosts = posts.filter {
            $0.title.lowercased().range(of: searchText.lowercased()) != nil
        }
        if !searchText.isEmpty {
            showResult = true
            collectionView.reloadData()
        } else {
            showResult = false
            collectionView.reloadData()
        }
    }
    
    // MARK: - Keyboard hides when scroll down
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
}
