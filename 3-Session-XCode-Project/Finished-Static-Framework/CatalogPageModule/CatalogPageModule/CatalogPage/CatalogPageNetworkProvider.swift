//
//  PracticeNetworkProvider.swift
//  TPWorkshopUnitTest
//
//  Created by digital.aurum on 23/11/21.
//

import Foundation
import SharedModule

protocol CatalogPageNetworkProvider {
    func fetchProduct(onComplete: @escaping (NetworkResult<ProductResult>) -> Void)
    func fetchInspiration(onComplete: @escaping (NetworkResult<InspirationResult>) -> Void)
}

struct CatalogPageUseCase: CatalogPageNetworkProvider {
    func fetchProduct(onComplete: @escaping (NetworkResult<ProductResult>) -> Void) {
        let url = Bundle.main.url(forResource: "SharedModuleResourceBundle", withExtension: "bundle")
        let bundle = Bundle(url: url!)
        
        guard let url = bundle?.path(forResource: "ProductData", ofType: "json") else {
            onComplete(.failed("URL Not found"))
            return
        }
        
        if let data = try? Data(contentsOf: URL(fileURLWithPath: url), options: .mappedIfSafe) {
            if let result = try? JSONDecoder().decode(ProductResult.self, from: data) {
                onComplete(.success(result))
            } else {
                onComplete(.failed("Failed when decoding"))
            }
        } else {
            onComplete(.failed("Failed converting to data"))
        }
    }
    
    func fetchInspiration(onComplete: @escaping (NetworkResult<InspirationResult>) -> Void) {
        let url = Bundle.main.url(forResource: "SharedModuleResourceBundle", withExtension: "bundle")
        let bundle = Bundle(url: url!)
        
        guard let url = bundle?.path(forResource: "InspirationData", ofType: "json") else {
            onComplete(.failed("URL Not found"))
            return
        }
        
        if let data = try? Data(contentsOf: URL(fileURLWithPath: url), options: .mappedIfSafe) {
            if let result = try? JSONDecoder().decode(InspirationResult.self, from: data) {
                onComplete(.success(result))
            } else {
                onComplete(.failed("Failed when decoding"))
            }
        } else {
            onComplete(.failed("Failed converting to data"))
        }
    }
}
