//
//  PriceView.swift
//  HenriPotier
//
//  Created by Aurélien Haie on 18/01/2021.
//

import UIKit

class PriceView: UIView {

    // MARK: Properties

    // MARK: View elements

    let costLabel = PricingLabel("Coût total de la commande :")
    let dots1 = PricingLabel("....................................")
    let costValue = PricingValue("30€")
    let offerLabel = PricingLabel("Offre commerciale :")
    let dots2 = PricingLabel("....................................")
    let offerValue = PricingValue("-30€")
    let divider: UIView = {
        let view = UIView()
        view.backgroundColor = .hpGreen
        return view
    }()
    let wand: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "wand.and.stars"))
        iv.tintColor = .hpGreen
        return iv
    }()
    let totalLabel = PricingLabel("Total à payer :")
    let dots3 = PricingLabel("....................................")
    let totalValue = PricingValue("0€")

    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Custom funcs

    private func setupViews() {
        backgroundColor = .hpGreenBg
        layer.borderWidth = 1
        layer.borderColor = UIColor.hpGreen.cgColor
        addSubviews(costLabel, dots1, costValue, offerLabel, dots2, offerValue, divider, wand, totalLabel, dots3, totalValue)
        costLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: .mediumSpace, paddingLeft: .mediumSpace, paddingBottom: 0, paddingRight: .mediumSpace, width: 0, height: 0)
        dots1.anchor(top: costValue.topAnchor, left: leftAnchor, bottom: costValue.bottomAnchor, right: costValue.leftAnchor, paddingTop: 0, paddingLeft: .mediumSpace, paddingBottom: .smallSpace, paddingRight: .smallSpace, width: 0, height: 0)
        costValue.anchor(top: costLabel.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: .smallSpace, paddingLeft: 0, paddingBottom: 0, paddingRight: .mediumSpace, width: 0, height: 0)
        offerLabel.anchor(top: costValue.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: .smallSpace, paddingLeft: .mediumSpace, paddingBottom: 0, paddingRight: .mediumSpace, width: 0, height: 0)
        dots2.anchor(top: offerValue.topAnchor, left: leftAnchor, bottom: offerValue.bottomAnchor, right: offerValue.leftAnchor, paddingTop: 0, paddingLeft: .mediumSpace, paddingBottom: .smallSpace, paddingRight: .smallSpace, width: 0, height: 0)
        offerValue.anchor(top: offerLabel.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: .smallSpace, paddingLeft: 0, paddingBottom: 0, paddingRight: .mediumSpace, width: 0, height: 0)
        divider.anchor(top: offerValue.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: .mediumSpace, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 1)
        wand.anchor(top: divider.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: .mediumSpace, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
        wand.centerHorizontally(to: self)
        totalLabel.anchor(top: wand.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: .smallSpace, paddingLeft: .mediumSpace, paddingBottom: 0, paddingRight: .mediumSpace, width: 0, height: 0)
        dots3.anchor(top: totalValue.topAnchor, left: leftAnchor, bottom: totalValue.bottomAnchor, right: totalValue.leftAnchor, paddingTop: 0, paddingLeft: .mediumSpace, paddingBottom: .smallSpace, paddingRight: .smallSpace, width: 0, height: 0)
        totalValue.anchor(top: totalLabel.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: .smallSpace, paddingLeft: 0, paddingBottom: 0, paddingRight: .mediumSpace, width: 0, height: 0)
    }

}

class PricingLabel: UILabel {
    
    // MARK: Lifecycle
    
    init(_ text: String) {
        super.init(frame: .zero)
        self.text = text
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Custom funcs

    private func setupViews() {
        textColor = .hpGreen
        font = .systemFont(ofSize: 16)
        numberOfLines = 0
    }

}

class PricingValue: UILabel {
    
    // MARK: Lifecycle
    
    init(_ text: String) {
        super.init(frame: .zero)
        self.text = text
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Custom funcs

    private func setupViews() {
        textColor = .hpGreen
        textAlignment = .right
        font = .boldSystemFont(ofSize: 16)
        numberOfLines = 0
    }

}
