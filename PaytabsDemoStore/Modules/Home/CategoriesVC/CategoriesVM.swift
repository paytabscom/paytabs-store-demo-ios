//
//  CategoriesVM.swift
//  PaytabsDemoStore
//
//  Created by Ahmed Mostafa on 13/09/2021.
//

import Foundation
import RxCocoa
import RxSwift

class CategoriesVM: ViewModel{
    
    var isLoading: PublishSubject<Bool> = .init()
    var displayError: PublishSubject<String> = .init()
    var dataManager: DataManager
    var disposeBag: DisposeBag = .init()
    var refreshView = PublishSubject<Bool>()
    private var categoriesList = [String]()

    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    struct StaticImages{
        static var image1 = #imageLiteral(resourceName: "Electonics")
        static var image2 = #imageLiteral(resourceName: "Jewlery")
        static var image3 = #imageLiteral(resourceName: "MenClothing")
        static var image4 = #imageLiteral(resourceName: "women's clothing")
        static let categoriesStaticImages = [image1, image2, image3, image4]
    }
}

extension CategoriesVM{
    

    
    func getCategory(at index: Int) -> String? {
        guard index < categoriesList.count else {
            return nil
        }
        return categoriesList[index]
    }
    
    func getCategoriesCount() -> Int {
        categoriesList.count
    }
    
    func getImage(at index: String) -> UIImage? {
        switch index {
        case "electronics":
            return StaticImages.categoriesStaticImages[0]
        case "jewelery":
            return StaticImages.categoriesStaticImages[1]
        case "men's clothing":
            return StaticImages.categoriesStaticImages[2]
        case "women's clothing":
            return StaticImages.categoriesStaticImages[3]
        default:
            return StaticImages.categoriesStaticImages[0]
        }
    }
    
    func getCategories(){
        dataManager
            .storeRepo
            .getCategories()
            .subscribe { result in
                self.categoriesList = result
                self.refreshView.onNext(true)
            } onError: { [weak self] error in
                guard let self = self else {return}
                self.handleError(error: error)
            }.disposed(by: disposeBag)
    }
    
    
    
}
