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
        tf.label.text = "Username"
        tf.placeholder = "New username"
        tf.font = .systemFont(ofSize: 20)
        tf.customBorder()
        return tf
    }()
    
    let emailTexField: MDCBaseTextField = {
        let tf = MDCBaseTextField()
        tf.label.text = "email@mail.com"
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
    
    var databaseRef: DatabaseReference?
    
    @objc func handleUpdateProfile() {
        guard let username = usernameTexField.text, let email = emailTexField.text else { return }
        if username.isEmpty || email.isEmpty {
            ProgressHUD.showError("Please ente valid info")
        }
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let updatedValues = [
            "username":username,
            "email":email
        ]
        
        Database.database().reference().child("users").child(uid).setValue(updatedValues)
        ProgressHUD.showSuccess("User updated")
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleCancelUpdateProfile() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setEditProfileView()
    }
    
    func setEditProfileView() {
        view.backgroundColor = UIColor.mainColor()
        let lineView = UIView()
        lineView.backgroundColor = UIColor(hex: "#484848")
        lineView.layer.cornerRadius = 5
        
        view.addSubview(lineView)
        lineView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, padding: .init(top: 15, left: 100, bottom: 0, right: 100), size: .init(width: 0, height: 6))
        let stackView = UIStackView(arrangedSubviews: [usernameTexField, emailTexField])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        
        view.addSubview(stackView)
        stackView.anchor(top: lineView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, padding: .init(top: 100, left: 10, bottom: 0, right: 10), size: .init(width: 0, height: 140))
        usernameTexField.layer.cornerRadius = 2
        emailTexField.layer.cornerRadius = 2
        setEditButton(stackView)
    }
    func setEditButton(_ stackView: UIStackView) {
        let buttonStackView = UIStackView(arrangedSubviews: [editProfileButton, cancelUpdateProfileLabel])
        buttonStackView.axis = .vertical
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 5
        
        view.addSubview(buttonStackView)
        buttonStackView.anchor(top: stackView.bottomAnchor, left: stackView.leftAnchor, bottom: nil, right: stackView.rightAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 100))
        editProfileButton.layer.cornerRadius = 2
        
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
