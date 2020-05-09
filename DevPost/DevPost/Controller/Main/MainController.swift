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
        
        view.addSubview(collectionView)
        collectionView.fillSuperview()
        collectionView.backgroundColor = UIColor.mainColor()
        collectionView.register(MainCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
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
        ProgressHUD.show()
        Database.database().reference().child("posts").observe(.childAdded) { (snapshot) in
            if let postObject = snapshot.value as? [String:Any] {
                let post = Posts(dict: postObject)
                self.posts.append(post)
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
            ProgressHUD.dismiss()
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

extension MainController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MainCell
        cell.post = posts[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 500
        let padding: CGFloat = 60
        let text = posts[indexPath.item].detailPost
        height = estimateFrameForText(text: text).height + padding
        
        return .init(width: view.frame.width, height: height)
    }
    
    private func estimateFrameForText(text: String) -> CGRect {
        let height: CGFloat = 1000
        let size = CGSize(width: view.frame.width, height: height)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)]

        return NSString(string: text).boundingRect(with: size, options: options, attributes: attributes, context: nil)
    }
    
    
}
