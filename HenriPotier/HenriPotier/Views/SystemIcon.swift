//
//  SystemIcon.swift
//  HenriPotier
//
//  Created by Aurélien Haie on 21/01/2021.
//

import UIKit

class SystemIcon: UIImageView {

    // MARK: Lifecycle

    init(named: String, color: UIColor) {
        super.init(image: UIImage(systemName: named)?.withRenderingMode(.alwaysTemplate))
        tintColor = color
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
