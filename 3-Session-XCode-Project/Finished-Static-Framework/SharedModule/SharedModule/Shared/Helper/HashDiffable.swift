//
//  HashDiffable.swift
//  TPWorkshopUnitTest
//
//  Created by digital.aurum on 24/11/21.
//

import Foundation

public protocol HashDiffable {
    var identifier: Int { get }
    func isEqual(to other: Any) -> Bool
}

extension HashDiffable where Self: Equatable {
    public func isEqual(to other: Any) -> Bool {
        guard let other = other as? Self else {
            return false
        }
        
        return self == other
    }
}
