//
//  NetworkResult.swift
//  TPWorkshopUnitTest
//
//  Created by digital.aurum on 24/11/21.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case failed(String)
}
