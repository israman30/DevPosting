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
    
    let newPasswordTextField: MDCBaseTextField = {
        let tf = MDCBaseTextField()
        tf.label.text = "New Password"
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
        guard let newPassword = newPasswordTextField.text else { return }
        if newPassword.isEmpty {
            ProgressHUD.showError("Please enter valid password info")
            return
        }
        FirebaseServices.updatePassword(with: newPassword)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleCancelUpdatePassword() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpdatePasswordView()
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


