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

class LoginController: UIViewController {
    
    let usernameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "USERNAME"
        return tf
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "EMAIL"
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "PASSWORD"
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
    
    // MARK: - Handle signup a new user
    @objc func handleSignup() {
        creatingUser()
    }
    
    // MARK: - LOGIN USER with EMAIL & PASSWORD
    @objc func handleLogin() {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        if email.isEmpty || password.isEmpty {
            ProgressHUD.showError("Please enter valid email & password")
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            guard let user = user?.user.uid else { return }
            if user.isEmpty {
                self.handleError(error)
            }
            // Login user
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLoginView()
    }
    
    // MARK: - CREATE NEW USER with USERNAME + EMAIL + PASSWORD
    func creatingUser() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              let username = usernameTextField.text else { return }
        if email.isEmpty || password.isEmpty {
            ProgressHUD.showError("To sign up, you must enter all fields please!")
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            self.handleError(error)
            // Create user object
            guard let uid = user?.user.uid else { return }
            let values = [
                "username": username,
                "email":email
            ]
            let ref = Database.database().reference().child("users")
            ref.child(uid).setValue(values)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: - ERROR HANDLING CREATING/LOGIN A USER
    func handleError(_ error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            ProgressHUD.showError("Wrong user information..!")
            return
        }
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

