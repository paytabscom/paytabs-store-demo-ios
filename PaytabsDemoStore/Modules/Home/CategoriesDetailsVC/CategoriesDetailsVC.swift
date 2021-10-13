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

class CategoriesDetailsVC: BaseWireframe<CategoriesDetailsVM> {

    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.dataSource = CategoriesDetailsDataSrc
            tableView.delegate = CategoriesDetailsDataSrc
            tableView.tableFooterView = UIView()

            
        }
    }
    
    var disposeBagg: DisposeBag = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getItemsList()
        registerCells()
        setupUI()
    }
    
    
    private lazy var CategoriesDetailsDataSrc: CategoriesDetailsDataSrc! = {
        let src = PaytabsDemoStore.CategoriesDetailsDataSrc()
        src.viewModel = viewModel
        src.onItemSelected = { [weak self] id in
            guard let self = self else {return}
            self.navigateToDetails(id: id)
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
        self.tableView.reloadData()
    }
    
    func registerCells(){
        tableView.register(cell: CategoriesDetailsCell.self)
    }
    
    override func bind(viewModel: CategoriesDetailsVM) {
        viewModel
            .refreshView
            .asDriver(onErrorJustReturn: false)
            .drive(onNext:{[weak self] state in
                guard state else {return}
                self?.tableView.reloadData()
            }).disposed(by: disposeBagg)
        
    }
}

extension CategoriesDetailsVC {
    func navigateToDetails(id: Int){
        let productDetailsVM = ProductDetailsVM(dataManager: DataManager.create(), id: id)
        let detailsVC = ProductDetailsVC.make(from: .main, with: productDetailsVM)
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}
