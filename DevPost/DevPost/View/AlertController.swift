//
//  AlertController.swift
//  DevPost
//
//  Created by Israel Manzo on 4/25/20.
//  Copyright © 2020 Israel Manzo. All rights reserved.
//

import UIKit

struct AlertController {
    
    static func alert(_ viewController: UIViewController, title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(action)
        
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    static func actionSheet(viewController: UIAlertController, title: String, message: String){
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        // TODO: add aditional buttons
        
        actionSheet.addAction(cancel)
        // TODO: add aditional buttons in actionSheet
        
        viewController.present(actionSheet, animated: true, completion: nil)
    }
}
