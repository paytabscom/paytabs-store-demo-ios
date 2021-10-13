//
//  PaymentVM.swift
//  PaytabsDemoStore
//
//  Created by Ahmed Mostafa on 23/09/2021.
//

import Foundation
import RxCocoa
import RxSwift
import RealmSwift

class OrdersVM: ViewModel{
    
    var isLoading: PublishSubject<Bool> = .init()
    var displayError: PublishSubject<String> = .init()
    var dataManager: DataManager
    var disposeBag: DisposeBag = .init()
    var refreshView = PublishSubject<Bool>()
    var ordersList = [ProductItem]()

    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
}

extension OrdersVM {
    
    func getProduct(at index: Int) -> ProductItem? {
        guard index < ordersList.count  else {
            return nil
        }
        return ordersList[index]
    }
    
    func getProductCount() -> Int {
        ordersList.count
    }
    
    func getProducts() {
        dataManager
            .storeRepo
            .getOrders()
            .subscribe { [weak self] result in
                guard let self = self else {return}
                self.ordersList = result ?? []
                self.refreshView.onNext(true)
            } onError: { [weak self] error in
                guard let self = self else {return}
                self.handleError(error: error)
            }.disposed(by: disposeBag)
    }
    
    
}


