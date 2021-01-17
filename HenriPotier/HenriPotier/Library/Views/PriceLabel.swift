//
//  PriceLabel.swift
//  HenriPotier
//
//  Created by Aurélien Haie on 17/01/2021.
//

import UIKit

class PriceLabel: UILabel {
    
    // MARK: Properties
    
    // MARK: View elements
    
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
        textColor = .white
        textAlignment = .center
        backgroundColor = .hpGreen
        layer.cornerRadius = .largeCornerRadius
        clipsToBounds = true
        font = UIFont.boldSystemFont(ofSize: 16)
    }

}
