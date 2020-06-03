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
        btn.backgroundColor = UIColor(hex: "#578dde")
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
        guard let username = post?.username else { return }
        guard let postId = post?.postId else { return }

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
        dismissView()
    }
    
    func getCurrentUser() {
        FirebaseServices.fetchUser { (user) in
            self.user = user.username
        }
    }
    
    @objc func handleDismiss() {
        dismissView()
    }
}

extension PostCommentController {
    
    func setPostCommentsView() {
        view.backgroundColor = UIColor.mainColor()
        
        let lineView = UIView()
        lineView.backgroundColor = UIColor.darkColor()
        lineView.layer.cornerRadius = 5
        
        view.addSubview(lineView)
        lineView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, padding: .init(top: 15, left: 100, bottom: 0, right: 100), size: .init(width: 0, height: 6))
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: lineView.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, padding: .init(top: 40, left: 20, bottom: 0, right: 20), size: .init(width: 0, height: 0))
        
        view.addSubview(postCommentTextView)
        postCommentTextView.anchor(top: titleLabel.bottomAnchor, left: titleLabel.leftAnchor, bottom: nil, right: titleLabel.rightAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 300))
        postCommentTextView.layer.cornerRadius = 2

        let stackView = UIStackView(arrangedSubviews: [submitButton, dismissButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        
        submitButton.customBorder()

        view.addSubview(stackView)
        stackView.anchor(top: postCommentTextView.bottomAnchor, left: postCommentTextView.leftAnchor, bottom: nil, right: postCommentTextView.rightAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 100))
        
        postCommentTextView.customBorder()
    }
}
extension UIViewController {
    func dismissView() {
        dismiss(animated: true, completion: nil)
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
