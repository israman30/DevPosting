//
//  MyCommentsCell.swift
//  DevPost
//
//  Created by Israel Manzo on 5/23/20.
//  Copyright © 2020 Israel Manzo. All rights reserved.
//

import UIKit

protocol DeletePostDelegate {
    func deleteIconTapped(_ cell: MyCommentsCell)
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
        iv.addTarget(self, action: #selector(handleDeleteUserPost), for: .touchUpInside)
        return iv
    }()
    
    lazy var editIconButton: UIButton = {
        let iv = UIButton(type: .system)
        iv.setImage(UIImage(named: "edit"), for: .normal)
        iv.addTarget(self, action: #selector(handleEditUserPost), for: .touchUpInside)
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
    
    var deletePostDelegate: DeletePostDelegate?
    
    @objc func handleEditUserPost() {
        print(123)
    }
    
    @objc func handleDeleteUserPost() {
        deletePostDelegate?.deleteIconTapped(self)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        let containerCell = UIView()
        containerCell.backgroundColor = UIColor.secondaryColor()
        containerCell.layer.cornerRadius = 5
        
        addSubview(containerCell)
        containerCell.fillSuperview(padding: .init(top: 5, left: 5, bottom: 5, right: 5))
        
        backgroundColor = UIColor.mainColor()
        
        setHeaderCell(containerCell)
        
    }
    
    func setHeaderCell(_ containerCell: UIView) {
        let titleHeaderView = UIView()
        
        containerCell.addSubview(titleHeaderView)
        titleHeaderView.anchor(top: containerCell.topAnchor, left: containerCell.leftAnchor, bottom: nil, right: containerCell.rightAnchor, padding: .zero, size: .zero)
        
        titleHeaderView.addSubview(titlePostLabel)
        titlePostLabel.anchor(top: titleHeaderView.topAnchor, left: titleHeaderView.leftAnchor, bottom: titleHeaderView.bottomAnchor, right: nil, padding: .init(top: 0, left: 10, bottom: 0, right: 0))
        titleHeaderView.addSubview(deleteIconButton)
//        deleteIconButton.backgroundColor = .red
        deleteIconButton.anchor(top: titleHeaderView.topAnchor, left: titlePostLabel.rightAnchor, bottom: titleHeaderView.bottomAnchor, right: titleHeaderView.rightAnchor, padding: .init(top: 5, left: 5, bottom: 5, right: 5), size: .init(width: 20, height: 20))
        titleHeaderView.addSubview(editIconButton)
//        editIconButton.backgroundColor = .yellow
        editIconButton.anchor(top: titleHeaderView.topAnchor, left: nil, bottom: titleHeaderView.bottomAnchor, right: deleteIconButton.leftAnchor, padding: .init(top: 5, left: 5, bottom: 5, right: 5), size: .init(width: 20, height: 20))
        
        setBodyCell(containerCell, titleHeaderView: titleHeaderView)
    }
    
    func setBodyCell(_ containerCell: UIView, titleHeaderView: UIView) {
        let footerCellHorizontalStackView = UIStackView(arrangedSubviews: [usernameLabel, dateLabel])
        footerCellHorizontalStackView.axis = .horizontal
        
        let stackView = UIStackView(arrangedSubviews: [descriptionPostLabel, footerCellHorizontalStackView])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        
        containerCell.addSubview(stackView)
        stackView.anchor(top: titleHeaderView.bottomAnchor, left: containerCell.leftAnchor, bottom: containerCell.bottomAnchor, right: containerCell.rightAnchor, padding: .init(top: 5, left: 10, bottom: 5, right: 10))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
