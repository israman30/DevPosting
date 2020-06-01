//
//  MyCommentsView.swift
//  DevPost
//
//  Created by Israel Manzo on 5/23/20.
//  Copyright © 2020 Israel Manzo. All rights reserved.
//

import UIKit

extension MyCommentsController {
    
    func setNavbarItems() {
        let titleView = UIView()
        titleView.frame = .init(x: 0, y: 0, width: 150, height: 40)
        
        let titleLabel = UILabel()
        titleLabel.text = "My Comments"
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.darkColor()
        titleView.addSubview(titleLabel)
        titleLabel.frame = titleView.frame
        navigationItem.titleView = titleView
        setNavbarRefreshButton()
    }
    
    func setMyCommentView() {
        view.backgroundColor = UIColor.mainColor()
        
        view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, padding: .zero, size: .zero)
    }
    
    func setNavbarRefreshButton() {
        navigationItem.na
    }
}
