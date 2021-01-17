//
//  BookViewController.swift
//  HenriPotier
//
//  Created by Aurélien Haie on 17/01/2021.
//

import UIKit

class BookViewController: UIViewController {

    // MARK: Properties

    let book: Book

    // MARK: View elements

    // MARK: Lifecycle

    init(for book: Book) {
        self.book = book
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: Custom funcs
    
    private func setupViews() {
        //
    }

}
