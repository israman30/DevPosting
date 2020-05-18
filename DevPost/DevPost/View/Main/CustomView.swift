//
//  CustomView.swift
//  DevPost
//
//  Created by Israel Manzo on 5/18/20.
//  Copyright © 2020 Israel Manzo. All rights reserved.
//

import UIKit

class CustomView: UIView {
    
    let nameLabel = UILabel()
    
    let robotImageView = UIImageView(image: UIImage(named: "robot"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        nameLabel.text = "Dev Post"
        nameLabel.font = .boldSystemFont(ofSize: 30)
        nameLabel.textAlignment = .center
        nameLabel.textColor = UIColor.darkColor()
        
        let stackView = UIStackView(arrangedSubviews: [robotImageView, nameLabel])
        stackView.axis = .vertical
        
        addSubview(stackView)
        stackView.centerInSuperview(size: .init(width: 200, height: 230))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
