//
//  CommentsController.swift
//  DevPost
//
//  Created by Israel Manzo on 5/20/20.
//  Copyright © 2020 Israel Manzo. All rights reserved.
//

import UIKit
import FirebaseDatabase

import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_FilledTextFields
import MaterialComponents.MaterialTextControls_OutlinedTextAreas
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class CommentsController: UIViewController {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.blueColor()
        label.font = .boldSystemFont(ofSize: 20)
        label.backgroundColor = UIColor.secondaryColor()
        return label
    }()
    
    let mainCommentTextView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = UIColor.secondaryColor()
        tv.font = .systemFont(ofSize: 14)
        tv.sizeToFit()
        tv.isScrollEnabled = false
        tv.translatesAutoresizingMaskIntoConstraints = true
        tv.isUserInteractionEnabled = false
        return tv
    }()
    
    let commentButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Comment", for: .normal)
        btn.setTitleColor(UIColor.blueColor(), for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(handlerPostComment), for: .touchUpInside)
        return btn
    }()
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.rowHeight = 60
        return tv
    }()
    
    var post: Posts?
    
    var comments = [Comments]()
    
    @objc func handlerPostComment() {
        let postCommentController = PostCommentController()
        postCommentController.post = post
        present(postCommentController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(CommentsCell.self, forCellReuseIdentifier: "commentsCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.mainColor()
        tableView.separatorStyle = .none
        tableView.bounces = false
        
        setCommentsNavItems()
        setCommentView()
        
//        print(post?.postId)
        guard let title = post?.title, let detailPost = post?.detailPost else { return }
        titleLabel.text = title
        mainCommentTextView.text = detailPost
        fetchPosts()
    }
    
    // MARK: - Fetching post by postId and render tableView
    func fetchPosts() {
        Database.database().reference().child("comments").observe(.childAdded) { (snaphost) in
            guard let dict = snaphost.value as? [String:Any] else { return }
            let comment = Comments(dict: dict)

            if self.post?.postId == comment.postId {
                
                self.comments.append(comment)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
        }
        
    }
    
    @objc func handleDismissComment() {
        dismissView()
    }
    
    
}

extension CommentsController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentsCell") as! CommentsCell
        
        cell.comments = comments[indexPath.row]
        return cell
    }
}



// MARK: - UITextField Delegate handler extension
extension CommentsController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    // MARK: - Keyboard dismiss when user touches any where out of the input textField
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
