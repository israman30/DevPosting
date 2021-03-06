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

import MaterialComponents.MaterialDialogs

class ProfileController: UIViewController {
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.font = .systemFont(ofSize: 30)
        label.textAlignment = .center
        label.isEnabled = true
        return label
    }()
    
    let titleNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username Title"
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = UIColor.darkColor()
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
    
    let repoLabel: UILabel = {
        let label = UILabel()
        label.text = "GitHub"
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    let editProfileButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Edit Profile", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        btn.backgroundColor = UIColor.darkColor()
        btn.customBorder()
        btn.customShadow()
        btn.addTarget(self, action: #selector(handleEditProfile), for: .touchUpInside)
        return btn
    }()
    
    let deleteAccountButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Delete Account", for: .normal)
        btn.setTitleColor(.redColor(), for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        btn.addTarget(self, action: #selector(handleDeleteAccount), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - userInfo holds user info to be passed into the textFields edit controller
    var userInfo: User?
    
    // MARK: - Edit profile handler { presents edit profile passing user info }
    @objc func handleEditProfile() {
        let editProfileController = EditProfileController()
        editProfileController.user = userInfo
        present(editProfileController, animated: true, completion: nil)
    }
    
    // MARK: - Delete account handler { uses a dialog to confirm or cancel the deletion }
    @objc func handleDeleteAccount() {
        let alertController = MDCAlertController(title: "Are you sure you want to delete your account?", message: "Press OK to proceed, or CANCEL.")
        let action = MDCAlertAction(title: "OK") { action in
            FirebaseServices.deleteUser()
            self.logoutAfterDeleteAccount()
        }
        let cancel = MDCAlertAction(title:"Cancel", handler: nil)
        alertController.addAction(action)
        alertController.addAction(cancel)

        present(alertController, animated:true, completion: nil)
    }
    // MARK: - Logout after delete handler { after account is deleted, go to login }
    private func logoutAfterDeleteAccount() {
        let loginController = LoginController()
        loginController.modalPresentationStyle = .fullScreen
        present(loginController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setProfileView()
        fetchUserInfo()
    }
    
    // MARK: - Fetch user info from Firebase Database + it's displayed on UI + uses userInfo to pass the object to edit profile fields
    func fetchUserInfo() {
        FirebaseServices.fetchUser { (user) in
            self.setProfileUI(with: user.username, email: user.email, title: user.title, repo: user.repo)
            self.userInfo = user
        }
    }
    
    // MARK: - Function helps to display user info in the UI when user is fetched from db
    func setProfileUI(with username: String, email: String, title: String, repo: String) {
        usernameLabel.text = username
        emailLabel.text = email
        titleNameLabel.text = title
        if !repo.isEmpty {
            repoLabel.text = repo
        } else {
            repoLabel.text = "GitHub"
        }
    }

}

// MARK: - Safari Controller block
import SafariServices

extension ProfileController: SFSafariViewControllerDelegate {
    
    // MARK: - Open safari controller with url+repo-username handler
    @objc func handleOpenSafariController() {
        guard let user = userInfo else { return }
        openSafari(with: user)
    }
    
    // MARK: - open safari function with user as parameter - url+repo
    func openSafari(with user: User?) {
        if user == nil || user?.repo == nil { return }
        guard let user = userInfo?.repo else { return }
        guard let url = URL(string: "https://github.com/\(user)") else { return }
        let safariController = SFSafariViewController(url: url)
        present(safariController, animated: true, completion: nil)
        safariController.delegate = self
    }
    // MARK: - Dismiss after button tapped
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}
