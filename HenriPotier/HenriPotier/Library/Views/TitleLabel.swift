//
//  TitleLabel.swift
//  HenriPotier
//
//  Created by Aurélien Haie on 17/01/2021.
//

import UIKit

class TitleLabel: UILabel {

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
        font = UIFont.bookTitle()
        numberOfLines = 0
    }

}
