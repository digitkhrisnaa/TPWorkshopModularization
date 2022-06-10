//
//  ProductCardViewerViewController.swift
//  SharedModuleApp
//
//  Created by digital.aurum on 10/06/22.
//

import UIKit
import SharedModule

class ProductCardViewerViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = Bundle.main.url(forResource: "SharedModuleResourceBundle", withExtension: "bundle")
        let bundle = Bundle(url: url!)
        
        collectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: bundle), forCellWithReuseIdentifier: "ProductCollectionViewCell")
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension ProductCardViewerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
        
        let product = Product(id: 1,
                              name: "Awesome product",
                              imageURL: URL(string: "https://images.tokopedia.net/img/cache/200-square/VqbcmM/2021/11/2/d6dac822-9e50-4854-bf6b-222d3591f559.png"),
                              price: "Rp 10",
                              shop: Shop(id: 1, name: "Awesome shop", location: "Indonesia"))
        cell.configure(product: product)
        
        return cell
    }
}

extension ProductCardViewerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 2) - 4, height: 300)
    }
}
