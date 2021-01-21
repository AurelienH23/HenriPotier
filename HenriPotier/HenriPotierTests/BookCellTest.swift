//
//  BookCellTest.swift
//  HenriPotierTests
//
//  Created by Aurélien Haie on 20/01/2021.
//

import XCTest
@testable import HenriPotier

class BookCellTest: XCTestCase {

    let bookSample = Book(isbn: "id", title: "Book title", price: 10, cover: "", synopsis: ["synopsis"], quantity: nil)

    func testBookCellValues() throws {
        let cell = BookCell()
        cell.book = bookSample
        XCTAssertEqual("synopsis", cell.overviewLabel.text)
        XCTAssertEqual("10€", cell.priceLabel.text)
        XCTAssertEqual("Book title", cell.titleLabel.text)
        XCTAssertEqual("0", cell.valueLabel.text)
    }

    func testNumberOfBooksInCart() throws {
        let cell = BookCell()
        cell.numberOfBooksInCart = 3
        XCTAssertEqual("3", cell.valueLabel.text)
    }

}
