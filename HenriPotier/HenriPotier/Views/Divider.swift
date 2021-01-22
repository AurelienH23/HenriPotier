//
//  Divider.swift
//  HenriPotier
//
//  Created by Aurélien Haie on 17/01/2021.
//

import UIKit

class Divider: UIView {

    // MARK: Lifecycle

    init(color: UIColor = .lightGrayTheme) {
        super.init(frame: .zero)
        backgroundColor = color
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
