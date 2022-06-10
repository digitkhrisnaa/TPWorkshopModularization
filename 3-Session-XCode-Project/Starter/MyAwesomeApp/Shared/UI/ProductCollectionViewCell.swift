//
//  ProductCollectionViewCell.swift
//  TPWorkshopUnitTest
//
//  Created by digital.aurum on 19/11/21.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productShopLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(product: Product) {
        productImageView.load(url: product.imageURL)
        productNameLabel.text = product.name
        productPriceLabel.text = product.price
        productShopLabel.text = "\(product.shop.name) - \(product.shop.location)"
    }
}
