//
//  EditProfileView.swift
//  DevPost
//
//  Created by Israel Manzo on 5/7/20.
//  Copyright © 2020 Israel Manzo. All rights reserved.
//

import UIKit

extension EditProfileController {
    
    func setEditProfileView() {
        view.backgroundColor = UIColor.mainColor()
        let lineView = UIView()
        lineView.backgroundColor = UIColor(hex: "#484848")
        lineView.layer.cornerRadius = 5
        
        view.addSubview(lineView)
        lineView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, padding: .init(top: 15, left: 100, bottom: 0, right: 100), size: .init(width: 0, height: 6))
        let stackView = UIStackView(arrangedSubviews: [usernameTexField, titleNameTexField, repoTextFiel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        
        view.addSubview(stackView)
        stackView.anchor(top: lineView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, padding: .init(top: 100, left: 10, bottom: 0, right: 10), size: .init(width: 0, height: 190))
        usernameTexField.layer.cornerRadius = 2
        setEditButton(stackView)
    }
    func setEditButton(_ stackView: UIStackView) {
        let buttonStackView = UIStackView(arrangedSubviews: [editProfileButton, cancelUpdateProfileLabel])
        buttonStackView.axis = .vertical
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 5
        
        view.addSubview(buttonStackView)
        buttonStackView.anchor(top: stackView.bottomAnchor, left: stackView.leftAnchor, bottom: nil, right: stackView.rightAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 100))
        editProfileButton.layer.cornerRadius = 2
        
    }
}
