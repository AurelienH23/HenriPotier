//
//  BookDetailsView.swift
//  HenriPotier
//
//  Created by Aurélien Haie on 18/01/2021.
//

import UIKit

class BookDetailsView: UIView {

    // MARK: Properties

    var book: Book {
        didSet {
            quantityLabel.text = "Qté : \(book.quantity ?? 0)"
            costLabel.attributedText = getTotalCost()
            cover.fetchCoverImage(for: book)
            if let qty = book.quantity {
                isHidden = qty == 0
            }
        }
    }

    // MARK: View elements

    private lazy var cover = UIImageView(image: Network.cacheImages[book.cover])
    private lazy var titleLabel = TitleLabel(book.title)
    private lazy var priceLabel = DetailLabel("Prix : \(book.price)€")
    private lazy var quantityLabel = DetailLabel("Qté : \(book.quantity ?? 0)")
    private lazy var costLabel: UILabel = {
        let label = UILabel()
        label.attributedText = getTotalCost()
        label.textAlignment = .right
        return label
    }()

    // MARK: Lifecycle

    init(for book: Book) {
        self.book = book
        super.init(frame: .zero)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Custom funcs

    private func setupViews() {
        anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 135)
        addSubviews(cover, titleLabel, priceLabel, quantityLabel, costLabel)
        cover.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 92, height: 0)
        titleLabel.anchor(top: topAnchor, left: cover.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: .mediumSpace, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        priceLabel.anchor(top: titleLabel.bottomAnchor, left: titleLabel.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        quantityLabel.anchor(top: priceLabel.bottomAnchor, left: titleLabel.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        costLabel.anchor(top: quantityLabel.bottomAnchor, left: titleLabel.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }

    private func getTotalCost() -> NSAttributedString {
        let attributedText = NSMutableAttributedString(attributedString: NSAttributedString(string: "Total : ", attributes: [.font: UIFont.systemFont(ofSize: 14)]))
        attributedText.append(NSAttributedString(string: "\(book.price * (book.quantity ?? 0))€", attributes: [.font: UIFont.boldSystemFont(ofSize: 14), .foregroundColor: UIColor.hpGreen]))
        return attributedText
    }

}
