//
//  MyComments+DelegateAndDatasource.swift
//  DevPost
//
//  Created by Israel Manzo on 5/23/20.
//  Copyright © 2020 Israel Manzo. All rights reserved.
//

import UIKit
import FirebaseDatabase
import DZNEmptyDataSet

extension MyCommentsController: UITableViewDelegate, UITableViewDataSource {
    
    func myCommentsRegisteringCellWithDelegateAndDataSource() {
        tableView.register(MyCommentsCell.self, forCellReuseIdentifier: "MyCommentsCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPost.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCommentsCell") as! MyCommentsCell
        cell.post = myPost[indexPath.row]
        cell.deletePostDelegate = self
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

extension MyCommentsController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func customView(forEmptyDataSet scrollView: UIScrollView!) -> UIView! {
        return MyCommentsCustomView()
    }
}

extension MyCommentsController: DeletePostDelegate {
    
    func didtapCommentIconCell(_ post: Posts) {
        
    }
}
