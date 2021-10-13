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

class FavoritesVC: BaseWireframe<FavoritesVM> {
    var disposeBagg: DisposeBag = .init()
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = FavoritesDataSrc
            tableView.dataSource = FavoritesDataSrc
            tableView.tableFooterView = UIView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
        viewModel.getProducts()
    }
    
    private lazy var FavoritesDataSrc: FavoritesDataSrc! = {
        let src = PaytabsDemoStore.FavoritesDataSrc()
        src.viewModel = viewModel
        src.onItemSelected = { [weak self] id in
            guard let self = self else {return}
            self.navigateToDetails(id: id)
        }
        updateUI()
        return src
    }()
    
    private lazy var cartButton: UIBarButtonItem = {
        UIBarButtonItem(image: UIImage(systemName: "cart.fill"), style: .plain, target: self, action: #selector(navigateToCart))
    }()
    
    @objc func navigateToCart() {
        CartVC.show(on: self)
    }
    
    override func bind(viewModel: FavoritesVM) {
        viewModel
            .refreshView
            .asDriver(onErrorJustReturn: false)
            .drive(onNext:{[weak self] state in
                guard state else {return}
                self?.updateUI()
            }).disposed(by: disposeBagg)
        
    }
    
    func registerCells(){
        tableView.register(cell: FavoriteCell.self)
    }
    
    func updateUI() {
        tableView.reloadData()
        self.navigationItem.rightBarButtonItem = cartButton
    }
    
}

extension FavoritesVC {
    
    func navigateToDetails(id: Int){
        let productDetailsVM = ProductDetailsVM(dataManager: DataManager.create(), id: id)
        let detailsVC = ProductDetailsVC.make(from: .main, with: productDetailsVM)
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}
