//
//  BookViewController.swift
//  HenriPotier
//
//  Created by Aurélien Haie on 17/01/2021.
//

import UIKit

class BookViewController: UIViewController {

    // MARK: Properties

    let book: Book
    var numberOfBooksInCart = 0 {
        didSet {
            valueLabel.text = "\(numberOfBooksInCart)"
        }
    }

    // MARK: View elements

    let dismissBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        return btn
    }()

    lazy var blurredImage: UIImageView = {
        let iv = UIImageView(image: Network.cacheImages[book.cover])
        iv.contentMode = .scaleAspectFill
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        iv.addSubview(blurView)
        blurView.anchor(to: iv)
        iv.clipsToBounds = true
        return iv
    }()

    lazy var cover: UIImageView = {
        let iv = UIImageView(image: Network.cacheImages[book.cover])
        return iv
    }()
    
    lazy var titleLabel = TitleLabel(book.title)
    
    lazy var synopsis: UITextView = {
        let tv = UITextView()
        tv.text = book.synopsis.first
        tv.font = .systemFont(ofSize: 16)
        tv.showsVerticalScrollIndicator = false
        return tv
    }()

    let divider = Divider()

    let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "backgroundColor")
        return view
    }()

    lazy var priceLabel = PriceLabel("\(book.price)€")
    let minusButton = ValueButton("-")
    let valueLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = UIColor(named: "textColor")
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    let addButton = ValueButton("+")

    // MARK: Lifecycle

    init(for book: Book) {
        self.book = book
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupActions()
        syncQuantityWithLocalData()
    }
    
    // MARK: Custom funcs
    
    private func setupViews() {
        view.backgroundColor = UIColor(named: "backgroundColor")
        view.addSubviews(blurredImage, dismissBtn, cover, titleLabel, synopsis, divider, bottomView, priceLabel, minusButton, valueLabel, addButton)
        blurredImage.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 300)
        dismissBtn.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: .mediumSpace, paddingLeft: .mediumSpace, paddingBottom: 0, paddingRight: 0, width: .extraLargeSpace, height: .extraLargeSpace)
        cover.anchor(top: blurredImage.topAnchor, left: nil, bottom: blurredImage.bottomAnchor, right: nil, paddingTop: .mediumSpace, paddingLeft: 0, paddingBottom: .mediumSpace, paddingRight: 0, width: 0, height: 0)
        cover.centerHorizontally(to: blurredImage)
        cover.widthAnchor.constraint(equalTo: cover.heightAnchor, multiplier: 1/1.47).isActive = true
        titleLabel.anchor(top: blurredImage.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: .mediumSpace, paddingLeft: .extraLargeSpace, paddingBottom: 0, paddingRight: .extraLargeSpace, width: 0, height: 0)
        synopsis.anchor(top: titleLabel.bottomAnchor, left: titleLabel.leftAnchor, bottom: bottomView.topAnchor, right: titleLabel.rightAnchor, paddingTop: .smallSpace, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        divider.anchor(top: nil, left: bottomView.leftAnchor, bottom: bottomView.topAnchor, right: bottomView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 1)
        bottomView.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: .bottomPadding + 2 * .extraLargeSpace)
        priceLabel.anchor(top: bottomView.topAnchor, left: bottomView.leftAnchor, bottom: nil, right: nil, paddingTop: .mediumSpace, paddingLeft: .extraLargeSpace, paddingBottom: 0, paddingRight: 0, width: 50, height: .extraLargeSpace)
        addButton.anchor(top: bottomView.topAnchor, left: nil, bottom: nil, right: bottomView.rightAnchor, paddingTop: .mediumSpace, paddingLeft: 0, paddingBottom: 0, paddingRight: .extraLargeSpace, width: 0, height: 0)
        valueLabel.anchor(top: addButton.topAnchor, left: nil, bottom: addButton.bottomAnchor, right: addButton.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: .extraLargeSpace, height: 0)
        minusButton.anchor(top: valueLabel.topAnchor, left: nil, bottom: valueLabel.bottomAnchor, right: valueLabel.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }

    private func setupActions() {
        [minusButton, addButton].forEach { (btn) in
            btn.addTarget(self, action: #selector(didHitButton(button:)), for: .touchUpInside)
        }
    }

    private func syncQuantityWithLocalData() {
        numberOfBooksInCart = Network.getNumberOfItemsInCart(for: book)
    }

    @objc private func didHitButton(button: ValueButton) {
        switch button {
        case minusButton:
            if numberOfBooksInCart > 0 {
                numberOfBooksInCart -= 1
                Network.updateLocalCart(for: book, number: numberOfBooksInCart)
                NotificationCenter.default.post(name: .cartUpdated, object: nil)
            }
        case addButton:
            numberOfBooksInCart += 1
            Network.updateLocalCart(for: book, number: numberOfBooksInCart)
            NotificationCenter.default.post(name: .cartUpdated, object: nil)
        default:
            break
        }
    }

    @objc private func dismissView() {
        dismiss(animated: true, completion: nil)
    }

}
