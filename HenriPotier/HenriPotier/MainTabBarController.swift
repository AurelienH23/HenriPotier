//
//  MainTabBarController.swift
//  HenriPotier
//
//  Created by Aurélien Haie on 17/01/2021.
//

import UIKit

class MainTabBarController: UITabBarController {

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    // MARK: Custom funcs

    private func setupViews() {
        view.backgroundColor = UIColor(named: "backgroundColor")

        let libraryController = LibraryViewController()
        libraryController.tabBarItem = UITabBarItem(title: "Librairie", image: UIImage(systemName: "book.closed"), selectedImage: UIImage(systemName: "book.closed.fill"))
        let cartViewController = CartViewController()
        cartViewController.tabBarItem = UITabBarItem(title: "Panier", image: UIImage(systemName: "cart"), selectedImage: UIImage(systemName: "cart.fill"))
        viewControllers = [libraryController, cartViewController]

        tabBar.barTintColor = UIColor(named: "backgroundColor")
        tabBar.tintColor = .hpGreen
    }

}
