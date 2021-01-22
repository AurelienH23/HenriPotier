//
//  ValueButton.swift
//  HenriPotier
//
//  Created by Aurélien Haie on 17/01/2021.
//

import UIKit

class ValueButton: UIButton {

    // MARK: Lifecycle
    
    init(_ text: String, target: Any, action: Selector) {
        super.init(frame: .zero)
        setTitle(text, for: .normal)
        addTarget(target, action: action, for: .touchUpInside)
        addTarget(self, action: #selector(vibrateOnClick), for: .touchUpInside)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Custom funcs

    private func setupViews() {
        setTitleColor(UIColor.textColor, for: .normal)
        backgroundColor = UIColor.backgroundColor
        layer.cornerRadius = .largeCornerRadius
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGrayTheme.cgColor
        anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: .extraLargeSpace, height: .extraLargeSpace)
    }

    @objc private func vibrateOnClick() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }

}
