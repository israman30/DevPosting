//
//  CommentsController.swift
//  DevPost
//
//  Created by Israel Manzo on 5/20/20.
//  Copyright © 2020 Israel Manzo. All rights reserved.
//

import UIKit

class CommentsController: UIViewController {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.blueColor()
        label.font = .boldSystemFont(ofSize: 20)
        label.backgroundColor = UIColor.secondaryColor()
        return label
    }()
    
    let mainCommentTextView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = UIColor.secondaryColor()
        tv.font = .systemFont(ofSize: 14)
        tv.sizeToFit()
        tv.isScrollEnabled = false
        tv.translatesAutoresizingMaskIntoConstraints = true
        return tv
    }()
    
    let postCommentTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Comment here.."
        tf.backgroundColor = .yellow
        return tf
    }()
    
    var post: Posts?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.mainColor()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleDismissComment))
        
        setCommentView()
        
        titleLabel.text = post?.title
        mainCommentTextView.text = post?.detailPost
        
        
    }
    
    @objc func handleDismissComment() {
        dismiss(animated: true, completion: nil)
    }
    
    func setCommentView() {
        let viewLabel = UIView()
        viewLabel.backgroundColor = UIColor.secondaryColor()
        
        view.addSubview(viewLabel)
        viewLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, padding: .init(top: 5, left: 5, bottom: 0, right: 5), size: .init(width: 0, height: 40))
        
        viewLabel.addSubview(titleLabel)
        titleLabel.anchor(top: viewLabel.topAnchor, left: viewLabel.leftAnchor, bottom: viewLabel.bottomAnchor, right: viewLabel.rightAnchor, padding: .init(top: 0, left: 5, bottom: 0, right: 5), size: .zero)
        
        view.addSubview(mainCommentTextView)
        mainCommentTextView.anchor(top: viewLabel.bottomAnchor, left: viewLabel.leftAnchor, bottom: nil, right: viewLabel.rightAnchor, padding: .zero, size: .init(width: 0, height: 0))
        mainCommentTextView.layer.cornerRadius = 3
    }
}
