//
//  ProductDetailPageViewController.swift
//  MyAwesomeApp
//
//  Created by digital.aurum on 10/06/22.
//

import UIKit

class ProductDetailPageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    
    let product: Product
    
    init(product: Product) {
        self.product = product
        super.init(nibName: "ProductDetailPageViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.load(url: product.imageURL)
        productNameLabel.text = product.name
        productPriceLabel.text = product.price
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
