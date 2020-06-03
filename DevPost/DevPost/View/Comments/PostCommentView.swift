//
//  PostCommentView.swift
//  DevPost
//
//  Created by Israel Manzo on 6/2/20.
//  Copyright © 2020 Israel Manzo. All rights reserved.
//

import UIKit

extension PostCommentController {
    
    func setPostCommentsView() {
        view.backgroundColor = UIColor.mainColor()
        
        let lineView = UIView()
        lineView.backgroundColor = UIColor.darkColor()
        lineView.layer.cornerRadius = 5
        
        view.addSubview(lineView)
        lineView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, padding: .init(top: 15, left: 100, bottom: 0, right: 100), size: .init(width: 0, height: 6))
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: lineView.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, padding: .init(top: 40, left: 20, bottom: 0, right: 20), size: .init(width: 0, height: 0))
        
        view.addSubview(postCommentTextView)
        postCommentTextView.anchor(top: titleLabel.bottomAnchor, left: titleLabel.leftAnchor, bottom: nil, right: titleLabel.rightAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 300))
        postCommentTextView.layer.cornerRadius = 2

        let stackView = UIStackView(arrangedSubviews: [submitButton, dismissButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        
        submitButton.customBorder()

        view.addSubview(stackView)
        stackView.anchor(top: postCommentTextView.bottomAnchor, left: postCommentTextView.leftAnchor, bottom: nil, right: postCommentTextView.rightAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 100))
        
        postCommentTextView.customBorder()
    }
}
