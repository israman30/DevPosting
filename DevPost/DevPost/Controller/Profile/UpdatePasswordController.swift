//
//  UpdatePasswordController.swift
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

class UpdatePasswordController: UIViewController {
    
    let emailTextField: MDCBaseTextField = {
        let tf = MDCBaseTextField()
        tf.label.text = "Email"
        tf.sizeToFit()
        tf.placeholder = "email@mail.com"
        tf.textColor = .green
        tf.font = .systemFont(ofSize: 18)
        tf.backgroundColor = UIColor(hex: "#f0f1f2")
        return tf
    }()
    
    let updateButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Update Password", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        btn.backgroundColor = UIColor(hex: "#121520")
        btn.addTarget(self, action: #selector(handleUpdatePassword), for: .touchUpInside)
        return btn
    }()
    
    lazy var cancelUpdatePasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "Cancel"
        label.textAlignment = .center
        label.textColor = .gray
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCancelUpdatePassword)))
        return label
    }()
    
    @objc func handleUpdatePassword() {
        
    }
    
    @objc func handleCancelUpdatePassword() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpdatePasswordView()
    }
    
    func setUpdatePasswordView() {
        view.backgroundColor = UIColor.mainColor()
        
        let lineView = UIView()
        lineView.backgroundColor = UIColor(hex: "#484848")
        lineView.layer.cornerRadius = 5
        
        view.addSubview(lineView)
        lineView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, padding: .init(top: 15, left: 100, bottom: 0, right: 100), size: .init(width: 0, height: 6))
        
        view.addSubview(emailTextField)
        emailTextField.anchor(top: lineView.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, padding: .init(top: 40, left: 20, bottom: 0, right: 20), size: .init(width: 0, height: 60))
        emailTextField.customBorder()
        
        view.addSubview(updateButton)
        updateButton.anchor(top: emailTextField.bottomAnchor, left: emailTextField.leftAnchor, bottom: nil, right: emailTextField.rightAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 45))
        updateButton.layer.cornerRadius = 2
        
        view.addSubview(cancelUpdatePasswordLabel)
        cancelUpdatePasswordLabel.anchor(top: updateButton.bottomAnchor, left: updateButton.leftAnchor, bottom: nil, right: updateButton.rightAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 30))
    }
}
extension UpdatePasswordController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    // MARK: - Keyboard dismiss when user touches any where out of the input textField
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
