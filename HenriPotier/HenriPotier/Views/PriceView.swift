//
//  PriceView.swift
//  HenriPotier
//
//  Created by Aurélien Haie on 18/01/2021.
//

import UIKit

class PriceView: UIView {

    // MARK: View elements

    private let costLabel = PricingLabel("Coût total de la commande :")
    private let dots1 = PricingLabel("....................................")
    private let costValue = PricingValue("-€")
    private let offerLabel = PricingLabel("Offre commerciale :")
    private let dots2 = PricingLabel("....................................")
    private let offerValue = PricingValue("-€")
    private let divider = Divider(color: .hpGreen)
    private let wand = SystemIcon(named: "wand.and.stars", color: .hpGreen)
    private let totalLabel = PricingLabel("Total à payer :")
    private let dots3 = PricingLabel("....................................")
    private let totalValue = PricingValue("-€")

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

    internal func setTotalPrice(for books: [Book]) {
        let cost = books.reduce(0, {$0 + $1.quantity! * $1.price})
        costValue.text = "\(cost)€"
        offerValue.text = "~"
        totalValue.text = "~"

        Network.fetchOffer(for: books) { (offers) in
            var lowestPrice = CGFloat(cost)
            var newPrice: CGFloat = 0
            var promotion = ""
            offers.offers.forEach { (offer) in
                switch offer.type {
                case "percentage":
                    newPrice = CGFloat(cost) - CGFloat(cost) * CGFloat(offer.value) / 100.0
                    if newPrice < lowestPrice {
                        lowestPrice = newPrice
                        promotion = "-\(offer.value)%"
                    }
                case "minus":
                    newPrice = CGFloat(cost) - CGFloat(offer.value)
                    if newPrice < lowestPrice {
                        lowestPrice = newPrice
                        promotion = "-\(offer.value)€"
                    }
                case "slice":
                    if let sliceValue = offer.sliceValue {
                        let minus = CGFloat(cost / sliceValue) * CGFloat(offer.value)
                        newPrice = CGFloat(cost) - minus
                        if newPrice < lowestPrice {
                            lowestPrice = newPrice
                            promotion = "-\(minus)€"
                        }
                    }
                default:
                    break
                }
            }

            DispatchQueue.main.async {
                self.offerValue.text = promotion
                self.totalValue.text = "\(lowestPrice)€"
            }
        } failure: {
            DispatchQueue.main.async {
                self.offerValue.text = "erreur"
                self.totalValue.text = "erreur"
            }
        }
    }

}
