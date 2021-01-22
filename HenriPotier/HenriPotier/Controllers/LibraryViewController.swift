//
//  LibraryViewController.swift
//  HenriPotier
//
//  Created by Aurélien Haie on 17/01/2021.
//

import UIKit

class LibraryViewController: UIViewController {

    // MARK: Properties

    private var topHeight: NSLayoutConstraint?
    private let viewModel = LibraryViewModel()

    // MARK: View elements

    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = UIColor.backgroundColor
        cv.dataSource = self
        cv.delegate = self
        cv.showsVerticalScrollIndicator = false
        viewModel.setupCells(for: cv)
        return cv
    }()

    private let topView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.backgroundColor
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

    private let noConnectionImage = SystemIcon(named: "book.closed", color: .black)
    private let errorImage = SystemIcon(named: "nosign", color: .red)

    private let noConnectionLabel: UILabel = {
        let label = UILabel()
        label.text = "Petit problème de connexion\nVérifiez votre connexion internet puis recommencez"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()

    private let startOverButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Appuyez pour relancer la recherche", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .hpGreen
        btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        btn.addTarget(self, action: #selector(refetchBooks), for: .touchUpInside)
        return btn
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
        viewModel.fetchBooks {
            print("Didn't manage to fetch the books")
            DispatchQueue.main.async {
                self.setupViewsForNoConnection()
            }
        }
    }

    @objc private func reloadAfterCartUpdated() {
        collectionView.reloadData()
    }

    private func setupViewsForNoConnection() {
        view.addSubviews(noConnectionImage, errorImage, noConnectionLabel, startOverButton)
        noConnectionImage.anchor(top: nil, left: nil, bottom: view.centerYAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: .extraLargeSpace, paddingRight: 0, width: 100, height: 100)
        noConnectionImage.centerHorizontally(to: view)
        errorImage.anchor(top: noConnectionImage.centerYAnchor, left: noConnectionImage.centerXAnchor, bottom: nil, right: nil, paddingTop: .mediumSpace, paddingLeft: .mediumSpace, paddingBottom: 0, paddingRight: 0, width: .standardTouchSpace, height: .standardTouchSpace)
        noConnectionLabel.anchor(top: noConnectionImage.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: .extraLargeSpace, paddingLeft: 50, paddingBottom: 0, paddingRight: 50, width: 0, height: 0)
        startOverButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: .bottomPadding + 63, paddingRight: 0, width: 0, height: 76)
    }

    @objc private func refetchBooks() {
        let noConnectionSubviews = [noConnectionImage, errorImage, noConnectionLabel, startOverButton]
        UIView.animate(withDuration: 0.3) {
            noConnectionSubviews.forEach { (subview) in
                subview.alpha = 0
            }
        } completion: { _ in
            noConnectionSubviews.forEach { (subview) in
                subview.removeConstraints(subview.constraints)
                subview.removeFromSuperview()
                subview.alpha = 1
            }
            self.fetchBooks()
        }
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
