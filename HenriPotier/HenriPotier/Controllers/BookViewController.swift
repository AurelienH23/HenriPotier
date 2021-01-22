//
//  BookViewController.swift
//  HenriPotier
//
//  Created by Aurélien Haie on 17/01/2021.
//

import UIKit

class BookViewController: UIViewController {

    // MARK: Properties

    private let viewModel: BookViewModel

    // MARK: View elements

    private let dismissBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        return btn
    }()

    private lazy var blurredImage: UIImageView = {
        let iv = UIImageView(image: viewModel.coverImage())
        iv.contentMode = .scaleAspectFill
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        iv.addSubview(blurView)
        blurView.anchor(to: iv)
        iv.clipsToBounds = true
        return iv
    }()

    private lazy var cover = UIImageView(image: viewModel.coverImage())
    private lazy var titleLabel = TitleLabel(viewModel.bookTitle())
    private lazy var synopsis: UITextView = {
        let tv = UITextView()
        tv.text = viewModel.bookSynopsis()
        tv.font = .systemFont(ofSize: 16)
        tv.showsVerticalScrollIndicator = false
        tv.backgroundColor = UIColor.backgroundColor
        return tv
    }()

    private let divider = Divider()

    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.backgroundColor
        return view
    }()

    private lazy var priceLabel = PriceLabel(viewModel.bookPrice())
    private let minusButton = ValueButton("-", target: self, action: #selector(didHitButton(button:)))
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = UIColor.textColor
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    private let addButton = ValueButton("+", target: self, action: #selector(didHitButton(button:)))

    // MARK: Lifecycle

    init(for book: Book) {
        self.viewModel = BookViewModel(for: book)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupBinders()
    }
    
    // MARK: Custom funcs
    
    private func setupViews() {
        view.backgroundColor = UIColor.backgroundColor
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

    private func setupBinders() {
        viewModel.numberOfBooksInCart.bind { (booksCount) in
            self.valueLabel.text = "\(booksCount)"
        }
    }

    @objc private func didHitButton(button: ValueButton) {
        switch button {
        case minusButton:
            viewModel.substractBook()
        case addButton:
            viewModel.addBook()
        default:
            break
        }
    }

    @objc private func dismissView() {
        dismiss(animated: true, completion: nil)
    }

}
