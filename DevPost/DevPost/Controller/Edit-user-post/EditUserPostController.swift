//
//  EditUserPostController.swift
//  DevPost
//
//  Created by Israel Manzo on 5/30/20.
//  Copyright © 2020 Israel Manzo. All rights reserved.
//

import UIKit
import FirebaseDatabase

import MaterialComponents.MaterialDialogs

import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_FilledTextFields
import MaterialComponents.MaterialTextControls_OutlinedTextAreas
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class EditUserPostController: UIViewController {
    
    let titleTextField: MDCBaseTextField = {
        let tf = MDCBaseTextField()
        tf.label.text = "Type here..."
        tf.leadingAssistiveLabel.text = "Edit the your post"
        tf.sizeToFit()
        tf.placeholder = "Enter new post"
        tf.font = .systemFont(ofSize: 20)
        tf.backgroundColor = UIColor.inputBackgroundColor()
        return tf
    }()
    
    let detailPostTextView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = UIColor.inputBackgroundColor()
        tv.font = .systemFont(ofSize: 18)
        return tv
    }()
    
    let editUserPostButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Edit Post", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        btn.layer.cornerRadius = 2
        btn.backgroundColor = UIColor.blueColor()
        btn.customShadow()
        btn.addTarget(self, action: #selector(handleEditUserPost), for: .touchUpInside)
        return btn
    }()
    
    let dismissButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Cancel", for: .normal)
        btn.setTitleColor(UIColor.redColor(), for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        btn.addTarget(self, action: #selector(handleDismissEdit), for: .touchUpInside)
        return btn
    }()
    
    var userPost: Posts?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setEditUserPostView()
        
        guard let title = userPost?.title, let detailPost = userPost?.detailPost else { return }
        titleTextField.text = title
        detailPostTextView.text = detailPost
    }
    
    @objc func handleEditUserPost() {
        guard let title = titleTextField.text, let detailPost = detailPostTextView.text else { return }
        guard let postId = userPost?.postId else { return }
        // Alert controller to warn the user when about to delete the post
        let alertController = MDCAlertController(title: "Are you sure you want to change this post?", message: "Press OK to proceed and refresh your post  after accepting, or CANCEL.")
        let action = MDCAlertAction(title: "OK") { action in
            FirebaseServices.editUserPost(with: postId, title: title, detailPost: detailPost, vc: self)
        }
        let cancel = MDCAlertAction(title: "Cancel", handler: nil)
        alertController.addAction(action)
        alertController.addAction(cancel)

        present(alertController, animated: true, completion: nil)
    }
    
    @objc func handleDismissEdit() {
        dismiss(animated: true, completion: nil)
    }
}


