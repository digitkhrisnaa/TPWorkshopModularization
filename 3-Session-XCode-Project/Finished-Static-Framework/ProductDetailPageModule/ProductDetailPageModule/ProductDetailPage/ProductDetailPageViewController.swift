//
//  ProductDetailPageViewController.swift
//  MyAwesomeApp
//
//  Created by digital.aurum on 10/06/22.
//

import UIKit
import SharedModule

public class ProductDetailPageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    
    let product: Product
    
    public init(product: Product) {
        self.product = product
        let url = Bundle.main.url(forResource: "ProductDetailPageModuleResourceBundle", withExtension: "bundle")
        let bundle = Bundle(url: url!)
        super.init(nibName: "ProductDetailPageViewController", bundle: bundle)
    }
    
    public required init?(coder: NSCoder) {
        fatalError()
    }
    
    public override func viewDidLoad() {
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
