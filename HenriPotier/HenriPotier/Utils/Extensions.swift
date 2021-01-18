//
//  Extensions.swift
//  HenriPotier
//
//  Created by Aurélien Haie on 17/01/2021.
//

import UIKit

// MARK: UIColor
extension UIColor {

    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }

    static let hpGreen = UIColor.rgb(red: 11, green: 167, blue: 107)
    static let hpGreenBg = UIColor.rgb(red: 11, green: 167, blue: 107, alpha: 0.1)
    static let hpLightGray = UIColor.rgb(red: 240, green: 240, blue: 240)
    static let hpGray = UIColor.rgb(red: 200, green: 200, blue: 200)

}

// MARK: UIView
extension UIView {

    func addSubviews(_ views: UIView...) {
        views.forEach { (view) in
            addSubview(view)
        }
    }

    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {

        translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }

    func anchor(to view: UIView) {
        anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }

    func anchor(to view: UIView, padding: CGFloat) {
        anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: padding, paddingLeft: padding, paddingBottom: padding, paddingRight: padding, width: 0, height: 0)
    }

    func centerVertically(to view: UIView) {
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    func centerHorizontally(to view: UIView) {
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

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

// MARK: CGFloat
extension CGFloat {

    static var topPadding: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }

    static var bottomPadding: CGFloat {
        var bottomPadding: CGFloat = 0
        if self.topPadding > 20 {
            bottomPadding = 20
        }
        return bottomPadding
    }

    // Corner radius
    /** 4 */
    static let smallCornerRadius = CGFloat(integerLiteral: 4)
    /** 8 */
    static let mediumCornerRadius = CGFloat(integerLiteral: 8)
    /** 16 */
    static let largeCornerRadius = CGFloat(integerLiteral: 16)
    /** 32 */
    static let extraLargeCornerRadius = CGFloat(integerLiteral: 32)

    // Spacing
    /** 8 */
    static let smallSpace = CGFloat(integerLiteral: 8)
    /** 16 */
    static let mediumSpace = CGFloat(integerLiteral: 16)
    /** 24 */
    static let largeSpace = CGFloat(integerLiteral: 24)
    /** 32 */
    static let extraLargeSpace = CGFloat(integerLiteral: 32)
    /** 44 */
    static let standardTouchSpace = CGFloat(integerLiteral: 44)

}

// MARK: UIFont
extension UIFont {

    static func bookTitle() -> UIFont {
        return UIFont(descriptor: UIFontDescriptor.preferredFontDescriptor(withTextStyle: .largeTitle).withDesign(.serif)!, size: 20)
    }

}

// MARK: Notification.Name
extension Notification.Name {

    static let cartUpdated = Notification.Name("cartUpdated")

}
