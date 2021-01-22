//
//  BookViewModel.swift
//  HenriPotier
//
//  Created by Aurélien Haie on 19/01/2021.
//

import UIKit

class BookViewModel {

    // MARK: Properties

    private let book: Book
    internal var numberOfBooksInCart: Box<Int> = Box(0)

    // MARK: Lifecycle

    init(for book: Book) {
        self.book = book
        syncQuantityWithLocalData()
    }

    // MARK: Custom funcs

    internal func coverImage() -> UIImage? {
        return Network.cacheImages[book.cover]
    }

    internal func bookTitle() -> String {
        return book.title
    }

    internal func bookSynopsis() -> String? {
        return book.synopsis.first
    }

    internal func bookPrice() -> String {
        return "\(book.price)€"
    }

    internal func syncQuantityWithLocalData() {
        numberOfBooksInCart.value = Network.getNumberOfItemsInCart(for: book)
    }

    internal func substractBook() {
        if numberOfBooksInCart.value > 0 {
            numberOfBooksInCart.value -= 1
            Network.updateLocalCart(for: book, number: numberOfBooksInCart.value)
            NotificationCenter.default.post(name: .cartUpdated, object: nil)
        }
    }

    internal func addBook() {
        numberOfBooksInCart.value += 1
        Network.updateLocalCart(for: book, number: numberOfBooksInCart.value)
        NotificationCenter.default.post(name: .cartUpdated, object: nil)
    }

}
