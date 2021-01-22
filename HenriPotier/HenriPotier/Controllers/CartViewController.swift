//
//  CartViewController.swift
//  HenriPotier
//
//  Created by Aurélien Haie on 17/01/2021.
//

import UIKit

class CartViewController: UIViewController {

    // MARK: Properties

    private var books = [Book]() {
        didSet {
            showAddedBooks()
            if books.reduce(0, {$0 + $1.quantity!}) > 0 {
                setupViewsForBooksInCart()
                calculateTotalCost()
            } else {
                setupViewsForEmptyCart()
            }
        }
    }

    // MARK: View elements

    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsVerticalScrollIndicator = false
        sv.showsHorizontalScrollIndicator = false
        return sv
    }()

    private let bookImage = SystemIcon(named: "book.closed", color: UIColor.textColor ?? .black)
    private let arrowImage = SystemIcon(named: "arrow.right", color: .hpGreen)
    private let cartImage = SystemIcon(named: "cart", color: UIColor.textColor ?? .black)

    private let emptyLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(attributedString: NSAttributedString(string: "Votre panier est vide !\n", attributes: [.font: UIFont.boldSystemFont(ofSize: 20)]))
        attributedText.append(NSAttributedString(string: "Ajoutez des livres en parcourant la librairie", attributes: [.font: UIFont.systemFont(ofSize: 20)]))
        label.attributedText = attributedText
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private let ticketView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGrayTheme.cgColor
        return view
    }()

    private let ticketLabel: UILabel = {
        let label = UILabel()
        label.text = "Ticket de caisse"
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()

    private let companyName: UILabel = {
        let label = UILabel()
        label.text = "Henri Potier Inc."
        label.textColor = .hpGray
        label.textAlignment = .right
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()

    private let logo = UIImageView(image: UIImage(named: "logo"))

    private let hDivider = Divider()
    private let vDivider = Divider()

    private lazy var bookDetails1 = BookDetailsView(for: books[0])
    private lazy var bookDetails2 = BookDetailsView(for: books[1])
    private lazy var bookDetails3 = BookDetailsView(for: books[2])
    private lazy var bookDetails4 = BookDetailsView(for: books[3])
    private lazy var bookDetails5 = BookDetailsView(for: books[4])
    private lazy var bookDetails6 = BookDetailsView(for: books[5])
    private lazy var bookDetails7 = BookDetailsView(for: books[6])

    private let priceView = PriceView()

    private let payButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Régler", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .hpGreen
        btn.layer.cornerRadius = .standardTouchSpace / 2
        btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        btn.setImage(UIImage(systemName: "creditcard"), for: .normal)
        btn.tintColor = .white
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .smallSpace)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: .smallSpace, bottom: 0, right: 0)
        btn.addTarget(self, action: #selector(didHitPayButton), for: .touchUpInside)
        return btn
    }()

    // MARK: Lifecycle

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
        scrollView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: .topPadding, paddingLeft: 0, paddingBottom: .bottomPadding + .standardTouchSpace, paddingRight: 0, width: 0, height: 0)
        scrollView.addSubviews(ticketView, ticketLabel, companyName, logo, vDivider, hDivider, stack, priceView, payButton)
        ticketView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: priceView.bottomAnchor, right: scrollView.rightAnchor, paddingTop: .extraLargeSpace, paddingLeft: .extraLargeSpace, paddingBottom: 0, paddingRight: .extraLargeSpace, width: view.frame.width - 2 * .extraLargeSpace, height: 0)
        ticketLabel.anchor(top: ticketView.topAnchor, left: ticketView.leftAnchor, bottom: nil, right: vDivider.leftAnchor, paddingTop: .mediumSpace, paddingLeft: .mediumSpace, paddingBottom: 0, paddingRight: .mediumSpace, width: 0, height: 0)
        companyName.anchor(top: nil, left: ticketView.leftAnchor, bottom: hDivider.topAnchor, right: vDivider.leftAnchor, paddingTop: 0, paddingLeft: .mediumSpace, paddingBottom: .smallSpace, paddingRight: .mediumSpace, width: 0, height: 0)
        logo.anchor(top: ticketView.topAnchor, left: nil, bottom: nil, right: ticketView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 76, height: 76)
        vDivider.anchor(top: ticketView.topAnchor, left: nil, bottom: hDivider.topAnchor, right: logo.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 1, height: 0)
        hDivider.anchor(top: logo.bottomAnchor, left: ticketView.leftAnchor, bottom: nil, right: ticketView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 1)
        stack.anchor(top: hDivider.bottomAnchor, left: ticketView.leftAnchor, bottom: nil, right: ticketView.rightAnchor, paddingTop: .mediumSpace, paddingLeft: .mediumSpace, paddingBottom: 0, paddingRight: .mediumSpace, width: 0, height: 0)
        priceView.anchor(top: stack.bottomAnchor, left: ticketView.leftAnchor, bottom: ticketView.bottomAnchor, right: ticketView.rightAnchor, paddingTop: .mediumSpace, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 270)
        payButton.anchor(top: ticketView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: .extraLargeSpace, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 132, height: .standardTouchSpace)
        payButton.centerHorizontally(to: scrollView)

        view.layoutIfNeeded()
        scrollView.contentSize = CGSize(width: view.frame.width, height: ticketView.frame.height + 3 * .extraLargeSpace + .standardTouchSpace)
    }

    private func showAddedBooks() {
        let detailsViews = [bookDetails1, bookDetails2, bookDetails3, bookDetails4, bookDetails5, bookDetails6, bookDetails7]
        var i = 0
        books.forEach { (book) in
            detailsViews[i].book = book
            if let qty = book.quantity, qty > 0 {
                detailsViews[i].isHidden = false
            } else {
                detailsViews[i].isHidden = true
            }
            i += 1
        }
    }

    private func calculateTotalCost() {
        priceView.setTotalPrice(for: books)
    }

    @objc private func didHitPayButton() {
        scrollView.subviews.forEach { (subview) in
            UIView.animate(withDuration: 1) {
                if subview != self.payButton {
                    subview.transform = CGAffineTransform(translationX: 0, y: -self.ticketView.frame.height)
                }
                subview.alpha = 0
            } completion: { _ in
                subview.transform = .identity
                subview.alpha = 1
                Network.eraseCartFromLocalData {
                    self.books = Network.getLocalCart()
                    NotificationCenter.default.post(name: .cartUpdated, object: nil)
                }
            }
        }
    }

}
