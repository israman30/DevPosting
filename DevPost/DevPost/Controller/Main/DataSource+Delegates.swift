//
//  DataSource+Delegates.swift
//  DevPost
//
//  Created by Israel Manzo on 5/12/20.
//  Copyright © 2020 Israel Manzo. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

extension MainController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Set collectionView on parent view
    /*
     - hidding vertical indicator
     - setbakcgroundColor using mainColor()
     - registering cell class for current collectionView
     - delegates & dataSource for current collectionView
     - delegates & dataSource for DZN empty data set
     */
    
    func collectionViewCellRegiterWithDataSourceAndDelegates() {
        view.addSubview(collectionView)
        collectionView.anchor(top: searchBar.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor.mainColor()
        collectionView.register(MainCell.self, forCellWithReuseIdentifier: CellId.main.rawValue)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.emptyDataSetSource = self
        collectionView.emptyDataSetDelegate = self

    }
    
    // MARK: - Data source & delegates flowLayout methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if showResult {
            return filteredPosts.count
        }
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellId.main.rawValue, for: indexPath) as! MainCell
        if showResult {
            cell.post = filteredPosts[indexPath.item]
            return cell
        }
        cell.post = posts[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 500
        let padding: CGFloat = 60
        if showResult {
            let filteredText = filteredPosts[indexPath.item].detailPost
            height = estimateFrameForText(text: filteredText).height + padding
            return .init(width: view.frame.width, height: height)
        }
        let text = posts[indexPath.item].detailPost
        height = estimateFrameForText(text: text).height + padding
        
        return .init(width: view.frame.width, height: height)
    }
    
    // MARK: - Dynamic component calculations
    private func estimateFrameForText(text: String) -> CGRect {
        let height: CGFloat = 1000
        let size = CGSize(width: view.frame.width, height: height)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)]

        return NSString(string: text).boundingRect(with: size, options: options, attributes: attributes, context: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let commentsController = CommentsController()
        if showResult {
            commentsController.post = filteredPosts[indexPath.item]
        } else {
            commentsController.post = posts[indexPath.item]
        }
        let nav = UINavigationController(rootViewController: commentsController)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
}
// MARK: - DZN Empty Data Set Section
extension MainController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    func customView(forEmptyDataSet scrollView: UIScrollView!) -> UIView! {
        return CustomView()
    }
    
}
