//
//  CommentsController.swift
//  DevPost
//
//  Created by Israel Manzo on 5/20/20.
//  Copyright © 2020 Israel Manzo. All rights reserved.
//

import UIKit
import FirebaseDatabase

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
        btn.addTarget(self, action: #selector(handlerPostComment), for: .touchUpInside)
        return btn
    }()
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.rowHeight = 60
        return tv
    }()
    
    var post: Posts?
    
    var comments = [Comments]()
    
    @objc func handlerPostComment() {
        let postCommentController = PostCommentController()
        postCommentController.post = post
        present(postCommentController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewResgiterCellWithDelegateDataSource()
        setCommentsNavItems()
        setCommentView()
        
        guard let title = post?.title, let detailPost = post?.detailPost else { return }
        titleLabel.text = title
        mainCommentTextView.text = detailPost
        fetchPosts()
    }
    
    // MARK: - Fetching post by postId and render tableView
    func fetchPosts() {
        FirebaseServices.fetchComments(post) { (comment) in
            guard let comment = comment else { return }
            self.comments.append(comment)
            self.comments.sort(by: { $0.date.compare($1.date) == .orderedAscending })
            self.tableView.reloadData()
        }
    }
    
    @objc func handleDismissComment() {
        dismissView()
    }
    
    
}

import DZNEmptyDataSet

extension CommentsController: UITableViewDataSource, UITableViewDelegate {
    
    func setTableViewResgiterCellWithDelegateDataSource() {
        tableView.register(CommentsCell.self, forCellReuseIdentifier: CellId.commentsCell.rawValue)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.mainColor()
        tableView.separatorStyle = .none
        tableView.bounces = false
        
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellId.commentsCell.rawValue) as! CommentsCell
        cell.comments = comments[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = 500
        let padding: CGFloat = 30
        let text = comments[indexPath.row].comment
        height = estimateFrameForText(text: text).height + padding
        return height
    }
    
    // MARK: - Dynamic component calculations
    private func estimateFrameForText(text: String) -> CGRect {
        let height: CGFloat = 1000
        let size = CGSize(width: view.frame.width, height: height)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)]

        return NSString(string: text).boundingRect(with: size, options: options, attributes: attributes, context: nil)
    }
    
}

extension CommentsController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
//    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
//        let attributedString = NSAttributedString(string: "No comments yet", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 30)])
//        return attributedString
//    }
    
    func customView(forEmptyDataSet scrollView: UIScrollView!) -> UIView! {
        return CommentsCustomView()
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
