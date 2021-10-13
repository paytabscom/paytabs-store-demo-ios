//
//  ProdcutDetailsVM.swift
//  PaytabsDemoStore
//
//  Created by Ahmed Mostafa on 13/09/2021.
//

import Foundation
import RxCocoa
import RxSwift
import RealmSwift

class ProductDetailsVM:ViewModel {
    
    var isLoading: PublishSubject<Bool> = .init()
    var displayError: PublishSubject<String> = .init()
    var dataManager: DataManager
    var disposeBag: DisposeBag = .init()
    var refreshView = PublishSubject<Bool>()
    var id:Int
    var product:ProductItem?
    
    init(dataManager: DataManager, id: Int) {
        self.dataManager = dataManager
        self.id = id
    }
}

extension ProductDetailsVM {
    
    func getProductDetails() {
        isLoading.onNext(true)
        dataManager
            .storeRepo
            .getProductDetails(id: id)
            .subscribe { [weak self] result in
                guard let self = self else { return }
                self.product = result
                self.refreshView.onNext(true)
                self.isLoading.onNext(false)
            } onError: { [weak self] error in
                guard let self = self else { return }
                self.handleError(error: error)
            }.disposed(by: disposeBag)
    }
    
    func setProductQuantity(quantity: Int) {
        product?.quantity = quantity
    }
    
    func addToCart() {
        guard let item = product else {
            return
        }
        dataManager
            .storeRepo
            .addToCart(item: item)
            .subscribe {
                self.displayError.onNext("Added To Cart Succesfully")
            } onError: { error in
                self.handleError(error: error)
            }.disposed(by: disposeBag)
    }
    
    func addToFavourite() {
        guard let item = product else {
            return
        }
        dataManager
            .storeRepo
            .addToFavourite(item: item)
            .subscribe {
                self.displayError.onNext("Added To Favourite Succesfully")
            } onError: { error in
                self.handleError(error: error)
            }.disposed(by: disposeBag)
    }
}
