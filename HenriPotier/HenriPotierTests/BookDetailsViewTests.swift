//
//  BookDetailsViewTests.swift
//  HenriPotierTests
//
//  Created by Aurélien Haie on 21/01/2021.
//

import XCTest
@testable import HenriPotier
// TODO: enlever
class BookDetailsViewTests: XCTestCase {

    let bookSample = Book(isbn: "id", title: "Book title", price: 10, cover: "", synopsis: ["synopsis"], quantity: 2)
    let noBookSample = Book(isbn: "id", title: "Book title", price: 10, cover: "", synopsis: ["synopsis"], quantity: 0)

    func testWithTwoBooksInCart() throws {
//        let detailsView = BookDetailsView(for: bookSample)
//        XCTAssertNotNil(detailsView.book.quantity)
//        XCTAssertEqual("Qté : 2", detailsView.quantityLabel.text)
//        XCTAssertEqual("Total : 20€", detailsView.costLabel.attributedText?.string)
    }

    func testWithNoBookInCart() throws {
        let detailsView = BookDetailsView(for: noBookSample)
//        XCTAssertEqual("Qté : 0", detailsView.quantityLabel.text)
//        XCTAssertEqual("Total : 0€", detailsView.costLabel.attributedText?.string)
    }

}
