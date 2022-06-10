//
//  InspirationItemCollectionViewCell.swift
//  TPWorkshopUnitTest
//
//  Created by digital.aurum on 24/11/21.
//

import UIKit

public class InspirationItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productPriceLabel: UILabel!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public func configure(product: ProductInspiration) {
        productImageView.load(url: product.imageURL)
        productPriceLabel.text = "\(product.price)"
    }
}
