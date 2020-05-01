//
//  PostView.swift
//  DevPost
//
//  Created by Israel Manzo on 4/25/20.
//  Copyright © 2020 Israel Manzo. All rights reserved.
//

import UIKit

extension PostController {
    
    func setPostView() {
        view.backgroundColor = UIColor.mainColor()
        
        view.addSubview(titleTextField)
        titleTextField.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, padding: .init(top: 40, left: 20, bottom: 0, right: 20), size: .init(width: 0, height: 0))
        
        titleTextField.layer.borderColor = UIColor.black.cgColor
        titleTextField.layer.borderWidth = 0.5
        
        view.addSubview(detailPostTextView)
        detailPostTextView.anchor(top: titleTextField.bottomAnchor, left: titleTextField.leftAnchor, bottom: nil, right: titleTextField.rightAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 300))

        let stackView = UIStackView(arrangedSubviews: [submitButton, dismissButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        
        submitButton.layer.borderColor = UIColor.black.cgColor
        submitButton.layer.borderWidth = 0.5

        view.addSubview(stackView)
        stackView.anchor(top: detailPostTextView.bottomAnchor, left: detailPostTextView.leftAnchor, bottom: nil, right: detailPostTextView.rightAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 100))
        
        detailPostTextView.layer.borderColor = UIColor.black.cgColor
        detailPostTextView.layer.borderWidth = 0.5
    }
}


