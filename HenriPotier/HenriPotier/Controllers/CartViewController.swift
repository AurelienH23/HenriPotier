//
//  CartViewController.swift
//  HenriPotier
//
//  Created by Aurélien Haie on 17/01/2021.
//

import UIKit

class CartViewController: UIViewController {

    // MARK: View elements

    let bookImage: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "book.closed"))
        iv.tintColor = UIColor(named: "textColor")
        return iv
    }()
    let arrowImage: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "arrow.right"))
        iv.tintColor = .hpGreen
        return iv
    }()
    let cartImage: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "cart"))
        iv.tintColor = UIColor(named: "textColor")
        return iv
    }()
    let emptyLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(attributedString: NSAttributedString(string: "Votre panier est vide !\n", attributes: [.font: UIFont.boldSystemFont(ofSize: 20)]))
        attributedText.append(NSAttributedString(string: "Ajoutez des livres en parcourant la librairie", attributes: [.font: UIFont.systemFont(ofSize: 20)]))
        label.attributedText = attributedText
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(Network.getLocalCart())
    }

    // MARK: Custom funcs

    private func setupViews() {
        view.addSubviews(bookImage, arrowImage, cartImage, emptyLabel)
        arrowImage.anchor(top: nil, left: nil, bottom: view.centerYAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: .extraLargeSpace, paddingRight: 0, width: .standardTouchSpace, height: .standardTouchSpace)
        arrowImage.centerHorizontally(to: view)
        bookImage.anchor(top: nil, left: nil, bottom: nil, right: arrowImage.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: .smallSpace, width: 76, height: 76)
        bookImage.centerVertically(to: arrowImage)
        cartImage.anchor(top: nil, left: arrowImage.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: .smallSpace, paddingBottom: 0, paddingRight: 0, width: 76, height: 76)
        cartImage.centerVertically(to: arrowImage)
        emptyLabel.anchor(top: arrowImage.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: .extraLargeSpace, paddingLeft: 50, paddingBottom: 0, paddingRight: 50, width: 0, height: 0)
    }

}
