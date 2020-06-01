//
//  MainView.swift
//  DevPost
//
//  Created by Israel Manzo on 4/28/20.
//  Copyright © 2020 Israel Manzo. All rights reserved.
//

import UIKit

extension MainController {
    
    func setNavigationItems() {
        view.backgroundColor = UIColor.mainColor()
        navigationItem.title = "Dev Post"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
        
        let addButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
        
        let refreshButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(handleRefresh))
        
        navigationItem.rightBarButtonItems = [addButtonItem, refreshButtonItem]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
    }
    
}

