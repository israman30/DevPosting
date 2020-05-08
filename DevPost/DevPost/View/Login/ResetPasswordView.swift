//
//  ResetPasswordView.swift
//  DevPost
//
//  Created by Israel Manzo on 5/8/20.
//  Copyright © 2020 Israel Manzo. All rights reserved.
//

import UIKit

extension ResetPasswordController {
    
    func resetPasswordView() {
        view.backgroundColor = UIColor.mainColor()
        
        let lineView = UIView()
        lineView.backgroundColor = UIColor(hex: "#484848")
        lineView.layer.cornerRadius = 5
        
        view.addSubview(lineView)
        lineView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, padding: .init(top: 15, left: 100, bottom: 0, right: 100), size: .init(width: 0, height: 6))
        
        view.addSubview(emailTextField)
        emailTextField.anchor(top: lineView.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, padding: .init(top: 40, left: 20, bottom: 0, right: 20), size: .init(width: 0, height: 60))
        emailTextField.customBorder()
        
        view.addSubview(resetButton)
        resetButton.anchor(top: emailTextField.bottomAnchor, left: emailTextField.leftAnchor, bottom: nil, right: emailTextField.rightAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 45))
        resetButton.layer.cornerRadius = 2
        
        view.addSubview(cancelResetPasswordLabel)
        cancelResetPasswordLabel.anchor(top: resetButton.bottomAnchor, left: resetButton.leftAnchor, bottom: nil, right: resetButton.rightAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 30))
    }
}
