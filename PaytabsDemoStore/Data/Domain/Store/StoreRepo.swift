//
//  StoreRepo.swift
//  PaytabsDemoStore
//
//  Created by PayTabs on 02/09/2021.
//

import Moya
import RxSwift
import RxCocoa

public class StoreRepo {
    
    let remoteDataSrc: StoreRemoteDaraSrc
    
    let localDataSrc: StoreLocalDataSrc
    
    init(remote: StoreRemoteDaraSrc, local: StoreLocalDataSrc) {
        self.remoteDataSrc = remote
        self.localDataSrc = local
    }
}
//MARK:- Remote API
extension StoreRepo {
    func getAllProducts() -> Single<[ProductItem]> {
        remoteDataSrc.getAllProducts()
    }
    
    func getCategories() -> Single <[String]> {
        remoteDataSrc.getCategories()
    }
    
    func getCategoryDetails(Category: String) -> Single <[ProductItem]> {
        remoteDataSrc.getCategoryDetails(category: Category)
    }
    
    func getWomenClothing() -> Single<[ProductItem]> {
        remoteDataSrc.getWomenClothing()
    }
    
    func getMenClothing() -> Single<[ProductItem]> {
        remoteDataSrc.getMenClothing()
    }
    
    func getJewelery() -> Single<[ProductItem]> {
        remoteDataSrc.getJewelery()
    }
    
    func getElectronics() -> Single<[ProductItem]> {
        remoteDataSrc.getElectronics()
    }
    
    func getProductDetails(id: Int) -> Single<ProductItem> {
        remoteDataSrc.getProductDetails(id: id)
    }
}

//MARK:- Cart
extension StoreRepo {
    func getCart() -> Single<[ProductItem]?> {
        localDataSrc.getAllProducts()
    }
    
    func addToCart(item: ProductItem) -> Completable {
        localDataSrc.addProductToCart(item: item)
    }
    
    func removeProductFromCart(item: ProductItem) -> Completable {
        localDataSrc.deleteProduct(item: item)
    }
}

//MARK:- Orders History
extension StoreRepo {
    func getOrders() -> Single<[ProductItem]?> {
        localDataSrc.getOrdersHistory()
    }
    
    func saveOrders(items: [ProductItem]) -> Completable {
        localDataSrc.addOrders(items: items)
    }
    
    func removeFromOrders(item: ProductItem) -> Completable {
        localDataSrc.deleteOrder(item: item)
    }
}

//MARK:- Favourites
extension StoreRepo {
    func getFavourites() -> Single<[ProductItem]?> {
        localDataSrc.getFavourites()
    }
    
    func addToFavourite(item: ProductItem) -> Completable {
        localDataSrc.addProductToFavourites(item: item)
    }
    
    func removeFromFavourite(item: ProductItem) -> Completable {
        localDataSrc.deleteFavourite(item: item)
    }
}

//MARK:- Creation
extension StoreRepo {
    public static func create() -> StoreRepo {
        let storeApiTarget: MoyaProvider<StoreAPI> = MoyaProviderBuilder.makeProvider()
        let storeDataSrc = StoreRemoteDaraSrc(api: storeApiTarget)
        let local = StoreLocalDataSrc(cartDB: CartDao(), orderDB: OrderDao(), favouriteDB: FavouritesDao())
        return StoreRepo(remote: storeDataSrc, local: local)
    }
}
