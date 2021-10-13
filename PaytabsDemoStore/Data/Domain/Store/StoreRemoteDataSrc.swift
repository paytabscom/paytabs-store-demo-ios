//
//  StoreRemoteDataSrc.swift
//  PaytabsDemoStore
//
//  Created by PayTabs on 02/09/2021.
//

import Moya
import RxSwift

public class StoreRemoteDaraSrc {
    
    let api: MoyaProvider<StoreAPI>
    
    init(api:  MoyaProvider<StoreAPI>) {
        self.api = api
    }
    
    func getAllProducts() -> Single<[ProductItem]> {
        api.rx.request(.getProduct).mapItem()
    }
    
    func getCategories() -> Single<[String]>{
        api.rx.request(.getCategory).mapItem()
    }
    func getCategoryDetails(category: String) -> Single<[ProductItem]>{
        api.rx.request(.getCategoryDetails(Category: category)).mapItem()
    
    }
    
    func getWomenClothing() -> Single<[ProductItem]>{
        api.rx.request(.getWomenClothing).mapItem()
    }
    
    func getMenClothing() -> Single<[ProductItem]>{
        api.rx.request(.getMenClothing).mapItem()
    }
    
    func getElectronics() -> Single<[ProductItem]>{
        api.rx.request(.getElectronics).mapItem()
    }
    
    func getJewelery() -> Single<[ProductItem]>{
        api.rx.request(.getJewelery).mapItem()
    }
    
    func getProductDetails(id: Int) -> Single<ProductItem>{
        api.rx.request(.getProductDetails(id: id)).mapItem()
    }
}

