//
//  BookViewModelTests.swift
//  HenriPotierTests
//
//  Created by Aurélien Haie on 21/01/2021.
//

import XCTest
@testable import HenriPotier

class BookViewModelTests: XCTestCase {

    var viewModel = BookViewModel(for: Book(isbn: "id", title: "Book title", price: 35, cover: "", synopsis: ["synopsis"], quantity: nil))

    func testCoverImage() throws {
        let image = UIImage(named: "")
        Network.cacheImages["id"] = image
        XCTAssertEqual(image, viewModel.coverImage())
    }

    func testBookTitle() throws {
        XCTAssertEqual("Book title", viewModel.bookTitle())
    }

    func testBookSynopsis() throws {
        XCTAssertEqual("synopsis", viewModel.bookSynopsis())
    }

    func testBookPrice() throws {
        XCTAssertEqual("35€", viewModel.bookPrice())
    }

    func testSyncingQuantity() throws {
        viewModel.syncQuantityWithLocalData()
        XCTAssertEqual(0, viewModel.numberOfBooksInCart.value)
    }

    func testAddAndSubstractBook() throws {
        XCTAssertEqual(0, viewModel.numberOfBooksInCart.value)
        viewModel.substractBook()
        XCTAssertEqual(0, viewModel.numberOfBooksInCart.value)
        viewModel.addBook()
        viewModel.addBook()
        viewModel.substractBook()
        XCTAssertEqual(1, viewModel.numberOfBooksInCart.value)
    }

}
