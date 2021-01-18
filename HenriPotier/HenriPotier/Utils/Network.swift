//
//  Network.swift
//  HenriPotier
//
//  Created by Aurélien Haie on 17/01/2021.
//

import UIKit
import CoreData

class Network: NSObject {

    // MARK: Online data

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

    static func fetchOffer(for books: [Book], success: @escaping (Offers) -> Void, failure: @escaping () -> Void) {
        let chain = books.reduce("", {$0 + $1.isbn + ","})
        let urlString = "https://henri-potier.techx.fr/books/\(chain.dropLast())/commercialOffers"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("Error fetching offer:", err)
                failure()
                return
            }
            print("Succeeded fetching offer")
            guard let data = data else { return }
            
            do {
                let offers = try JSONDecoder().decode(Offers.self, from: data)
                success(offers)
            } catch {
                print(error)
                failure()
            }
        }.resume()
    }

    // MARK: Local data

    static func prepareLocalData(with books: [Book]) {
        if !UserDefaults.standard.bool(forKey: "isDataPrepared") {
            DispatchQueue.main.async {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                let entity = NSEntityDescription.entity(forEntityName: "CDBook", in: context)

                books.forEach { (book) in
                    // Save new book
                    let newData = NSManagedObject(entity: entity!, insertInto: context)
                    newData.setValue(book.isbn, forKey: "isbn")
                    newData.setValue(book.title, forKey: "title")
                    newData.setValue(book.cover, forKey: "cover")
                    newData.setValue(book.price, forKey: "price")
                    newData.setValue(0, forKey: "quantity")

                    do {
                        try context.save()
                    } catch {
                        print("Failed saving image locally")
                    }
                }
                
                UserDefaults.standard.setValue(true, forKey: "isDataPrepared")
            }
        }
    }

    static func updateLocalCart(for book: Book, number: Int) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDBook")
        let predicate = NSPredicate(format: "isbn = %@", book.isbn)
        fetchRequest.predicate = predicate
        
        do {
            let localBook = try context.fetch(fetchRequest) as! [CDBook]
            localBook.first?.setValue(number, forKey: "quantity")
            try context.save()
        } catch {
            print("Error while getting local data")
        }
    }

    static func getLocalCart() -> [Book] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDBook")

        do {
            let localBook = try context.fetch(fetchRequest) as! [CDBook]

            var booksData = [Book]()
            localBook.forEach { (aBook) in
                if let isbn = aBook.value(forKey: "isbn") as? String,
                   let title = aBook.value(forKey: "title") as? String,
                   let price = aBook.value(forKey: "price") as? Int,
                   let cover = aBook.value(forKey: "cover") as? String,
                   let quantity = aBook.value(forKey: "quantity") as? Int {
                    let bookData = Book(isbn: isbn, title: title, price: price, cover: cover, synopsis: [""], quantity: quantity)
                    booksData.append(bookData)
                }
            }
            return booksData
        } catch {
            print("Error while getting local data")
            return []
        }
    }

    static func getNumberOfItemsInCart(for book: Book) -> Int {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDBook")
        let predicate = NSPredicate(format: "isbn = %@", book.isbn)
        fetchRequest.predicate = predicate

        do {
            let localBook = try context.fetch(fetchRequest) as! [CDBook]
            guard let quantity = localBook.first?.quantity else {
                return 0
            }
            return Int(quantity)
        } catch {
            print("Error while getting local data")
            return 0
        }
    }

}
