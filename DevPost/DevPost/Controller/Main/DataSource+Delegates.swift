//
//  DataSource+Delegates.swift
//  DevPost
//
//  Created by Israel Manzo on 5/12/20.
//  Copyright © 2020 Israel Manzo. All rights reserved.
//

import UIKit

extension MainController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionViewCellRegiterWithDataSourceAndDelegates() {
        view.addSubview(collectionView)
        collectionView.fillSuperview()
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor.mainColor()
        collectionView.register(MainCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MainCell
        cell.post = posts[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 500
        let padding: CGFloat = 60
        let text = posts[indexPath.item].detailPost
        height = estimateFrameForText(text: text).height + padding
        
        return .init(width: view.frame.width, height: height)
    }
    
    private func estimateFrameForText(text: String) -> CGRect {
        let height: CGFloat = 1000
        let size = CGSize(width: view.frame.width, height: height)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)]

        return NSString(string: text).boundingRect(with: size, options: options, attributes: attributes, context: nil)
    }
    
    
}
