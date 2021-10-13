//
//  PaymentVC.swift
//  PaytabsDemoStore
//
//  Created by Ahmed Mostafa on 19/09/2021.
//

import UIKit
import PaymentSDK
import PassKit

class PaymentVC: BaseWireframe<PaymentVM> {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func bind(viewModel: PaymentVM) {
        viewModel
            .refreshView
            .asDriver(onErrorJustReturn: false)
            .drive(onNext:{[weak self] state in
                guard state else {return}
            }).disposed(by: disposeBag)
    }
    
    @IBAction func payWithCard(_ sender: Any) {
        PaymentManager.startCardPayment(on: self, configuration: viewModel.configuration, delegate: self)
    }
}

extension PaymentVC: PaymentManagerDelegate {
    
    func paymentManager(didFinishTransaction transactionDetails: PaymentSDKTransactionDetails?, error: Error?) {
        if let transactionDetails = transactionDetails {
            print("Response Code: " + (transactionDetails.paymentResult?.responseCode ?? ""))
            print("Result: " + (transactionDetails.paymentResult?.responseMessage ?? ""))
            print("Token: " + (transactionDetails.token ?? ""))
            print("Transaction Reference: " + (transactionDetails.transactionReference ?? ""))
            print("Transaction Time: " + (transactionDetails.paymentResult?.transactionTime ?? "" ))
        } else if let error = error {
            viewModel.handleError(error: error)
        }
    }
}
