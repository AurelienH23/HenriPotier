//
//  LibraryViewController.swift
//  HenriPotier
//
//  Created by Aurélien Haie on 17/01/2021.
//

import UIKit

struct Book: Decodable {
    let isbn: String
    let title: String
    let price: Int
    let cover: String
    let synopsis: [String]
}

class LibraryViewController: UIViewController {

    // MARK: Properties

    let cellId = "cellId"

    // MARK: View elements

    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = UIColor(named: "backgroundColor")
        cv.dataSource = self
        cv.delegate = self
        cv.showsVerticalScrollIndicator = false
        cv.register(BookCell.self, forCellWithReuseIdentifier: cellId)
        return cv
    }()

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        fetchBooks()
    }

    // MARK: Custom funcs

    private func setupViews() {
        view.addSubview(collectionView)
        collectionView.anchor(to: view)
    }

    private func fetchBooks() {
        Network.fetchBooks { (books) in
            //
        } failure: {
            print("bad")
        }

    }

}

// MARK: Collection View
extension LibraryViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BookCell
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .extraLargeSpace
    }

}

extension LibraryViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 2 * .extraLargeSpace, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: .extraLargeSpace, left: .extraLargeSpace, bottom: 0, right: .extraLargeSpace)
    }

}


class BookCell: UICollectionViewCell {

    // MARK: View elements

    let cover: UIImageView = {
        let iv = UIImageView(image: nil)
        iv.backgroundColor = .hpLightGray
        return iv
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Harry potter et le prisonnier d’Askaban"
        label.font = UIFont.bookTitle()
        label.numberOfLines = 0
        return label
    }()

    let overviewLabel: UILabel = {
        let label = UILabel()
        label.text = "Après la mort de ses parents (Lily et James Potier), Henri est recueilli par sa tante Pétunia (la sœur de Lily) et son oncle Vernon à l'âge d'un an. Ces derniers, animés depuis toujours d'une haine féroce envers les parents du toujours d'une haine féroce envers les parents du"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .hpGray
        label.numberOfLines = 0
        return label
    }()
    
    let hideView: UIView = {
        let view = UIView()
        let shadowLayer = CAGradientLayer()
        shadowLayer.frame = CGRect(x: 0, y: -40, width: UIScreen.main.bounds.width - 180, height: 40)
        shadowLayer.colors = [UIColor(white: 1, alpha: 0).cgColor, UIColor(white: 1, alpha: 1).cgColor]
        view.layer.addSublayer(shadowLayer)
        view.backgroundColor = .white
        return view
    }()

    let priceView: UILabel = {
        let label = UILabel()
        label.text = "35€"
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .hpGreen
        label.layer.cornerRadius = .largeCornerRadius
        label.clipsToBounds = true
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()

    let divider: UIView = {
        let view = UIView()
        view.backgroundColor = .hpLightGray
        return view
    }()

    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Custom funcs

    private func setupViews() {
        addSubviews(cover, titleLabel, overviewLabel, hideView, priceView, divider)
        cover.anchor(top: topAnchor, left: leftAnchor, bottom: divider.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: .extraLargeSpace, paddingRight: 0, width: 100, height: 0)
        titleLabel.anchor(top: topAnchor, left: cover.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: .mediumSpace, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        overviewLabel.anchor(top: titleLabel.bottomAnchor, left: cover.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: .smallSpace, paddingLeft: .mediumSpace, paddingBottom: 0, paddingRight: .mediumSpace, width: 0, height: 0)
        hideView.anchor(top: nil, left: overviewLabel.leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        priceView.anchor(top: nil, left: cover.rightAnchor, bottom: cover.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: .mediumSpace, paddingBottom: 0, paddingRight: 0, width: 2 * .extraLargeSpace, height: .extraLargeSpace)
        divider.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 1)
    }

}
