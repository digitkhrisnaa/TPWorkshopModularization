//
//  ProductData.swift
//  TPWorkshopUnitTest
//
//  Created by digital.aurum on 19/11/21.
//

import Foundation

public struct ProductResult: Decodable {
    public let data: [Product]
}

public struct Product {
    public let id: Int
    public let name: String
    public let imageURL: URL?
    public let price: String
    public let shop: Shop
    
    public init(id: Int, name: String, imageURL: URL?, price: String, shop: Shop) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
        self.price = price
        self.shop = shop
    }
}

extension Product: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        let url = try container.decode(String.self, forKey: .imageURL)
        imageURL = URL(string: url)
        price = try container.decode(String.self, forKey: .price)
        shop = try container.decode(Shop.self, forKey: .shop)
    }
    
    public enum CodingKeys: String, CodingKey {
        case id, name, price, shop, imageURL = "image_uri"
    }
}

extension Product: Equatable {
    public static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.imageURL == rhs.imageURL &&
        lhs.price == rhs.price &&
        lhs.shop == rhs.shop
    }
}

extension Product: HashDiffable {
    public var identifier: Int {
        return "product-\(id)".hashValue
    }
}

public struct Shop: Decodable, Equatable {
    public let id: Int
    public let name: String
    public let location: String
    
    public init(id: Int, name: String, location: String) {
        self.id = id
        self.name = name
        self.location = location
    }
}

extension Shop: HashDiffable {    
    public var identifier: Int {
        return "shop-\(id)".hashValue
    }
}
