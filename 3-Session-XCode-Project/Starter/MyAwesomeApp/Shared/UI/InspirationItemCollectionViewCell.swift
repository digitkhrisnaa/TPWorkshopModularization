//
//  InspirationItemCollectionViewCell.swift
//  TPWorkshopUnitTest
//
//  Created by digital.aurum on 24/11/21.
//

import UIKit

class InspirationItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(product: ProductInspiration) {
        productImageView.load(url: product.imageURL)
        productPriceLabel.text = "\(product.price)"
    }
}
