//
//  PostDisplayController.swift
//  DevPost
//
//  Created by Israel Manzo on 4/28/20.
//  Copyright © 2020 Israel Manzo. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class PostDisplayController: UIViewController {
    
    var posts: Posts?
    
    let titleDisplayLabel: UILabel = {
        let label = UILabel()
        label.text = "Title Goes here"
        label.backgroundColor = UIColor(hex: "#fcf5d2")
        label.textColor = .darkGray
        label.font = .boldSystemFont(ofSize: 25)
        return label
    }()
    
    let textViewPostDisplay: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = UIColor(hex: "#fcf5d2")
        tv.font = .systemFont(ofSize: 15)
        tv.isUserInteractionEnabled = false
        return tv
    }()
    
    let editButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Edit post", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = UIColor(hex: "#4f8c50")
        btn.titleLabel?.font = .boldSystemFont(ofSize: 13)
        btn.layer.cornerRadius = 2
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setpostDisplayView()
        
        guard let title = posts?.title, let detailPost = posts?.detailPost else { return }
        titleDisplayLabel.text = title
        textViewPostDisplay.text = detailPost
        fetUsername()
    }
    
    func fetUsername() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Database.database().reference().child("users").child(uid).observe(.value) { (snapshot) in
            if let dict = snapshot.value as? [String:Any]{
                if let username = dict["username"] as? String {
                    self.navigationItem.title = username
                }
            }
        }
    }

}

extension PostDisplayController {
    
    func setpostDisplayView() {
        view.backgroundColor = UIColor.mainColor()
        
        view.addSubview(titleDisplayLabel)
        titleDisplayLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: 10), size: .init(width: 0, height: 45))
        
        view.addSubview(textViewPostDisplay)
        textViewPostDisplay.anchor(top: titleDisplayLabel.bottomAnchor, left: titleDisplayLabel.leftAnchor, bottom: nil, right: titleDisplayLabel.rightAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 350))
        
        view.addSubview(editButton)
        editButton.anchor(top: textViewPostDisplay.bottomAnchor, left: nil, bottom: nil, right: textViewPostDisplay.rightAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 100, height: 20))
        
        editButton.customBorder()
        
        titleDisplayLabel.setShadow()
        textViewPostDisplay.setShadow()
        

    }
}


