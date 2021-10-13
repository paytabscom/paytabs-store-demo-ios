//
//  CartVC.swift
//  PaytabsDemoStore
//
//  Created by Ahmed Mostafa on 15/09/2021.
//

import UIKit
import PaymentSDK
import RealmSwift

class CartVC: BaseWireframe<CartVM> {
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.dataSource = CartDataSrc
            tableView.delegate = CartDataSrc
            tableView.tableFooterView = UIView()
        }
    }
    @IBOutlet weak var totalLabel: UILabel!
    
    var paymentVM: PaymentVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        viewModel.getProducts()
        updateUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateUI()
    }
    
    private lazy var CartDataSrc: CartVCDataSrc = {
        let src = CartVCDataSrc()
        src.viewModel = viewModel
        return src
    }()
    
    override func bind(viewModel: CartVM) {
        viewModel
            .refreshView
            .asDriver(onErrorJustReturn: false)
            .drive(onNext:{[weak self] state in
                guard state else {return}
                self?.updateUI()
            }).disposed(by: disposeBag)
    }
    
    func updateUI() {
        viewModel.calculateTotalPrice()
        totalLabel.text = "$\(Int(viewModel.totalPrice))"
        tableView.reloadData()
        title = "Cart"
    }
    
    func registerCells(){
        tableView.register(cell: CartCell.self)
    }
    
    @IBAction func continueToCheckout(_ sender: Any) {
        paymentVM.setAmount(amount: viewModel.totalPrice)
        PaymentManager.startCardPayment(on: self, configuration: paymentVM.configuration, delegate: self)
        
    }
}

extension CartVC: PaymentManagerDelegate {
    
    func paymentManager(didFinishTransaction transactionDetails: PaymentSDKTransactionDetails?, error: Error?) {
        if let transactionDetails = transactionDetails {
            print("Response Code: " + (transactionDetails.paymentResult?.responseCode ?? ""))
            print("Result: " + (transactionDetails.paymentResult?.responseMessage ?? ""))
            print("Token: " + (transactionDetails.token ?? ""))
            print("Transaction Reference: " + (transactionDetails.transactionReference ?? ""))
            print("Transaction Time: " + (transactionDetails.paymentResult?.transactionTime ?? "" ))
                        
            viewModel.saveOrder()
            viewModel.clearCart()
            updateUI()
            navigationController?.popViewController(animated: true)
            NotifiyMessage.shared.toast(toastMessage: "Order Done and check orders please")
        } else if let error = error {
            viewModel.handleError(error: error)
        }
    }
}

extension CartVC {
    static func show(on vc: UIViewController) {
        let cartVC = CartVC.make(from: .main, with: CartVM(dataManager: .init()))
        let topViewController = UIApplication.getTopViewController()
        cartVC.paymentVM = PaymentVM(dataManager: .create())
        cartVC.hidesBottomBarWhenPushed = true
        topViewController?.navigationController?.pushViewController(cartVC, animated: true)
    }
}
