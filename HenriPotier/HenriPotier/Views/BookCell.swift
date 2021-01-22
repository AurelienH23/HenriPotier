//
//  BookCell.swift
//  HenriPotier
//
//  Created by Aurélien Haie on 17/01/2021.
//

import UIKit

class BookCell: UICollectionViewCell {

    // MARK: Properties

    internal var book: Book? {
        didSet {
            guard let book = book else { return }
            titleLabel.text = book.title
            overviewLabel.text = book.synopsis.first
            priceLabel.text = "\(book.price)€"
            syncQuantityWithLocalData()
            cover.fetchCoverImage(for: book)
        }
    }

    private var numberOfBooksInCart = 0 {
        didSet {
            valueLabel.text = "\(numberOfBooksInCart)"
        }
    }

    // MARK: View elements

    private let cover: UIImageView = {
        let iv = UIImageView(image: nil)
        iv.backgroundColor = .hpLightGray
        return iv
    }()

    private let titleLabel = TitleLabel("")

    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .hpGray
        label.numberOfLines = 0
        return label
    }()
    
    private let hideView: UIView = {
        let view = UIView()
        let shadowLayer = CAGradientLayer()
        shadowLayer.frame = CGRect(x: 0, y: -40, width: UIScreen.main.bounds.width - 180, height: 40)
        shadowLayer.colors = [UIColor(named: "backgroundClear")!.cgColor, UIColor.backgroundColor!.cgColor]
        view.layer.addSublayer(shadowLayer)
        view.backgroundColor = UIColor.backgroundColor
        return view
    }()

    private let priceLabel = PriceLabel("")

    private lazy var minusButton = ValueButton("-", target: self, action: #selector(didHitButton(button:)))
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = UIColor.textColor
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    private lazy var addButton = ValueButton("+", target: self, action: #selector(didHitButton(button:)))

    private let infoButton: UILabel = {
        let btn = UILabel()
        btn.text = "?"
        btn.textAlignment = .center
        btn.backgroundColor = UIColor.backgroundColor
        btn.layer.cornerRadius = .largeCornerRadius
        btn.clipsToBounds = true
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.lightGrayTheme.cgColor
        btn.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: .extraLargeSpace, height: .extraLargeSpace)
        return btn
    }()

    private let divider = Divider()

    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        overviewLabel.text = nil
        priceLabel.text = nil
        syncQuantityWithLocalData()
    }

    // MARK: Custom funcs

    private func setupViews() {
        addSubviews(cover, titleLabel, overviewLabel, hideView, priceLabel, minusButton, valueLabel, addButton, infoButton, divider)
        cover.anchor(top: topAnchor, left: leftAnchor, bottom: divider.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: .extraLargeSpace, paddingRight: 0, width: 100, height: 0)
        titleLabel.anchor(top: topAnchor, left: cover.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: .mediumSpace, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        overviewLabel.anchor(top: titleLabel.bottomAnchor, left: cover.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: .mediumSpace, paddingBottom: 0, paddingRight: .mediumSpace, width: 0, height: 0)
        hideView.anchor(top: nil, left: overviewLabel.leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 60)
        priceLabel.anchor(top: nil, left: cover.rightAnchor, bottom: cover.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: .mediumSpace, paddingBottom: 0, paddingRight: 0, width: 50, height: .extraLargeSpace)
        minusButton.anchor(top: priceLabel.topAnchor, left: priceLabel.rightAnchor, bottom: priceLabel.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: .smallSpace, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        valueLabel.anchor(top: minusButton.topAnchor, left: minusButton.rightAnchor, bottom: minusButton.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: .extraLargeSpace, height: 0)
        addButton.anchor(top: valueLabel.topAnchor, left: valueLabel.rightAnchor, bottom: valueLabel.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        infoButton.anchor(top: addButton.topAnchor, left: nil, bottom: addButton.bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        divider.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 1)
    }

    @objc private func didHitButton(button: ValueButton) {
        switch button {
        case minusButton:
            if numberOfBooksInCart > 0 {
                numberOfBooksInCart -= 1
                guard let book = book else { return }
                Network.updateLocalCart(for: book, number: numberOfBooksInCart)
            }
        case addButton:
            numberOfBooksInCart += 1
            guard let book = book else { return }
            Network.updateLocalCart(for: book, number: numberOfBooksInCart)
        default:
            break
        }
    }

    private func syncQuantityWithLocalData() {
        guard let book = book else { return }
        numberOfBooksInCart = Network.getNumberOfItemsInCart(for: book)
    }

}
