//
//  ProductCollectionViewCell.swift
//  TPWorkshopUnitTest
//
//  Created by digital.aurum on 19/11/21.
//

import UIKit

public class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productShopLabel: UILabel!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(product: Product) {
        productImageView.load(url: product.imageURL)
        productNameLabel.text = product.name
        productPriceLabel.text = product.price
        productShopLabel.text = "\(product.shop.name) - \(product.shop.location)"
    }
}
