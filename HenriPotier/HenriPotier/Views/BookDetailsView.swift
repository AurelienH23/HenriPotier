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
            let attributedText = NSMutableAttributedString(attributedString: NSAttributedString(string: "Total : ", attributes: [.font: UIFont.systemFont(ofSize: 14)]))
            attributedText.append(NSAttributedString(string: "\(book.price * (book.quantity ?? 0))€", attributes: [.font: UIFont.boldSystemFont(ofSize: 14), .foregroundColor: UIColor.hpGreen]))
            costLabel.attributedText = attributedText
        }
    }

    // MARK: View elements

    lazy var cover = UIImageView(image: Network.cacheImages[book.cover])
    lazy var titleLabel = TitleLabel(book.title)
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "Prix : \(book.price)€"
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    lazy var quantityLabel: UILabel = {
        let label = UILabel()
        label.text = "Qté : \(book.quantity ?? 0)"
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    lazy var costLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(attributedString: NSAttributedString(string: "Total : ", attributes: [.font: UIFont.systemFont(ofSize: 14)]))
        attributedText.append(NSAttributedString(string: "\(book.price * (book.quantity ?? 0))€", attributes: [.font: UIFont.boldSystemFont(ofSize: 14), .foregroundColor: UIColor.hpGreen]))
        label.attributedText = attributedText
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

}
