//
//  LoginView.swift
//  DevPost
//
//  Created by Israel Manzo on 4/25/20.
//  Copyright © 2020 Israel Manzo. All rights reserved.
//

import UIKit

extension LoginController {
    
    func setLoginView() {
        view.backgroundColor = UIColor.mainColor()
               
       let containerView = UIView()
       
       let width = view.frame.width - 50
//       containerView.backgroundColor = UIColor(hex: "#f0f1f2")
        
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
        
        view.addSubview(resetPassword)
        resetPassword.anchor(top: buttonsStackView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, padding: .init(top: 100, left: 0, bottom: 0, right: 0), size: .init(width: 100, height: 0))
        setGoogleButton(buttonsStackView)
    }
    
}
