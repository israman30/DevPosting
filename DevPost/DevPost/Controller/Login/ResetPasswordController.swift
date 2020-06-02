//
//  ResetPasswordController.swift
//  DevPost
//
//  Created by Israel Manzo on 5/4/20.
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

class ResetPasswordController: UIViewController {
    
    let emailTextField: MDCBaseTextField = {
        let tf = MDCBaseTextField()
        tf.label.text = "Email"
        tf.sizeToFit()
        tf.placeholder = "email@mail.com"
        tf.textColor = .green
        tf.textContentType = .emailAddress
        tf.font = .systemFont(ofSize: 18)
        tf.backgroundColor = UIColor.inputBackgroundColor()
        return tf
    }()
    
    let resetButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Reset Password", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        btn.backgroundColor = UIColor.darkColor()
        btn.addTarget(self, action: #selector(handleResetPassword), for: .touchUpInside)
        return btn
    }()
    
    lazy var cancelResetPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "Cancel"
        label.textAlignment = .center
        label.textColor = UIColor.redColor()
        label.font = .boldSystemFont(ofSize: 20)
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCancelResetPassword)))
        return label
    }()
    
    @objc func handleCancelResetPassword() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Reset password handler { Reset password on db using email address }
    @objc func handleResetPassword() {
        guard let email = emailTextField.text else { return }
        if email.isEmpty {
            ProgressHUD.showError("Please enter a valid email address")
            return
        }
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if error != nil {
                ProgressHUD.showError("Wrong email")
                return
            }
            ProgressHUD.showSuccess("An email is on the way with instructions to reset your password")
        }
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetPasswordView()
    }
}
extension ResetPasswordController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    // MARK: - Keyboard dismiss when user touches any where out of the input textField
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

