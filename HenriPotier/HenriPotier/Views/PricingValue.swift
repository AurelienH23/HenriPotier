//
//  PricingValue.swift
//  HenriPotier
//
//  Created by Aurélien Haie on 21/01/2021.
//

import UIKit

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
