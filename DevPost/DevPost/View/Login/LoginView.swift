//
//  LoginView.swift
//  DevPost
//
//  Created by Israel Manzo on 4/25/20.
//  Copyright © 2020 Israel Manzo. All rights reserved.
//

import UIKit
import GoogleSignIn

extension LoginController {
    
    func setLoginView() {
        view.backgroundColor = UIColor.mainColor()
               
       let containerView = UIView()
       
       let width = view.frame.width - 50
        
       view.addSubview(containerView)

        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -120).isActive = true
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.widthAnchor.constraint(equalToConstant: width).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 185).isActive = true
       
       let stackView = UIStackView(arrangedSubviews: [usernameTextField, emailTextField, passwordTextField])
       stackView.axis = .vertical
       stackView.distribution = .fillEqually
       stackView.spacing = 2
        
       containerView.addSubview(stackView)
       stackView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, padding: .init(top: 10, left: 10, bottom: 10, right: 10))
        
        containerView.customBorder()
        containerView.layer.cornerRadius = 3
       
        setbutton(containerView)
        
    }
    
    func setbutton(_ containerView: UIView) {
        let buttonsStackView = UIStackView(arrangedSubviews: [signupButton, loginButton])
        buttonsStackView.axis = .vertical
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.spacing = 5
        
        signupButton.customBorder()
        
        loginButton.customBorder()
        
        view.addSubview(buttonsStackView)
        buttonsStackView.anchor(top: containerView.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 90))
        
        
        setGoogleButton()
        setForgotPassword()
    }
    
    func setGoogleButton() {
        let googleButton = GIDSignInButton()
        googleButton.colorScheme = .dark
        view.addSubview(googleButton)
        googleButton.anchor(top: loginButton.bottomAnchor, left: loginButton.leftAnchor, bottom: nil, right: loginButton.rightAnchor, padding: .init(top: 10, left: -5, bottom: 0, right: -5), size: .init(width: 0, height: 0))
        dismiss(animated: true, completion: nil)
    }
    
    func setForgotPassword() {
        view.addSubview(resetPassword)
        resetPassword.anchor(top: nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, padding: .init(top: 0, left: 0, bottom: 100, right: 0), size: .init(width: 0, height: 50))
    }
    
}
