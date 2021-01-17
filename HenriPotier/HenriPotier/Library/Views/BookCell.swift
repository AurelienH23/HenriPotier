//
//  BookCell.swift
//  HenriPotier
//
//  Created by Aurélien Haie on 17/01/2021.
//

import UIKit

class BookCell: UICollectionViewCell {

    // MARK: Properties

    var book: Book? {
        didSet {
            guard let book = book else { return }
            titleLabel.text = book.title
            overviewLabel.text = book.synopsis.first
            priceLabel.text = "\(book.price)€"
            Network.fetchImage(at: book.cover) { (img) in
                DispatchQueue.main.async {
                    self.cover.image = img
                }
            } failure: {
                print("no image found")
            }
        }
    }

    // MARK: View elements

    let cover: UIImageView = {
        let iv = UIImageView(image: nil)
        iv.backgroundColor = .hpLightGray
        return iv
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Harry potter et le prisonnier d’Askaban"
        label.font = UIFont.bookTitle()
        label.numberOfLines = 0
        return label
    }()

    let overviewLabel: UILabel = {
        let label = UILabel()
        label.text = "Après la mort de ses parents (Lily et James Potier), Henri est recueilli par sa tante Pétunia (la sœur de Lily) et son oncle Vernon à l'âge d'un an. Ces derniers, animés depuis toujours d'une haine féroce envers les parents du toujours d'une haine féroce envers les parents du"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .hpGray
        label.numberOfLines = 0
        return label
    }()
    
    let hideView: UIView = {
        let view = UIView()
        let shadowLayer = CAGradientLayer()
        shadowLayer.frame = CGRect(x: 0, y: -40, width: UIScreen.main.bounds.width - 180, height: 40)
        shadowLayer.colors = [UIColor(white: 1, alpha: 0).cgColor, UIColor(white: 1, alpha: 1).cgColor]
        view.layer.addSublayer(shadowLayer)
        view.backgroundColor = .white
        return view
    }()

    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "35€"
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .hpGreen
        label.layer.cornerRadius = .largeCornerRadius
        label.clipsToBounds = true
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()

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

    let infoButton = ValueButton("?")

    let divider: UIView = {
        let view = UIView()
        view.backgroundColor = .hpLightGray
        return view
    }()

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
    }

    // MARK: Custom funcs

    private func setupViews() {
        addSubviews(cover, titleLabel, overviewLabel, hideView, priceLabel, minusButton, valueLabel, addButton, infoButton, divider)
        cover.anchor(top: topAnchor, left: leftAnchor, bottom: divider.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: .extraLargeSpace, paddingRight: 0, width: 100, height: 0)
        titleLabel.anchor(top: topAnchor, left: cover.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: .mediumSpace, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        overviewLabel.anchor(top: titleLabel.bottomAnchor, left: cover.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: .smallSpace, paddingLeft: .mediumSpace, paddingBottom: 0, paddingRight: .mediumSpace, width: 0, height: 0)
        hideView.anchor(top: nil, left: overviewLabel.leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 60)
        priceLabel.anchor(top: nil, left: cover.rightAnchor, bottom: cover.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: .mediumSpace, paddingBottom: 0, paddingRight: 0, width: 2 * .extraLargeSpace, height: .extraLargeSpace)
        minusButton.anchor(top: priceLabel.topAnchor, left: priceLabel.rightAnchor, bottom: priceLabel.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: .mediumSpace, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        valueLabel.anchor(top: minusButton.topAnchor, left: minusButton.rightAnchor, bottom: minusButton.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: .extraLargeSpace, height: 0)
        addButton.anchor(top: valueLabel.topAnchor, left: valueLabel.rightAnchor, bottom: valueLabel.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        infoButton.anchor(top: addButton.topAnchor, left: nil, bottom: addButton.bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        divider.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 1)
    }

}
