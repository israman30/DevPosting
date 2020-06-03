//
//  CommenstCell.swift
//  DevPost
//
//  Created by Israel Manzo on 6/2/20.
//  Copyright © 2020 Israel Manzo. All rights reserved.
//

import UIKit

class CommentsCell: UITableViewCell {
    
    var comments: Comments? {
        didSet {
            
            guard let comment = comments?.comment else { return }
            commentLabel.text = comment
            
            guard let date = comments?.date else { return }
            
            if !date.isEmpty {
                dateLabel.text = date
            } else {
                dateLabel.text = "no date added"
            }
            
            guard let username = comments?.user else { return }
            
            if !username.isEmpty {
                usernameLabel.text = "by \(username)"
            } else {
                usernameLabel.text = "Username"
            }
            
        }
    }
    
    let commentLabel: UILabel = {
        let label = UILabel()
        label.text = "by John Doe"
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 0
        return label
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "by John Doe"
        label.font = .systemFont(ofSize: 8)
        label.textColor = UIColor.usernameColor()
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "10/12/2019"
        label.font = .systemFont(ofSize: 8)
        label.textColor = UIColor.dateColor()
        label.textAlignment = .right
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let containerCell = UIView()
        containerCell.backgroundColor = UIColor.secondaryColor()
        containerCell.layer.cornerRadius = 5
        
        addSubview(containerCell)
        containerCell.fillSuperview(padding: .init(top: 5, left: 5, bottom: 5, right: 5))
        
        backgroundColor = UIColor.mainColor()
        
        let horizontalStackView = UIStackView(arrangedSubviews: [usernameLabel, dateLabel])
        horizontalStackView.axis = .horizontal
        
        let stackView = UIStackView(arrangedSubviews: [commentLabel, horizontalStackView])
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
