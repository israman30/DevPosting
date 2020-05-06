//
//  ProfileController.swift
//  DevPost
//
//  Created by Israel Manzo on 5/5/20.
//  Copyright © 2020 Israel Manzo. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ProfileController: UIViewController {
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.font = .systemFont(ofSize: 30)
        label.textAlignment = .center
        label.isEnabled = true
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "johndoe@mail.com"
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    let editProfileButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Edit Profile", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        btn.backgroundColor = UIColor.darkColor()
        btn.customBorder()
        return btn
    }()
    
    let updatePasswordButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Update Password", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        btn.backgroundColor = UIColor.blueColor()
        btn.customBorder()
        btn.addTarget(self, action: #selector(handleUpdatePassword), for: .touchUpInside)
        return btn
    }()
    
    @objc func handleUpdatePassword() {
        let updatePasswordController = UpdatePasswordController()
        present(updatePasswordController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setProfileView()
    }
    
    
}
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
        containerView.addSubview(usernameBottonLineView)
        usernameBottonLineView.anchor(top: usernameLabel.bottomAnchor, left: usernameLabel.leftAnchor, bottom: nil, right: usernameLabel.rightAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 5))
        
        containerView.addSubview(emailLabel)
        emailLabel.anchor(top: usernameBottonLineView.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 250, height: 30))
        
        let stackView = UIStackView(arrangedSubviews: [editProfileButton, updatePasswordButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        
        containerView.addSubview(stackView)
        stackView.anchor(top: nil, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, padding: .init(top: 0, left: 10, bottom: 10, right: 10), size: .init(width: 0, height: 100))
        editProfileButton.layer.cornerRadius = 2
        updatePasswordButton.layer.cornerRadius = 2

    }
}
