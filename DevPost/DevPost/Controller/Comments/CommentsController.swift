//
//  CommentsController.swift
//  DevPost
//
//  Created by Israel Manzo on 5/20/20.
//  Copyright © 2020 Israel Manzo. All rights reserved.
//

import UIKit

class CommentsController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.mainColor()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleDismissComment))
    }
    
    @objc func handleDismissComment() {
        dismiss(animated: true, completion: nil)
    }
}
