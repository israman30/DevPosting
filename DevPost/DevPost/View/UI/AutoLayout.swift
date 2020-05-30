//
//  AutoLayout.swift
//  DevPost
//
//  Created by Israel Manzo on 4/24/20.
//  Copyright © 2020 Israel Manzo. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func setShadow() {
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 1
        layer.shadowOpacity = 0.2
        layer.cornerRadius = 2
    }
}

extension UIView {
    
    func customBorder() {
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 0.5
    }
    
    func customShadow() {
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 0.0
        layer.masksToBounds = false
        layer.cornerRadius = 4.0
    }
}


// UIColor extension
extension UIColor {
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        
        let length = hexSanitized.count
        
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }
        
        switch length {
        case 6:
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
        case 8:
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
        default:
            return nil
        }
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    static func  mainColor() -> UIColor? {
        return UIColor(hex: "fcfbf0")
    }
    static func secondaryColor() -> UIColor? {
        return UIColor(hex: "#fcf5d2")
    }
    static func darkColor() -> UIColor? {
        return UIColor(hex: "#484848")
    }
    static func greenColor() -> UIColor? {
        return UIColor(hex: "#4f8c50")
    }
    static func redColor() -> UIColor? {
        return UIColor(hex: "#d61122")
    }
    static func blueColor() -> UIColor? {
        return UIColor(hex: "#578dde")
    }
    static func usernameColor() -> UIColor? {
        return UIColor(hex: "#363535")
    }
    static func dateColor() -> UIColor? {
        return UIColor(hex: "#777777")
    }
    static func inputBackgroundColor() -> UIColor? {
        return UIColor(hex: "#f0f1f2")
    }
}

struct AnchoredConstraints {
    var top, left, bottom, right, width, height: NSLayoutConstraint?
}

extension UIView {
    
    @discardableResult
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) -> AnchoredConstraints {
        
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        
        if let top = top {
            anchoredConstraints.top = topAnchor.constraint(
                equalTo: top,
                constant: padding.top
            )
        }
        
        if let left = left {
            anchoredConstraints.left = leftAnchor.constraint(
                equalTo: left,
                constant: padding.left
            )
        }
        
        if let bottom = bottom {
            anchoredConstraints.bottom = bottomAnchor.constraint(
                equalTo: bottom,
                constant: -padding.bottom
            )
        }
        
        if let right = right {
            anchoredConstraints.right = rightAnchor.constraint(
                equalTo: right,
                constant: -padding.right
            )
        }
        
        if size.width != 0 {
            anchoredConstraints.width = widthAnchor.constraint(
                equalToConstant: size.width
            )
        }
        
        if size.height != 0 {
            anchoredConstraints.height = heightAnchor.constraint(
                equalToConstant: size.height
            )
        }
        
        [anchoredConstraints.top,
         anchoredConstraints.left,
         anchoredConstraints.bottom,
         anchoredConstraints.right,
         anchoredConstraints.width,
         anchoredConstraints.height].forEach{ $0?.isActive = true }
        
        return anchoredConstraints
    }
    
    func fillSuperview(padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewTopAnchor = superview?.topAnchor {
            topAnchor.constraint(
                equalTo: superviewTopAnchor,
                constant: padding.top
                ).isActive = true
        }
        
        if let superviewBottomAnchor = superview?.bottomAnchor {
            bottomAnchor.constraint(
                equalTo: superviewBottomAnchor,
                constant: -padding.bottom
                ).isActive = true
        }
        
        if let superviewLeadingAnchor = superview?.leadingAnchor {
            leadingAnchor.constraint(
                equalTo: superviewLeadingAnchor,
                constant: padding.left
                ).isActive = true
        }
        
        if let superviewTrailingAnchor = superview?.trailingAnchor {
            trailingAnchor.constraint(
                equalTo: superviewTrailingAnchor,
                constant: -padding.right
                ).isActive = true
        }
    }
    
    func centerInSuperview(size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }
        
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
}
