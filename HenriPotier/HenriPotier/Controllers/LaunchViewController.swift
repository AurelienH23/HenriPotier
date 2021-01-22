//
//  LaunchViewController.swift
//  HenriPotier
//
//  Created by Aurélien Haie on 19/01/2021.
//

import UIKit

class LaunchViewController: UIViewController {

    // MARK: View elements

    private let logo = UIImageView(image: UIImage(named: "logo"))

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        launchAnimation()
    }

    // MARK: Custom funcs

    private func setupViews() {
        view.addSubview(logo)
        
        logo.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 200)
        logo.centerHorizontally(to: view)
        logo.centerVertically(to: view)

        logo.transform = CGAffineTransform(translationX: 0, y: 5)
    }

    private func launchAnimation() {
        UIView.animate(withDuration: 1, delay: 1, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseIn) {
            self.logo.transform = CGAffineTransform(translationX: 0, y: -20).scaledBy(x: 0.8, y: 0.8)
            self.logo.alpha = 0
        } completion: { _ in
            NotificationCenter.default.post(name: NSNotification.Name("startApp"), object: nil)
        }
    }

}
