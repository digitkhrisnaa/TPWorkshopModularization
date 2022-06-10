//
//  ProductData.swift
//  TPWorkshopUnitTest
//
//  Created by digital.aurum on 19/11/21.
//

import Foundation

struct ProductResult: Decodable {
    let data: [Product]
}

struct Product {
    let id: Int
    let name: String
    let imageURL: URL?
    let price: String
    let shop: Shop
    
    init(id: Int, name: String, imageURL: URL?, price: String, shop: Shop) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
        self.price = price
        self.shop = shop
    }
}

extension Product: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        let url = try container.decode(String.self, forKey: .imageURL)
        imageURL = URL(string: url)
        price = try container.decode(String.self, forKey: .price)
        shop = try container.decode(Shop.self, forKey: .shop)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, price, shop, imageURL = "image_uri"
    }
}

extension Product: Equatable {
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.imageURL == rhs.imageURL &&
        lhs.price == rhs.price &&
        lhs.shop == rhs.shop
    }
}

extension Product: HashDiffable {
    var identifier: Int {
        return "product-\(id)".hashValue
    }
}

struct Shop: Decodable, Equatable {
    let id: Int
    let name: String
    let location: String
}

extension Shop: HashDiffable {    
    var identifier: Int {
        return "shop-\(id)".hashValue
    }
}
