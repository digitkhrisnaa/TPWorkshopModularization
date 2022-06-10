//
//  UIImageView+Extension.swift
//  TPWorkshopUnitTest
//
//  Created by digital.aurum on 24/11/21.
//

import Foundation
import UIKit

extension UIImageView {
    public func load(url : URL?) {
        guard let url = url else {
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
