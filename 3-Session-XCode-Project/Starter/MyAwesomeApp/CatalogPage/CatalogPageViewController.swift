//
//  PracticeViewController.swift
//  TPWorkshopUnitTest
//
//  Created by digital.aurum on 19/11/21.
//

import UIKit

class CatalogPageViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let viewModel: CatalogPageViewModel
    
    init() {
        self.viewModel = CatalogPageViewModel(useCase: CatalogPageUseCase())
        super.init(nibName: "CatalogPageViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Catalog Page"
        
        collectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductCollectionViewCell")
        collectionView.register(UINib(nibName: "InspirationCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "InspirationCollectionViewCell")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        bindViewModel()
        viewModel.onDidLoad()
    }
    
    func bindViewModel() {
        viewModel.didReceiveData = { [weak self] in
            self?.collectionView.reloadData()
        }
        
        viewModel.didGotError = { messages in
            print(messages.joined(separator: ","))
        }
    }
}

extension CatalogPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.data[indexPath.row] {
        case let data as Product:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
            cell.configure(product: data)
            return cell
        case let data as Inspiration:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InspirationCollectionViewCell", for: indexPath) as! InspirationCollectionViewCell
            cell.configure(inspiration: data)
            return cell
        default:
            fatalError("can't read the data")
        }
    }
}

extension CatalogPageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch viewModel.data[indexPath.row] {
        case is Product:
            return CGSize(width: (collectionView.frame.width / 2) - 4, height: 300)
        case is Inspiration:
            return CGSize(width: collectionView.frame.width - 4, height: 250)
        default:
            fatalError("can't read the data")
        }
    }
}

extension CatalogPageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch viewModel.data[indexPath.row] {
        case let data as Product:
            let productDetailPage = ProductDetailPageViewController(product: data)
            UIApplication.topViewController()?.navigationController?.pushViewController(productDetailPage, animated: true)
        default:
            fatalError("can't read the data")
        }
    }
}
