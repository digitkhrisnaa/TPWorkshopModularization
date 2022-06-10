//
//  PracticeViewController.swift
//  TPWorkshopUnitTest
//
//  Created by digital.aurum on 19/11/21.
//

import UIKit
import SharedModule

public class CatalogPageViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let viewModel: CatalogPageViewModel
    
    public init() {
        self.viewModel = CatalogPageViewModel(useCase: CatalogPageUseCase())
        let url = Bundle.main.url(forResource: "CatalogPageModuleResourceBundle", withExtension: "bundle")
        let bundle = Bundle(url: url!)
        
        super.init(nibName: "CatalogPageViewController", bundle: bundle)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Catalog Page"
        
        let url = Bundle.main.url(forResource: "SharedModuleResourceBundle", withExtension: "bundle")
        let bundle = Bundle(url: url!)
        
        collectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: bundle), forCellWithReuseIdentifier: "ProductCollectionViewCell")
        collectionView.register(UINib(nibName: "InspirationCollectionViewCell", bundle: bundle), forCellWithReuseIdentifier: "InspirationCollectionViewCell")
        
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
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.data.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
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
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch viewModel.data[indexPath.row] {
        case let data as Product:
            Router.route?(.productDetailPage(product: data))
        default:
            fatalError("can't read the data")
        }
    }
}
