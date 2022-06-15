//
//  InspirationData.swift
//  TPWorkshopUnitTest
//
//  Created by digital.aurum on 23/11/21.
//

import Foundation

public struct InspirationResult: Decodable, Equatable {
    public let data: [Inspiration]
}

public struct Inspiration: Decodable, Equatable {
    public let title: String
    public let position: Int
    public let products: [ProductInspiration]
}

extension Inspiration: HashDiffable {
    public var identifier: Int {
        return "inspiration-\(title)".hashValue
    }
}

public struct ProductInspiration: Equatable {
    public let id: Int
    public let price: Int
    public let imageURL: URL?
}

extension ProductInspiration: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        price = try container.decode(Int.self, forKey: .price)
        let url = try container.decode(String.self, forKey: .imageURL)
        imageURL = URL(string: url)
    }
    
    public enum CodingKeys: String, CodingKey {
        case id
        case price
        case imageURL = "image_url"
    }
}

extension ProductInspiration: HashDiffable {
    public var identifier: Int {
        return "productInspiration-\(id)".hashValue
    }
}
