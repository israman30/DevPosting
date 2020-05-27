//
//  MyCommentsCell.swift
//  DevPost
//
//  Created by Israel Manzo on 5/23/20.
//  Copyright © 2020 Israel Manzo. All rights reserved.
//

import UIKit

protocol DeletePostDelegate {
    func didtapCommentIconCell(_ post: Posts)
}

class MyCommentsCell: UITableViewCell {
    
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
    
    lazy var deleteIconButton: UIButton = {
        let iv = UIButton(type: .system)
        iv.setImage(UIImage(named: "trash"), for: .normal)
//        iv.backgroundColor = .red
        iv.addTarget(self, action: #selector(handleDeleteUserPost), for: .touchUpInside)
        return iv
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
    
    var deletePostDelegate: DeletePostDelegate?
    
//    @objc func goToCommentSection() {
//        guard let post = post else { return }
//        deletePostDelegate?.didtapCommentIconCell(post)
//        print("Delegate for cell")
//    }
    
    @objc func handleDeleteUserPost() {
        print("Delete post")
        guard let post = post else { return }
        deletePostDelegate?.didtapCommentIconCell(post)
//        print("Delegate for cell")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let containerCell = UIView()
        containerCell.backgroundColor = UIColor.secondaryColor()
        containerCell.layer.cornerRadius = 5
        
        addSubview(containerCell)
        containerCell.fillSuperview(padding: .init(top: 5, left: 5, bottom: 5, right: 5))
        
        backgroundColor = UIColor.mainColor()
        
        let titleHeaderStackView = UIStackView(arrangedSubviews: [titlePostLabel, deleteIconButton])
        titleHeaderStackView.axis = .horizontal
        titleHeaderStackView.distribution = .fillProportionally
        
        let horizontalStackView = UIStackView(arrangedSubviews: [usernameLabel, dateLabel])
        horizontalStackView.axis = .horizontal
        
        let stackView = UIStackView(arrangedSubviews: [titleHeaderStackView, descriptionPostLabel, horizontalStackView])
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
