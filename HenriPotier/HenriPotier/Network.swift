//
//  Network.swift
//  HenriPotier
//
//  Created by Aurélien Haie on 17/01/2021.
//

import Foundation

class Network: NSObject {

    static func fetchBooks(success: @escaping ([Book]) -> Void, failure: @escaping () -> Void) {
        let urlString = "https://henri-potier.techx.fr/books"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("Error fetching books:", err)
                failure()
                return
            }
            print("Succeeded fetching books")
            guard let data = data else { return }

            do {
                let books = try JSONDecoder().decode([Book].self, from: data)
                success(books)
            } catch {
                print(error)
                failure()
            }
        }.resume()
    }

}
