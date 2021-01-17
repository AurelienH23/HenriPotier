//
//  Network.swift
//  HenriPotier
//
//  Created by Aurélien Haie on 17/01/2021.
//

import UIKit

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

    static var cacheImages = [String: UIImage]()

    static func fetchImage(at urlString: String, success: @escaping (UIImage?) -> Void, failure: @escaping () -> Void) {
        if let cachedImage = cacheImages[urlString] {
            success(cachedImage)
        } else {
            guard let url = URL(string: urlString) else { return }
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                if let err = err {
                    print("Error fetching book cover:", err)
                    failure()
                    return
                }
                print("Succeeded fetching book cover")
                guard let data = data else { return }
                cacheImages[urlString] = UIImage(data: data)
                success(UIImage(data: data))
            }.resume()
        }
    }

}
