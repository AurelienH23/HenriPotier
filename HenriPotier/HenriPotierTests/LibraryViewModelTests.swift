//
//  LibraryViewModelTests.swift
//  HenriPotierTests
//
//  Created by Aurélien Haie on 21/01/2021.
//

import XCTest
@testable import HenriPotier

class LibraryViewModelTests: XCTestCase {

    var viewModel = LibraryViewModel()
    let firstBook = Book(isbn: "id1", title: "Book 1", price: 10, cover: "", synopsis: ["synopsis 1"], quantity: nil)
    let secondBook = Book(isbn: "id2", title: "Book 2", price: 30, cover: "", synopsis: ["synopsis 2"], quantity: nil)
    let thirdBook = Book(isbn: "id3", title: "Book 3", price: 20, cover: "", synopsis: ["synopsis 3"], quantity: nil)

    override func setUpWithError() throws {
        viewModel.books.value = [firstBook, secondBook, thirdBook]
    }

    func testNumberOfItems() throws {
        XCTAssertEqual(3, viewModel.numberOfItems())
    }

    func testCells() throws {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.register(BookCell.self, forCellWithReuseIdentifier: "cellId")
        XCTAssertNotNil(viewModel.cellForItem(at: IndexPath(item: 0, section: 0), from: collectionView))
        XCTAssertNotNil(viewModel.cellForItem(at: IndexPath(item: 1, section: 0), from: collectionView))
        XCTAssertNotNil(viewModel.cellForItem(at: IndexPath(item: 2, section: 0), from: collectionView))
    }
    
    func testCellSpacing() throws {
        XCTAssertEqual(32.0, viewModel.cellSpacing())
    }

    func testCellSize() throws {
        let frame = CGRect(x: 0, y: 0, width: 300, height: 120)
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: UICollectionViewLayout())
        XCTAssertEqual(CGSize(width: 236, height: 180), viewModel.cellSize(from: collectionView))
    }

    func testInsets() throws {
        XCTAssertEqual(UIEdgeInsets(top: 108, left: 32, bottom: 0, right: 32), viewModel.insets())
    }

}
