//
//  InspirationData.swift
//  TPWorkshopUnitTest
//
//  Created by digital.aurum on 23/11/21.
//

import Foundation

struct InspirationResult: Decodable, Equatable {
    let data: [Inspiration]
}

struct Inspiration: Decodable, Equatable {
    let title: String
    let position: Int
    let products: [ProductInspiration]
}

extension Inspiration: HashDiffable {
    var identifier: Int {
        return "inspiration-\(title)".hashValue
    }
}

struct ProductInspiration: Equatable {
    let id: Int
    let price: Int
    let imageURL: URL?
}

extension ProductInspiration: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        price = try container.decode(Int.self, forKey: .price)
        let url = try container.decode(String.self, forKey: .imageURL)
        imageURL = URL(string: url)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case price
        case imageURL = "image_url"
    }
}

extension ProductInspiration: HashDiffable {
    var identifier: Int {
        return "productInspiration-\(id)".hashValue
    }
}
