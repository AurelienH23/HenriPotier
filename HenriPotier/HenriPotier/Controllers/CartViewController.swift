//
//  CartViewController.swift
//  HenriPotier
//
//  Created by Aurélien Haie on 17/01/2021.
//

import UIKit

class CartViewController: UIViewController {

    // MARK: Properties

    var books = [Book]() {
        didSet {
            let detailsViews = [bookDetails1, bookDetails2, bookDetails3, bookDetails4, bookDetails5, bookDetails6, bookDetails7]
            var i = 0
            books.forEach { (book) in
                if let qty = book.quantity, qty > 0 {
                    detailsViews[i].isHidden = false
                } else {
                    detailsViews[i].isHidden = true
                }
                i += 1
            }
            if books.reduce(0, {$0 + $1.quantity!}) > 0 {
                setupViewsForBooksInCart()
            } else {
                setupViewsForEmptyCart()
            }
        }
    }

    // MARK: View elements

    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsVerticalScrollIndicator = false
        return sv
    }()

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

    let ticketView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.hpLightGray.cgColor
        return view
    }()

    let ticketLabel: UILabel = {
        let label = UILabel()
        label.text = "Ticket de caisse"
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()

    let companyName: UILabel = {
        let label = UILabel()
        label.text = "Henri Potier Inc."
        label.textColor = .hpGray
        label.textAlignment = .right
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()

    let logo = UIImageView(image: nil)

    let hDivider = Divider()
    let vDivider = Divider()

    lazy var bookDetails1 = BookDetailsView(for: books[0])
    lazy var bookDetails2 = BookDetailsView(for: books[1])
    lazy var bookDetails3 = BookDetailsView(for: books[2])
    lazy var bookDetails4 = BookDetailsView(for: books[3])
    lazy var bookDetails5 = BookDetailsView(for: books[4])
    lazy var bookDetails6 = BookDetailsView(for: books[5])
    lazy var bookDetails7 = BookDetailsView(for: books[6])

    let priceView = PriceView()

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        books = Network.getLocalCart()
    }

    // MARK: Custom funcs

    private func emptyMainView() {
        view = UIView()
    }

    private func setupViewsForEmptyCart() {
        emptyMainView()
        view.addSubviews(bookImage, arrowImage, cartImage, emptyLabel)
        arrowImage.anchor(top: nil, left: nil, bottom: view.centerYAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: .extraLargeSpace, paddingRight: 0, width: .standardTouchSpace, height: .standardTouchSpace)
        arrowImage.centerHorizontally(to: view)
        bookImage.anchor(top: nil, left: nil, bottom: nil, right: arrowImage.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: .smallSpace, width: 76, height: 76)
        bookImage.centerVertically(to: arrowImage)
        cartImage.anchor(top: nil, left: arrowImage.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: .smallSpace, paddingBottom: 0, paddingRight: 0, width: 76, height: 76)
        cartImage.centerVertically(to: arrowImage)
        emptyLabel.anchor(top: arrowImage.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: .extraLargeSpace, paddingLeft: 50, paddingBottom: 0, paddingRight: 50, width: 0, height: 0)
    }

    private func setupViewsForBooksInCart() {
        emptyMainView()

        let stack = UIStackView(arrangedSubviews: [bookDetails1, bookDetails2, bookDetails3, bookDetails4, bookDetails5, bookDetails6, bookDetails7])
        stack.distribution = .equalSpacing
        stack.spacing = .mediumSpace
        stack.axis = .vertical

        view.addSubview(scrollView)
        scrollView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: .topPadding, paddingLeft: 0, paddingBottom: .bottomPadding + 63, paddingRight: 0, width: 0, height: 0)
        scrollView.addSubviews(ticketView, ticketLabel, companyName, logo, vDivider, hDivider, stack, priceView)
        ticketView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: priceView.bottomAnchor, right: scrollView.rightAnchor, paddingTop: .extraLargeSpace, paddingLeft: .extraLargeSpace, paddingBottom: 0, paddingRight: .extraLargeSpace, width: view.frame.width - 2 * .extraLargeSpace, height: 0)
        ticketLabel.anchor(top: ticketView.topAnchor, left: ticketView.leftAnchor, bottom: nil, right: vDivider.leftAnchor, paddingTop: .mediumSpace, paddingLeft: .mediumSpace, paddingBottom: 0, paddingRight: .mediumSpace, width: 0, height: 0)
        companyName.anchor(top: nil, left: ticketView.leftAnchor, bottom: hDivider.topAnchor, right: vDivider.leftAnchor, paddingTop: 0, paddingLeft: .mediumSpace, paddingBottom: .smallSpace, paddingRight: .mediumSpace, width: 0, height: 0)
        logo.anchor(top: ticketView.topAnchor, left: nil, bottom: nil, right: ticketView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 76, height: 76)
        vDivider.anchor(top: ticketView.topAnchor, left: nil, bottom: hDivider.topAnchor, right: logo.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 1, height: 0)
        hDivider.anchor(top: logo.bottomAnchor, left: ticketView.leftAnchor, bottom: nil, right: ticketView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 1)
        stack.anchor(top: hDivider.bottomAnchor, left: ticketView.leftAnchor, bottom: nil, right: ticketView.rightAnchor, paddingTop: .mediumSpace, paddingLeft: .mediumSpace, paddingBottom: 0, paddingRight: .mediumSpace, width: 0, height: 0)
        priceView.anchor(top: stack.bottomAnchor, left: ticketView.leftAnchor, bottom: ticketView.bottomAnchor, right: ticketView.rightAnchor, paddingTop: .mediumSpace, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 200)

        view.layoutIfNeeded()
        scrollView.contentSize = CGSize(width: view.frame.width, height: ticketView.frame.height + 2 * .extraLargeSpace)
    }

}
