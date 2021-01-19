//
//  LibraryViewModel.swift
//  HenriPotier
//
//  Created by Aurélien Haie on 19/01/2021.
//

import UIKit

class LibraryViewModel {

    // MARK: Properties

    let cellId = "cellId"
    var books: Box<[Book]> = Box([])

    // MARK: Custom funcs

    internal func fetchBooks() {
        Network.fetchBooks { (books) in
            self.books.value = books
            Network.prepareLocalData(with: books)
        } failure: {
            print("bad")
        }
    }

    // MARK: Collection view

    internal func numberOfItems() -> Int {
        return books.value.count
    }

    internal func cellForItem(at indexPath: IndexPath, from collectionView: UICollectionView) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BookCell
        cell.book = books.value[indexPath.item]
        return cell
    }

    internal func cellSpacing() -> CGFloat {
        return .extraLargeSpace
    }

    internal func cellSize(from collectionView: UICollectionView) -> CGSize {
        return CGSize(width: collectionView.frame.width - 2 * .extraLargeSpace, height: 180)
    }

    internal func insets() -> UIEdgeInsets {
        return UIEdgeInsets(top: .topPadding + 56 + .extraLargeSpace, left: .extraLargeSpace, bottom: 0, right: .extraLargeSpace)
    }

}
