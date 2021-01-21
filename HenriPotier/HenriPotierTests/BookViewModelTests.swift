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
