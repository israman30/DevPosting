//
//  MyCommentsController.swift
//  DevPost
//
//  Created by Israel Manzo on 5/20/20.
//  Copyright © 2020 Israel Manzo. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class MyCommentsController: UIViewController {
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.rowHeight = 60
        tv.backgroundColor = UIColor.mainColor()
        tv.separatorColor = .clear
        return tv
    }()
    
    var myPost: [Posts] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "My Comments"
        tableView.register(MyCommentsCell.self, forCellReuseIdentifier: "MyCommentsCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        setMyCommentView()

        
        Auth.auth().addStateDidChangeListener { (auth, user) in

            guard let user = user?.uid else { return }
            FirebaseServices.observeUserPost { (post) in
                if user == post.userId {
                    self.myPost.append(post)
                    self.tableView.reloadData()
                } else {
                    self.tableView.reloadData()
                }
            }
            self.myPost = []
        }
        
        
    }
    
    
    func setMyCommentView() {
        view.backgroundColor = UIColor.mainColor()
        
        view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, padding: .zero, size: .zero)
    }
}

extension MyCommentsController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPost.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCommentsCell") as! MyCommentsCell
        cell.post = myPost[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = 500
        let padding: CGFloat = 60
        let text = myPost[indexPath.row].detailPost
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
    
    lazy var commentButtonIcon: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "comment"), for: .normal)
        btn.addTarget(self, action: #selector(goToCommentSection), for: .touchUpInside)
        return btn
    }()
    
    var commentDelegate: CommentDelegate?
    
    @objc func goToCommentSection() {
        guard let post = post else { return }
        commentDelegate?.didtapCommentIconCell(post)
    }
    
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
        
        let stackView = UIStackView(arrangedSubviews: [titlePostLabel, descriptionPostLabel, horizontalStackView])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        
        containerCell.addSubview(stackView)
        stackView.anchor(top: containerCell.topAnchor, left: containerCell.leftAnchor, bottom: containerCell.bottomAnchor, right: containerCell.rightAnchor, padding: .init(top: 5, left: 10, bottom: 5, right: 10))
        
        setCommentButton(stackView)
    }
    
    func setCommentButton(_ stackView: UIStackView) {
        stackView.addSubview(commentButtonIcon)
        commentButtonIcon.anchor(top: stackView.topAnchor, left: nil, bottom: nil, right: stackView.rightAnchor, padding: .zero, size: .init(width: 15, height: 15))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
