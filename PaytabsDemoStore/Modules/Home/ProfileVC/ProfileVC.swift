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

class ProfileVC: BaseWireframe<ProfileVM> {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = ProfileDataSrc
            tableView.delegate = ProfileDataSrc
            tableView.tableFooterView = UIView()
        }
    }
    
    var disposeBagg: DisposeBag = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        setupUI()
    }
    
    private func registerCells() {
        tableView.register(cell: InfoCell.self)
    }
    
    private lazy var ProfileDataSrc: ProfileDataSrc! = {
        let src = PaytabsDemoStore.ProfileDataSrc()
        src.viewModel = viewModel
        src.onItemSelected = { [weak self] in
            self?.navigateToOrdersVC()
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
    
    
    override func bind(viewModel: ProfileVM) {
        viewModel
            .refreshView
            .asDriver(onErrorJustReturn: false)
            .drive(onNext:{[weak self] state in
                guard state else {return}
            }).disposed(by: disposeBagg)
        
    }
    
    func navigateToOrdersVC() {
        OrdersVC.showOrders(on: self)
    }
}


