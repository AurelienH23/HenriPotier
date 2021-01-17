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

    // MARK: View elements

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        fetchBooks(success: { books in
            // succeeded
            print(books)
        }, failure: {
            // failed
        })
    }

    // MARK: Custom funcs

    private func setupViews() {
        //
    }

    private func fetchBooks(success: @escaping ([Book]) -> Void, failure: @escaping () -> Void) {
        let urlString = "https://henri-potier.techx.fr/books"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("Error fetching books:", err)
                failure()
                return
            }

            guard let data = data else { return }
            
            do {
                let books = try JSONDecoder().decode([Book].self, from: data)
                success(books)
            } catch {
                print(error)
            }
        }.resume()
    }

}
