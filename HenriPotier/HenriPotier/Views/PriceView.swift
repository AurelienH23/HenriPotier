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
    }

}
