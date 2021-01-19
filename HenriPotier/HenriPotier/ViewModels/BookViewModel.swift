//
//  BookViewModel.swift
//  HenriPotier
//
//  Created by Aurélien Haie on 19/01/2021.
//

import Foundation

class BookViewModel {

    // MARK: Properties

    let book: Book
    var numberOfBooksInCart: Box<Int> = Box(0)

    // MARK: Lifecycle

    init(for book: Book) {
        self.book = book
        syncQuantityWithLocalData()
    }

    // MARK: Custom funcs

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
