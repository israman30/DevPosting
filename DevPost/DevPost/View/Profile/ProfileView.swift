//
//  ProfileView.swift
//  DevPost
//
//  Created by Israel Manzo on 5/7/20.
//  Copyright © 2020 Israel Manzo. All rights reserved.
//

import UIKit

extension ProfileController {
    
    func setProfileView() {
        view.backgroundColor = UIColor.mainColor()
        navigationController?.isNavigationBarHidden = true
        
        let containerView = UIView()
        containerView.backgroundColor = UIColor.secondaryColor()
        containerView.layer.cornerRadius = 10
        containerView.customBorder()
        let height = (view.frame.height) - 300
        
        view.addSubview(containerView)
        containerView.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, padding: .init(top: 0, left: 10, bottom: 10, right: 10), size: .init(width: 0, height: height))
        
        setUserInfo(containerView)
    }
    
    func setUserInfo(_ containerView: UIView) {
        let usernameBottonLineView = UIView()
        usernameBottonLineView.backgroundColor = UIColor.darkColor()
        
        usernameBottonLineView.layer.cornerRadius = 5
        
        containerView.addSubview(usernameLabel)
        usernameLabel.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, padding: .init(top: 30, left: 10, bottom: 0, right: 10), size: .init(width: 0, height: 30))
        
        
        containerView.addSubview(titleNameLabel)
        titleNameLabel.anchor(top: usernameLabel.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, padding: .zero, size: .init(width: 0, height: 30))
        
        containerView.addSubview(usernameBottonLineView)
        usernameBottonLineView.anchor(top: titleNameLabel.bottomAnchor, left: titleNameLabel.leftAnchor, bottom: nil, right: titleNameLabel.rightAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 10), size: .init(width: 0, height: 5))
        
        containerView.addSubview(emailLabel)
        emailLabel.anchor(top: usernameBottonLineView.bottomAnchor, left: usernameBottonLineView.leftAnchor, bottom: nil, right: usernameBottonLineView.rightAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 30))
        
        let stackView = UIStackView(arrangedSubviews: [editProfileButton, deleteAccountButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        
        containerView.addSubview(stackView)
        stackView.anchor(top: nil, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, padding: .init(top: 0, left: 10, bottom: 10, right: 10), size: .init(width: 0, height: 100))
        editProfileButton.layer.cornerRadius = 2

    }
}

