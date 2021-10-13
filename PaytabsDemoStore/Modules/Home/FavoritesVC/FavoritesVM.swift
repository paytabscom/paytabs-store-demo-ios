//
//  CategoriesVM.swift
//  PaytabsDemoStore
//
//  Created by Ahmed Mostafa on 13/09/2021.
//

import Foundation
import RxCocoa
import RxSwift

class FavoritesVM: ViewModel{
    
    var isLoading: PublishSubject<Bool> = .init()
    var displayError: PublishSubject<String> = .init()
    var dataManager: DataManager
    var disposeBag: DisposeBag = .init()
    var refreshView = PublishSubject<Bool>()
    var itemsList = [ProductItem]()
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    
}

extension FavoritesVM{
    
    
    func getProduct(at index: Int) -> ProductItem? {
        guard index < itemsList.count  else {
            return nil
        }
        return itemsList[index]
    }
    
    func getProductCount() -> Int {
        itemsList.count
    }
    
    func getProducts() {
        dataManager
            .storeRepo
            .getFavourites()
            .subscribe { [weak self] result in
                guard let self = self else {return}
                self.itemsList = result ?? []
                self.refreshView.onNext(true)
            } onError: { [weak self] error in
                guard let self = self else {return}
                self.handleError(error: error)
            }.disposed(by: disposeBag)
    }
    
    func deleteFavourite(index: Int) {
        guard let item = getProduct(at: index) else {return}
        dataManager
            .storeRepo
            .localDataSrc
            .deleteFavourite(item: item)
            .subscribe(onCompleted: { [weak self] in
                self?.getProducts()
                self?.refreshView.onNext(true)
            }, onError: {[weak self] error in
                self?.handleError(error: error)
            }).disposed(by: disposeBag)
    }
    
}
