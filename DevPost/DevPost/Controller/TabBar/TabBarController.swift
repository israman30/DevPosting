//
//  TabBarController.swift
//  DevPost
//
//  Created by Israel Manzo on 5/5/20.
//  Copyright © 2020 Israel Manzo. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = UIColor.secondaryColor()
        
        let nav = UINavigationController(rootViewController: MainController())
        nav.title = "Posts"
        nav.tabBarItem.image = UIImage(named: "post")
        
        let profileController = setTabBarController(viewController: ProfileController(), itemImage: "profile", title: "Profile")
        
        let settingController = setTabBarController(viewController: SettingsController(), itemImage: "setting", title: "Settings")
        
        viewControllers = [nav, profileController, settingController]
        
        tabBar.isTranslucent = false
        
        // MARK: - Custom border view on top of tab bar
        let border = CALayer()
        border.frame = CGRect(x: 0, y: 0, width: 1000, height: 0.5)
        border.backgroundColor = UIColor.black.cgColor
        tabBar.layer.addSublayer(border)
        tabBar.clipsToBounds = true
    }
}
extension UITabBarController {
    
    func setTabBarController(viewController: UIViewController, itemImage: String = "", title: String)-> UINavigationController {
        let viewController = viewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = UIImage(named: itemImage)
        navController.title = title
        
        return navController
    }
}
