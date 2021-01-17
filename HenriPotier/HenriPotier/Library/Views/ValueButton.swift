//
//  ValueButton.swift
//  HenriPotier
//
//  Created by Aurélien Haie on 17/01/2021.
//

import UIKit

class ValueButton: UIButton {

    // MARK: Lifecycle
    
    init(_ text: String) {
        super.init(frame: .zero)
        setTitle(text, for: .normal)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Custom funcs

    private func setupViews() {
        setTitleColor(UIColor(named: "textColor"), for: .normal)
        backgroundColor = UIColor(named: "backgroundColor")
        layer.cornerRadius = .largeCornerRadius
        layer.borderWidth = 1
        layer.borderColor = UIColor.hpLightGray.cgColor
        anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: .extraLargeSpace, height: .extraLargeSpace)
    }

}
