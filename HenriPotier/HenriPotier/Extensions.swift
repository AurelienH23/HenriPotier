//
//  Extensions.swift
//  HenriPotier
//
//  Created by Aurélien Haie on 17/01/2021.
//

import UIKit

extension UIColor {

    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }

    static let hpGreen = UIColor.rgb(red: 11, green: 167, blue: 107)

}

extension UIView {

    func bounce() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.duration = 0.1
        animation.repeatCount = 1
        animation.autoreverses = true
        animation.fromValue = 1
        animation.toValue = 0.9

        layer.add(animation, forKey: "transform.scale")
    }

    func tabBarItemBounce() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.duration = 0.1
        animation.repeatCount = 1
        animation.autoreverses = true
        animation.fromValue = 1
        animation.toValue = 1.2

        layer.add(animation, forKey: "transform.scale")
    }

}
