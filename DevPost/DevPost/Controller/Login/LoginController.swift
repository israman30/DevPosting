//
//  LoginController.swift
//  DevPost
//
//  Created by Israel Manzo on 4/24/20.
//  Copyright © 2020 Israel Manzo. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import ProgressHUD
import GoogleSignIn

import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_FilledTextFields
import MaterialComponents.MaterialTextControls_OutlinedTextAreas
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class LoginController: UIViewController {
   
    let emailTextField: MDCBaseTextField = {
        let tf = MDCBaseTextField()
        tf.label.text = "Email"
        tf.sizeToFit()
        tf.placeholder = "email@mail.com"
        tf.textContentType = .emailAddress
        tf.textColor = .green
        tf.font = .systemFont(ofSize: 16)
        tf.backgroundColor = UIColor(hex: "#f0f1f2")
        return tf
    }()
    
    let passwordTextField: MDCBaseTextField = {
        let tf = MDCBaseTextField()
        tf.label.text = "Password"
        tf.sizeToFit()
        tf.placeholder = "********"
        tf.isSecureTextEntry = true
        tf.font = .systemFont(ofSize: 16)
        tf.backgroundColor = UIColor(hex: "#f0f1f2")
        return tf
    }()
    
    let usernameTextField: MDCBaseTextField = {
        let tf = MDCBaseTextField()
        tf.label.text = "Username"
        tf.sizeToFit()
        tf.placeholder = "Mr/Mrs"
        tf.textContentType = .nickname
        tf.font = .systemFont(ofSize: 16)
        tf.backgroundColor = UIColor(hex: "#f0f1f2")
        return tf
    }()
    
    let signupButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Signup", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        btn.backgroundColor = UIColor(hex: "#578dde")
        btn.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
        return btn
    }()
    
    let loginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Login with email+password", for: .normal)
        btn.setTitleColor(.darkGray, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        btn.backgroundColor = UIColor(hex: "#f0f1f2")
        btn.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return btn
    }()
    
    lazy var resetPassword: UILabel = {
        let label = UILabel()
        label.text = "Forgot password"
        label.textAlignment = .center
        label.textColor = .gray
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleResetPassword)))
        return label
    }()
    
    // MARK: - Reset password handler { Present reset controller that contains the logic for reset password on db }
    @objc func handleResetPassword() {
        let resetPasswordController = ResetPasswordController()
        resetPasswordController.modalPresentationStyle = .automatic
        present(resetPasswordController, animated: true, completion: nil)
    }
    
    // MARK: - CREATE NEW USER with USERNAME + EMAIL + PASSWORD
    @objc func handleSignup() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              let username = usernameTextField.text else { return }
        if email.isEmpty || password.isEmpty || username.isEmpty {
            ProgressHUD.showError("To sign up, you must enter all fields please!")
            return
        }
        FirebaseServices.createUser(with: email, password: password, username: username, vc: self)
    }
    
    // MARK: - LOGIN USER with EMAIL & PASSWORD
    @objc func handleLogin() {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        if email.isEmpty || password.isEmpty {
            ProgressHUD.showError("Please enter valid email & password")
            return
        }
        FirebaseServices.loginUser(with: email, password: password, vc: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLoginView()
        googlePreseterDelegatesWithUserPResistance()
    }
    
}

extension LoginController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    // MARK: - Keyboard dismiss when user touches any where out of the input textField
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}


