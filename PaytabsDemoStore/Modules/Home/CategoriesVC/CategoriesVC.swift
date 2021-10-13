//
//  CategoriesVC.swift
//  PaytabsDemoStore
//
//  Created by Ahmed Mostafa on 13/09/2021.
//

import UIKit
import RxSwift
import RxCocoa
import Moya

class CategoriesVC: BaseWireframe<CategoriesVM> {

    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.dataSource = CategoriesDataSrc
            collectionView.delegate   = CategoriesDataSrc
        }
    }
    var disposeBagg: DisposeBag = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        viewModel.getCategories()
        setupUI()

    }
    
    private lazy var CategoriesDataSrc: CategoriesDataSrc! = {
        let src = PaytabsDemoStore.CategoriesDataSrc()
        src.viewModel = viewModel
        src.onItemSelected = { [weak self] category in
            guard let self = self else {return}
            self.navigateToCategoriesDetails(Category: category)
        }
        return src
    }()
    
    private lazy var cartButton: UIBarButtonItem = {
        UIBarButtonItem(image: UIImage(systemName: "cart.fill"), style: .plain, target: self, action: #selector(navigateToCart))
    }()
    @objc func navigateToCart() {
        CartVC.show(on: self)
    }
    func setupUI() {
        self.navigationItem.rightBarButtonItem = cartButton
    }
    
    func registerCells(){
        collectionView.register(cell: CategoriesCell.self)
    }
    
    override func bind(viewModel: CategoriesVM) {
        viewModel
            .refreshView
            .asDriver(onErrorJustReturn: false)
            .drive(onNext:{[weak self] state in
                guard state else {return}
                self?.collectionView.reloadData()
            }).disposed(by: disposeBagg)
        
    }
}

extension CategoriesVC {
    func navigateToCategoriesDetails(Category: String) {
        let categoriesDetailsVM = CategoriesDetailsVM(dataManager: DataManager.create(), Category: Category)
        let categoriesDetailsVC = CategoriesDetailsVC.make(from: .main, with: categoriesDetailsVM)
        self.navigationController?.pushViewController(categoriesDetailsVC, animated: true)
    }
}
