//
//  Router.swift
//  SharedModule
//
//  Created by digital.aurum on 10/06/22.
//

import Foundation

public enum Destination {
    case productDetailPage(product: Product)
}

public class Router {
    public static var route: ((Destination) -> Void)?
}
