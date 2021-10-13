//
//  CartVM.swift
//  PaytabsDemoStore
//
//  Created by Ahmed Mostafa on 15/09/2021.
//

import Foundation
import RxCocoa
import RxSwift
import RealmSwift

class CartVM: ViewModel {
    var isLoading: PublishSubject<Bool> = .init()
    var displayError: PublishSubject<String> = .init()
    var dataManager: DataManager
    var disposeBag: DisposeBag = .init()
    var refreshView = PublishSubject<Bool>()
    var itemsList = [ProductItem]()
    var totalPrice:Double = 0
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
}

extension CartVM {
        
    func getProduct(at index: Int) -> ProductItem? {
        guard index < itemsList.count  else {
            return nil
        }
        return itemsList[index]
    }
    
    func getProductCount() -> Int {
        itemsList.count
    }
    
    func calculateTotalPrice() {
        itemsList.forEach { item in
            totalPrice += item.price * Double(item.quantity)
        }
    }
    
    func getProducts() {
        dataManager
            .storeRepo
            .getCart()
            .subscribe { [weak self] result in
                guard let self = self else {return}
                self.itemsList = result ?? []
                self.calculateTotalPrice()
                self.refreshView.onNext(true)
            } onError: { [weak self] error in
                guard let self = self else {return}
                self.handleError(error: error)
            }.disposed(by: disposeBag)
    }
    
    func deleteProduct(index: Int) {
        guard let item = getProduct(at: index) else {return}
        dataManager
            .storeRepo
            .removeProductFromCart(item: item)
            .subscribe(onCompleted: { [weak self] in
                self?.getProducts()
            }, onError: {[weak self] error in
                self?.handleError(error: error)
            }).disposed(by: disposeBag)
    }
    
    func clearCart() {
        for i in 0..<itemsList.count {
            deleteProduct(index: i)
        }
    }
    
    func updateProductQuantity(index: Int, Quantity: Int){
        guard var item = getProduct(at: index) else {
            return
        }
        item.quantity = Quantity
        dataManager
            .storeRepo
            .addToCart(item: item)
            .subscribe(onCompleted: { [weak self] in
                self?.getProducts()
            }, onError: {[weak self] error in
                self?.handleError(error: error)
            }).disposed(by: disposeBag)
    }
    
    func saveOrder() {
        dataManager
            .storeRepo
            .localDataSrc
            .addOrders(items: itemsList)
            .subscribe(onCompleted: { [weak self] in
                self?.getProducts()
                self?.totalPrice = 0
                self?.refreshView.onNext(true)
            }, onError: {[weak self] error in
                self?.handleError(error: error)
            }).disposed(by: disposeBag)
    }
}

