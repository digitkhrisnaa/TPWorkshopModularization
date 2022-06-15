//
//  InspirationCollectionViewCell.swift
//  TPWorkshopUnitTest
//
//  Created by digital.aurum on 24/11/21.
//

import UIKit

public class InspirationCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var inspirationTitleLabel: UILabel!
    @IBOutlet weak var inspirationProductCollectionView: UICollectionView!
    
    private var inspiration: Inspiration?
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        inspirationProductCollectionView.dataSource = self
        inspirationProductCollectionView.delegate = self
        inspirationProductCollectionView.register(UINib(nibName: "InspirationItemCollectionViewCell", bundle: nil),
                                                  forCellWithReuseIdentifier: "InspirationItemCollectionViewCell")
    }

    public func configure(inspiration: Inspiration) {
        self.inspiration = inspiration
        inspirationTitleLabel.text = inspiration.title
        inspirationProductCollectionView.reloadData()
    }
}

extension InspirationCollectionViewCell: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return inspiration?.products.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let product = inspiration?.products[indexPath.row] else {
            fatalError()
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InspirationItemCollectionViewCell", for: indexPath) as! InspirationItemCollectionViewCell
        cell.configure(product: product)
        
        return cell
    }
}

extension InspirationCollectionViewCell: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 200)
    }
}
