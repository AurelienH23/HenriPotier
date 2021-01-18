//
//  Book.swift
//  HenriPotier
//
//  Created by Aurélien Haie on 17/01/2021.
//

import Foundation

struct Book: Decodable {
    let isbn: String
    let title: String
    let price: Int
    let cover: String
    let synopsis: [String]
    let quantity: Int?
}
