//
//  Posts.swift
//  DevPost
//
//  Created by Israel Manzo on 4/28/20.
//  Copyright © 2020 Israel Manzo. All rights reserved.
//

import Foundation

struct User {
    let username, email, title, repo: String
    let posts: Posts?
    init(dict: [String:Any]) {
        self.username = dict["username"] as? String ?? ""
        self.email = dict["email"] as? String ?? ""
        self.title = dict["title"] as? String ?? ""
        self.repo = dict["repo"] as? String ?? ""
        self.posts = nil
    }
}

struct Posts {
    let title: String
    let detailPost: String
    let date: String
    let username: String
    let userId, postId: String
    init(dict: [String:Any]) {
        self.title = dict["title"] as? String ?? ""
        self.detailPost = dict["detailPost"] as? String ?? ""
        self.date = dict["date"] as? String ?? ""
        self.username = dict["username"] as? String ?? ""
        self.userId = dict["userId"] as? String ?? ""
        self.postId = dict["postId"] as? String ?? ""
    }
}
