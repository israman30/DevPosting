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
        tf.font = .systemFont(ofSize: 16)
        tf.backgroundColor = UIColor(hex: "#f0f1f2")
        return tf
    }()
    
    let usernameTextField: MDCBaseTextField = {
        let tf = MDCBaseTextField()
        tf.label.text = "Username"
        tf.sizeToFit()
        tf.placeholder = "Mr/Mrs"
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
        if email.isEmpty || password.isEmpty {
            ProgressHUD.showError("To sign up, you must enter all fields please!")
            return
        }
        FirebaseServices.createUser(with: email, password: password, username: username)
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - LOGIN USER with EMAIL & PASSWORD
    @objc func handleLogin() {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        if email.isEmpty || password.isEmpty {
            ProgressHUD.showError("Please enter valid email & password")
            return
        }
        FirebaseServices.loginUser(with: email, password: password)
        setGoogleButton()
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLoginView()
        GIDSignIn.sharedInstance()?.presentingViewController = self

        // Automatically sign in the user.
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
    }
    
    func setGoogleButton() {
        let googleButton = GIDSignInButton()
        googleButton.colorScheme = .dark
        view.addSubview(googleButton)
        googleButton.anchor(top: loginButton.bottomAnchor, left: loginButton.leftAnchor, bottom: nil, right: loginButton.rightAnchor, padding: .init(top: 10, left: -5, bottom: 0, right: -5), size: .init(width: 0, height: 70))
        dismiss(animated: true, completion: nil)
//        GIDSignIn.sharedInstance()?.presentingViewController = self
//        GIDSignIn.sharedInstance()?.signIn()
        
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

