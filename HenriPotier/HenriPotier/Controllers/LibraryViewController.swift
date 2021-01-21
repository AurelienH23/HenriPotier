//
//  LibraryViewController.swift
//  HenriPotier
//
//  Created by Aurélien Haie on 17/01/2021.
//

import UIKit

class LibraryViewController: UIViewController {

    // MARK: Properties

    var topHeight: NSLayoutConstraint?
    let viewModel = LibraryViewModel()

    // MARK: View elements

    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = UIColor(named: "backgroundColor")
        cv.dataSource = self
        cv.delegate = self
        cv.showsVerticalScrollIndicator = false
        cv.register(BookCell.self, forCellWithReuseIdentifier: viewModel.cellId)
        return cv
    }()

    let topView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "backgroundColor")
        let logo = UIImageView(image: UIImage(named: "logo"))
        view.addSubview(logo)
        logo.anchor(top: view.topAnchor, left: nil, bottom: view.bottomAnchor, right: nil, paddingTop: .topPadding + .smallSpace, paddingLeft: 0, paddingBottom: .smallSpace, paddingRight: 0, width: 0, height: 0)
        logo.widthAnchor.constraint(equalTo: logo.heightAnchor).isActive = true
        logo.centerHorizontally(to: view)
        logo.alpha = 0
        logo.transform = CGAffineTransform(translationX: 0, y: 10).scaledBy(x: 1.1, y: 1.1)
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            logo.alpha = 1
            logo.transform = .identity
        }, completion: nil)
        return view
    }()

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupObservers()
        setupViews()
        setupBinders()
        fetchBooks()
    }

    // MARK: Custom funcs

    private func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadAfterCartUpdated), name: .cartUpdated, object: nil)
    }

    private func setupViews() {
        view.addSubviews(collectionView, topView)
        collectionView.anchor(to: view)
        topView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        topHeight = topView.heightAnchor.constraint(equalToConstant: .topPadding + 100)
        topHeight?.isActive = true
    }

    private func setupBinders() {
        viewModel.books.bind { _ in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    private func fetchBooks() {
        viewModel.fetchBooks()
    }

    @objc private func reloadAfterCartUpdated() {
        collectionView.reloadData()
    }

}

// MARK: Collection View
extension LibraryViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return viewModel.cellForItem(at: indexPath, from: collectionView)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.cellSpacing()
    }

}

extension LibraryViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedBook = viewModel.books.value[indexPath.item]
        let bookController = BookViewController(for: selectedBook)
        present(bookController, animated: true, completion: nil)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.cellSize(from: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return viewModel.insets()
    }

}

extension LibraryViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let verticalScroll = scrollView.contentOffset.y + 44
        topHeight?.constant = .topPadding + 100 - min(verticalScroll, 56)
    }

}
