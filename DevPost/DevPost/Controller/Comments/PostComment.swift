//
//  PostComment.swift
//  DevPost
//
//  Created by Israel Manzo on 6/1/20.
//  Copyright © 2020 Israel Manzo. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import ProgressHUD

class PostCommentController: UIViewController {
    
    let titleLabel: UILabel = {
        let tf = UILabel()
        tf.text = "Thank you, for the contribution"
        tf.font = .systemFont(ofSize: 15)
        return tf
    }()
    
    let postCommentTextView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = UIColor.inputBackgroundColor()
        tv.font = .systemFont(ofSize: 18)
        return tv
    }()
    
    let submitButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Submit", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        btn.layer.cornerRadius = 2
        btn.backgroundColor = UIColor.blueColor()
        btn.customShadow()
        btn.addTarget(self, action: #selector(handleSubmitComment), for: .touchUpInside)
        return btn
    }()
    
    let dismissButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Cancel", for: .normal)
        btn.setTitleColor(UIColor.redColor(), for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        btn.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPostCommentsView()
        getCurrentUser()
    }
    
    @objc func handleSubmitComment() {
        postComment()
    }
    
    var post: Posts?
    var user: String?
    
    // MARK: - Create user comment object post
    func postComment() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        guard let comment = postCommentTextView.text else { return }
        guard let user = user else { return }
        guard let postId = post?.postId else { return }
        
        FirebaseServices.postComment(user: user, userId: userId, comment: comment, postId: postId, vc: self)
    }
    // MARK: - Get current user from db to build comment object
    func getCurrentUser() {
        FirebaseServices.fetchUser { (user) in
            self.user = user.username
        }
    }
    
    @objc func handleDismiss() {
        dismissView()
    }
}


// MARK: - UITextField Delegate handler extension
extension PostCommentController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    // MARK: - Keyboard dismiss when user touches any where out of the input textField
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
