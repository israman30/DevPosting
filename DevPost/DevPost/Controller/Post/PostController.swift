//
//  PostController.swift
//  DevPost
//
//  Created by Israel Manzo on 4/24/20.
//  Copyright © 2020 Israel Manzo. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_FilledTextFields
import MaterialComponents.MaterialTextControls_OutlinedTextAreas
import MaterialComponents.MaterialTextControls_OutlinedTextFields

import ProgressHUD

class PostController: UIViewController {
    
    let titleTextField: MDCBaseTextField = {
        let tf = MDCBaseTextField()
        tf.label.text = "Type here..."
        tf.leadingAssistiveLabel.text = "Enter the technology of your choice"
        tf.sizeToFit()
        tf.placeholder = "Enter title post"
        tf.font = .systemFont(ofSize: 20)
        tf.backgroundColor = UIColor(hex: "#f0f1f2")
        return tf
    }()
    
    let detailPostTextView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = UIColor(hex: "#f0f1f2")
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
        btn.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
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
    
    // MARK: - Handle submit post
    @objc func handleSubmit() {
        if titleTextField.text!.isEmpty || detailPostTextView.text.isEmpty {
            ProgressHUD.showError("Please enter valid information to create a post")
            return
        }
        ProgressHUD.showError("Posting...")
        uploadPost()
        ProgressHUD.showSuccess("Post Success")
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Cancel post with dismiss controller
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPostView()
        postUserInfo()
    }
    
    var username: String?
    
    // MARK: - Upload post object to Fireabase
    func uploadPost() {
        guard let title = titleTextField.text, let detailPost = detailPostTextView.text else { return }
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let stringId = UUID().uuidString
        
        let values = [
            "title": title,
            "detailPost": detailPost,
            "date": TimeString.setDate(),
            "username": username,
            "userId": userId
        ]

        let posts = Database.database().reference().child("posts").child(stringId)
        
        posts.setValue(values)
        
        
    }
    // MARK: - Fetch user for username object post
    func postUserInfo() {
        FirebaseServices.fetchUser { (user) in
            self.username = user.username
        }
    }
    
}

// MARK: - UITextField Delegate handler extension
extension PostController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    // MARK: - Keyboard dismiss when user touches any where out of the input textField
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
class TimeString {
    // MARK: - setDate function returns a Date of type String that is assigned to the date object created by the context
    static func setDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: Date())
    }
}
