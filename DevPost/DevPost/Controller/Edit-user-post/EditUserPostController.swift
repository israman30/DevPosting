//
//  EditUserPostController.swift
//  DevPost
//
//  Created by Israel Manzo on 5/30/20.
//  Copyright © 2020 Israel Manzo. All rights reserved.
//

import UIKit
import FirebaseDatabase

import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_FilledTextFields
import MaterialComponents.MaterialTextControls_OutlinedTextAreas
import MaterialComponents.MaterialTextControls_OutlinedTextFields

protocol SetEditedUserPostDelegate {
    func editedUpdateValues(_ post: [String:Any])
}

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
        print(userPost?.postId)
        
        guard let title = userPost?.title, let detailPost = userPost?.detailPost else { return }
        titleTextField.text = title
        detailPostTextView.text = detailPost
    }
    
    @objc func handleEditUserPost() {
        print(123)
        guard let title = titleTextField.text, let detailPost = detailPostTextView.text else { return }
        guard let postId = userPost?.postId else { return }
        let updatedValues = [
            "title":title,
            "detailPost":detailPost,
            "date": "Updated on \(TimeString.setDate())"
        ]
        Database.database().reference().child("posts").child(postId).updateChildValues(updatedValues)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleDismissEdit() {
        dismiss(animated: true, completion: nil)
    }
}

extension EditUserPostController {
    
    func setEditUserPostView() {
        
        view.backgroundColor = UIColor.mainColor()
        
        let lineView = UIView()
        lineView.backgroundColor = UIColor(hex: "#484848")
        lineView.layer.cornerRadius = 5
        
        view.addSubview(lineView)
        lineView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, padding: .init(top: 15, left: 100, bottom: 0, right: 100), size: .init(width: 0, height: 6))
        
        view.addSubview(titleTextField)
        titleTextField.anchor(top: lineView.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, padding: .init(top: 40, left: 20, bottom: 0, right: 20), size: .init(width: 0, height: 0))
        
        titleTextField.customBorder()
        
        view.addSubview(detailPostTextView)
        detailPostTextView.anchor(top: titleTextField.bottomAnchor, left: titleTextField.leftAnchor, bottom: nil, right: titleTextField.rightAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 300))

        let stackView = UIStackView(arrangedSubviews: [editUserPostButton, dismissButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        
        editUserPostButton.customBorder()

        view.addSubview(stackView)
        stackView.anchor(top: detailPostTextView.bottomAnchor, left: detailPostTextView.leftAnchor, bottom: nil, right: detailPostTextView.rightAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 100))
        
        detailPostTextView.customBorder()
    }
}
