//
//  MainCell.swift
//  DevPost
//
//  Created by Israel Manzo on 4/24/20.
//  Copyright © 2020 Israel Manzo. All rights reserved.
//

import UIKit

class MainCell: UITableViewCell {
    
    var post: Posts? {
        didSet {
            guard let username = post?.title else { return }
            titleLabel.text = username
            
            guard let detail = post?.detailPost else { return }
            usernameLabel.text = detail
            
            guard let date = post?.date else { return }
            
            if !date.isEmpty {
                dateLabel.text = date
            } else {
                dateLabel.text = "no date added"
            }
        }
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = UIColor(hex: "#578dde")
        return label
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "by John Doe"
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor(hex: "#363535")
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "10/12/2019"
        label.font = .systemFont(ofSize: 10)
        label.textColor = UIColor(hex: "#777777")
        label.textAlignment = .right
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor(hex: "#fcfbf0")
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, usernameLabel, dateLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        
        addSubview(stackView)
        stackView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, padding: .init(top: 10, left: 10, bottom: 10, right: 10))
     
        selectionStyle = .none
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

