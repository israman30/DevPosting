//
//  EditProfileController.swift
//  DevPost
//
//  Created by Israel Manzo on 5/6/20.
//  Copyright © 2020 Israel Manzo. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import ProgressHUD

import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_FilledTextFields
import MaterialComponents.MaterialTextControls_OutlinedTextAreas
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class EditProfileController: UIViewController {
    
    let usernameTexField: MDCBaseTextField = {
        let tf = MDCBaseTextField()
        tf.label.text = "username"
        tf.placeholder = "New username"
        tf.font = .systemFont(ofSize: 20)
        tf.customBorder()
        return tf
    }()
    
    let emailTexField: MDCBaseTextField = {
        let tf = MDCBaseTextField()
        tf.label.text = "email"
        tf.placeholder = "New email"
        tf.font = .systemFont(ofSize: 20)
        tf.customBorder()
        return tf
    }()
    
    lazy var cancelUpdateProfileLabel: UILabel = {
        let label = UILabel()
        label.text = "Cancel"
        label.textAlignment = .center
        label.textColor = .gray
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCancelUpdateProfile)))
        return label
    }()
    
    let editProfileButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Update Profile", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        btn.backgroundColor = UIColor(hex: "#121520")
        btn.addTarget(self, action: #selector(handleUpdateProfile), for: .touchUpInside)
        return btn
    }()
    
    @objc func handleUpdateProfile() {
        guard let username = usernameTexField.text, let email = emailTexField.text else { return }
        if username.isEmpty || email.isEmpty {
            ProgressHUD.showError("Please ente valid info")
        } else {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            
            let updatedValues = [
                "username":username,
                "email":email
            ]
            
            Database.database().reference().child("users").child(uid).setValue(updatedValues)
            ProgressHUD.showSuccess("User updated")
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    @objc func handleCancelUpdateProfile() {
        dismiss(animated: true, completion: nil)
    }
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setEditProfileView()
        usernameTexField.text = user?.username
        emailTexField.text = user?.email
    }
    
}
extension EditProfileController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    // MARK: - Keyboard dismiss when user touches any where out of the input textField
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}


