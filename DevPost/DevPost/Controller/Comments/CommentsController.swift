//
//  CommentsController.swift
//  DevPost
//
//  Created by Israel Manzo on 5/20/20.
//  Copyright © 2020 Israel Manzo. All rights reserved.
//

import UIKit

import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_FilledTextFields
import MaterialComponents.MaterialTextControls_OutlinedTextAreas
import MaterialComponents.MaterialTextControls_OutlinedTextFields

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
        tv.isUserInteractionEnabled = false
        return tv
    }()
    
    let commentButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Comment", for: .normal)
        btn.setTitleColor(UIColor.blueColor(), for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 14)
        return btn
    }()
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.rowHeight = 60
        return tv
    }()
    
    var post: Posts?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setCommentsNavItems()
        setCommentView()
        
        print(post?.title)
        titleLabel.text = post?.title
        mainCommentTextView.text = post?.detailPost
        
    }
    
    @objc func handleDismissComment() {
        dismiss(animated: true, completion: nil)
    }
    
    
}

extension CommentsController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = "Title post"
        cell.detailTextLabel?.text = "detail post"
        return cell
    }
}

// MARK: - UITextField Delegate handler extension
extension CommentsController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    // MARK: - Keyboard dismiss when user touches any where out of the input textField
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
