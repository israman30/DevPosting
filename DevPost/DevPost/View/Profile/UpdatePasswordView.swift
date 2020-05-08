//
//  UpdatePasswordView.swift
//  DevPost
//
//  Created by Israel Manzo on 5/7/20.
//  Copyright © 2020 Israel Manzo. All rights reserved.
//

import UIKit

extension UpdatePasswordController {
    
    func setUpdatePasswordView() {
        view.backgroundColor = UIColor.mainColor()
        
        let lineView = UIView()
        lineView.backgroundColor = UIColor(hex: "#484848")
        lineView.layer.cornerRadius = 5
        
        view.addSubview(lineView)
        lineView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, padding: .init(top: 15, left: 100, bottom: 0, right: 100), size: .init(width: 0, height: 6))
        
        view.addSubview(newPasswordTextField)
        newPasswordTextField.anchor(top: lineView.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, padding: .init(top: 100, left: 20, bottom: 0, right: 20), size: .init(width: 0, height: 60))
        newPasswordTextField.customBorder()
        
        view.addSubview(updateButton)
        updateButton.anchor(top: newPasswordTextField.bottomAnchor, left: newPasswordTextField.leftAnchor, bottom: nil, right: newPasswordTextField.rightAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 45))
        updateButton.layer.cornerRadius = 2
        
        view.addSubview(cancelUpdatePasswordLabel)
        cancelUpdatePasswordLabel.anchor(top: updateButton.bottomAnchor, left: updateButton.leftAnchor, bottom: nil, right: updateButton.rightAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 30))
    }
}
