//
//  PracticeViewModel.swift
//  TPWorkshopUnitTest
//
//  Created by digital.aurum on 23/11/21.
//

import Foundation

class CatalogPageViewModel {
    var data: [HashDiffable] = []
    let useCase: CatalogPageNetworkProvider
    
    init(useCase: CatalogPageNetworkProvider) {
        self.useCase = useCase
    }
    
    // MARK: Output
    var didReceiveData: (() -> Void)?
    var didGotError: (([String]) -> Void)?
    
    // MARK: Input
    func onDidLoad() {
        var productResult: ProductResult?
        var inspirationResult: InspirationResult?
        var errorMessage: [String] = []
        
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        useCase.fetchProduct { networkResult in
            switch networkResult {
            case let .success(product):
                productResult = product
            case let .failed(message):
                errorMessage.append(message)
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        useCase.fetchInspiration { networkResult in
            switch networkResult {
            case let .success(inspiration):
                inspirationResult = inspiration
            case let .failed(message):
                errorMessage.append(message)
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            if errorMessage.isEmpty || productResult != nil {
                self.processor(product: productResult, inspiration: inspirationResult)
            } else {
                self.didGotError?(errorMessage)
            }
        }
    }
    
    // MARK: Private methods
    private func processor(product: ProductResult?, inspiration: InspirationResult?) {
        guard let products = product?.data else {
            return
        }
        
        var mutableProducts: [HashDiffable] = products
        
        if let inspirationData = inspiration?.data {
            var counter = 0
            inspirationData.forEach { value in
                if value.position + counter > products.count {
                    return
                } else {
                    mutableProducts.insert(value, at: value.position + counter)
                    counter += 1
                }
            }
        }
        
        data = mutableProducts
        didReceiveData?()
    }
}
