//
//  HomeVM.swift
//  PaytabsDemoStore
//
//  Created by PayTabs on 12/09/2021.
//

import Foundation
import RxCocoa
import RxSwift

class HomeVM: ViewModel {
    var isLoading: PublishSubject<Bool> = .init()
    var displayError: PublishSubject<String> = .init()
    var dataManager: DataManager
    var disposeBag: DisposeBag = .init()
    var refreshView = PublishSubject<Bool>()
    
    private var itemsList = [ProductItem]()
    private var womenClothingList = [ProductItem]()
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
}

extension HomeVM {
    
    func viewDidLoad() {
        getProducts()
        getWomenClothing()
    }
    
    func getProduct(at index: Int) -> ProductItem? {
        guard index < itemsList.count  else {
            return nil
        }
        return itemsList[index]
    }
    
    func getProductCount() -> Int {
        itemsList.count > 5 ? 5 : itemsList.count
    }
    
    func getWomenClothes(at index: Int) -> ProductItem? {
        guard index < womenClothingList.count  else {
            return nil
        }
        return womenClothingList[index]
    }
    
    func getWomenClothesCount() -> Int {
        womenClothingList.count
    }
    
    func getProducts() {
        dataManager
            .storeRepo
            .getAllProducts()
            .subscribe { result in
                self.itemsList = result
                self.refreshView.onNext(true)
            } onError: { [weak self] error in
                guard let self = self else {return}
                self.handleError(error: error)
            }.disposed(by: disposeBag)
    }
    
    func getWomenClothing() {
        dataManager
            .storeRepo
            .getWomenClothing()
            .subscribe { result in
                self.womenClothingList = result
                self.refreshView.onNext(true)
            } onError: { [weak self]  error in
                guard let self = self else {return}
                self.handleError(error: error)
            }.disposed(by: disposeBag)
    }
}
