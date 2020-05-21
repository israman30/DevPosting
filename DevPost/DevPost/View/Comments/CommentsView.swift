//
//  CommentsView.swift
//  DevPost
//
//  Created by Israel Manzo on 5/20/20.
//  Copyright © 2020 Israel Manzo. All rights reserved.
//

import UIKit

extension CommentsController {
    
    func setCommentsNavItems() {
        view.backgroundColor = UIColor.mainColor()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleDismissComment))
    }
    
    func setCommentView() {
        let viewLabel = UIView()
        viewLabel.backgroundColor = UIColor.secondaryColor()
        
        view.addSubview(viewLabel)
        viewLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, padding: .init(top: 5, left: 5, bottom: 0, right: 5), size: .init(width: 0, height: 40))
        
        viewLabel.addSubview(titleLabel)
        titleLabel.anchor(top: viewLabel.topAnchor, left: viewLabel.leftAnchor, bottom: viewLabel.bottomAnchor, right: viewLabel.rightAnchor, padding: .init(top: 0, left: 5, bottom: 0, right: 5), size: .zero)
        
        view.addSubview(mainCommentTextView)
        mainCommentTextView.anchor(top: viewLabel.bottomAnchor, left: viewLabel.leftAnchor, bottom: nil, right: viewLabel.rightAnchor, padding: .zero, size: .init(width: 0, height: 0))
        mainCommentTextView.layer.cornerRadius = 3
        
        view.addSubview(commentButton)
        commentButton.anchor(top: mainCommentTextView.bottomAnchor, left: mainCommentTextView.leftAnchor, bottom: nil, right: mainCommentTextView.rightAnchor, padding: .zero, size: .init(width: 0, height: 30))
        setCommentsTableView(commentButton)
    }
    
    func setCommentsTableView(_ commentButton: UIButton) {
        view.addSubview(tableView)
        tableView.anchor(top: commentButton.bottomAnchor, left: commentButton.leftAnchor, bottom: view.bottomAnchor, right: commentButton.rightAnchor, padding: .zero, size: .zero)
    }
}
