//
//  CategoriesVC.swift
//  PaytabsDemoStore
//
//  Created by Ahmed Mostafa on 13/09/2021.
//

import UIKit
import RxSwift
import RxCocoa

class OrdersVC: BaseWireframe<OrdersVM> {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = OrdersDataSrc
            tableView.dataSource = OrdersDataSrc
            tableView.tableFooterView = UIView()
        }
    }
    
    var disposeBagg: DisposeBag = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getProducts()
        updateUI()
        registerCells()
    }
    
    private lazy var OrdersDataSrc: OrdersDataSrc! = {
        let src = PaytabsDemoStore.OrdersDataSrc()
        src.viewModel = viewModel
        updateUI()
        return src
    }()
    
    func registerCells(){
        tableView.register(cell: CartCell.self)
    }
    
    override func bind(viewModel: OrdersVM) {
        viewModel
            .refreshView
            .asDriver(onErrorJustReturn: false)
            .drive(onNext:{[weak self] state in
                guard state else {return}
                self?.updateUI()
            }).disposed(by: disposeBagg)
    }
    
    
    
    func updateUI() {
        title = "Orders History"
        tableView.reloadData()
    }
}

extension OrdersVC {
    
    static func showOrders(on vc: UIViewController) {
        let ordersVC = OrdersVC.make(from: .main, with: OrdersVM(dataManager: .init()))
        let topViewController = UIApplication.getTopViewController()
        ordersVC.hidesBottomBarWhenPushed = true
        topViewController?.navigationController?.pushViewController(ordersVC, animated: true)
    }
}
