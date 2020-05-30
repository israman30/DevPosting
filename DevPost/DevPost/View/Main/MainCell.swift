//
//  MainCell.swift
//  DevPost
//
//  Created by Israel Manzo on 4/24/20.
//  Copyright © 2020 Israel Manzo. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class MainCell: UICollectionViewCell {
    
    var post: Posts? {
        didSet {
            guard let titlePost = post?.title else { return }
            titlePostLabel.text = titlePost
            
            guard let detail = post?.detailPost else { return }
            descriptionPostLabel.text = detail
            
            guard let date = post?.date else { return }
            
            if !date.isEmpty {
                dateLabel.text = date
            } else {
                dateLabel.text = "no date added"
            }
            
            guard let username = post?.username else { return }
            
            if !username.isEmpty {
                usernameLabel.text = "by \(username)"
            } else {
                usernameLabel.text = "Username"
            }
            
        }
    }
    
    let titlePostLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = UIColor.blueColor()
        return label
    }()
    
    let descriptionPostLabel: UILabel = {
        let label = UILabel()
        label.text = "by John Doe"
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "by John Doe"
        label.font = .systemFont(ofSize: 13)
        label.textColor = UIColor.usernameColor()
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "10/12/2019"
        label.font = .systemFont(ofSize: 10)
        label.textColor = UIColor.dateColor()
        label.textAlignment = .right
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let containerCell = UIView()
        containerCell.backgroundColor = UIColor.secondaryColor()
        containerCell.layer.cornerRadius = 5
        
        addSubview(containerCell)
        containerCell.fillSuperview(padding: .init(top: 5, left: 5, bottom: 5, right: 5))
        
        backgroundColor = UIColor.mainColor()
        
        let horizontalStackView = UIStackView(arrangedSubviews: [usernameLabel, dateLabel])
        horizontalStackView.axis = .horizontal
        
        let stackView = UIStackView(arrangedSubviews: [titlePostLabel, descriptionPostLabel, horizontalStackView])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        
        containerCell.addSubview(stackView)
        stackView.anchor(top: containerCell.topAnchor, left: containerCell.leftAnchor, bottom: containerCell.bottomAnchor, right: containerCell.rightAnchor, padding: .init(top: 5, left: 10, bottom: 5, right: 10))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

