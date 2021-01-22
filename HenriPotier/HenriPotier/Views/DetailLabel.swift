//
//  DetailLabel.swift
//  HenriPotier
//
//  Created by Aurélien Haie on 22/01/2021.
//

import UIKit

class DetailLabel: UILabel {

    // MARK: Lifecycle

    init(_ text: String) {
        super.init(frame: .zero)
        self.text = text
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Custom funcs

    private func setupViews() {
        font = .systemFont(ofSize: 14)
    }

}
