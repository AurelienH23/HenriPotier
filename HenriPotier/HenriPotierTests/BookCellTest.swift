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
        XCTAssertNotNil(cell.book)
    }

}
