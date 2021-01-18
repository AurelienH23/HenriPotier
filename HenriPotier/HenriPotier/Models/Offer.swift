//
//  Offer.swift
//  HenriPotier
//
//  Created by Aurélien Haie on 18/01/2021.
//

import Foundation

struct Offer: Decodable {
    let type: String
    let value: Int
    let sliceValue: Int?
}

struct Offers: Decodable {
    let offers: [Offer]
}
