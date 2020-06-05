//
//  MainView.swift
//  DevPost
//
//  Created by Israel Manzo on 4/28/20.
//  Copyright © 2020 Israel Manzo. All rights reserved.
//

import UIKit

extension MainController {
    
    // MARK: - Set searchBar + referencing constraint for hidding animation
    func setSearchBar() {
        view.addSubview(searchBar)
        searchBar.delegate = self
//        searchBar.barStyle = .blackOpaque
        searchBar.placeholder = "Search..."
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        searchBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        heightConstraint = searchBar.heightAnchor.constraint(equalToConstant: 0)
        heightConstraint?.isActive = true
    }
    
    // MARK: - ****************** Navbar settgins ******************
    /*
     - mainColor view
     - navbar app title
     - right bar button items for refresh & add handler post
     - left bar button item for logout handler
     **/
    
    func setNavigationItems() {
        view.backgroundColor = UIColor.mainColor()
        navigationItem.title = "Dev Post"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
        
        let refreshButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(handleRefresh))
        
        let searchButonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleShowSearchIcon))
        
        navigationItem.rightBarButtonItems = [addButtonItem, refreshButtonItem,searchButonItem]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
    }
    
}

