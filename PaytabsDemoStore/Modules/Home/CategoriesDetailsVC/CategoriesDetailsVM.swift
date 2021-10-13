//
//  CategoriesVM.swift
//  PaytabsDemoStore
//
//  Created by Ahmed Mostafa on 13/09/2021.
//

import Foundation
import RxCocoa
import RxSwift

class CategoriesDetailsVM: ViewModel{
    
    var isLoading: PublishSubject<Bool> = .init()
    var displayError: PublishSubject<String> = .init()
    var dataManager: DataManager
    var disposeBag: DisposeBag = .init()
    var refreshView = PublishSubject<Bool>()
    var category = String()
    private var itemsList = [ProductItem]()

    init(dataManager: DataManager, Category: String) {
        self.dataManager = dataManager
        self.category = Category
        self.getItemsList()
    }
}

extension CategoriesDetailsVM{
    
    
    func getProduct(at index: Int) -> ProductItem? {
        guard index < itemsList.count  else {
            return nil
        }
        return itemsList[index]
    }
        
    func getItemsList() {
        dataManager
            .storeRepo
            .getCategoryDetails(Category: category)
            .subscribe { [weak self] result in
                guard let self = self else {return}
                self.itemsList = result ?? []
                self.refreshView.onNext(true)
            } onError: { [weak self] error in
                guard let self = self else {return}
                self.handleError(error: error)
            }.disposed(by: disposeBag)
    }
    
    func getItemsListCount() -> Int {
        return itemsList.count
    }
    

}
