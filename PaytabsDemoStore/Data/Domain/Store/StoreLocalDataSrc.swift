//
//  StoreLocalDataSrc.swift
//  PaytabsDemoStore
//
//  Created by PayTabs on 17/09/2021.
//

import Foundation
import RxSwift
import ModelsMapper

class StoreLocalDataSrc {
    private let cartDB: CartDao
    private let orderDB: OrderDao
    private let favouriteDB: FavouritesDao

    init(cartDB: CartDao, orderDB: OrderDao, favouriteDB: FavouritesDao) {
        self.cartDB = cartDB
        self.orderDB = orderDB
        self.favouriteDB = favouriteDB
    }

    public func getAllProducts() -> Single<[ProductItem]?> {
        cartDB.cartProducts().map { entities in
            entities.map { entity in
                ProductItemMapper().map(entity)
            }
        }
    }
    
    public func getFavourites() -> Single<[ProductItem]?> {
        favouriteDB.favouritesList().map { entities in
            entities.map { entity in
                FavouritesItemMapper().map(entity)
            }
        }
    }
    
    public func getOrdersHistory() -> Single<[ProductItem]?> {
        orderDB.ordersHistory().map { entities in
            entities.map { entity in
                OrderItemMapper().map(entity)
            }
        }
    }
    
    func addProductToCart(item: ProductItem) -> Completable {
        let entity = ProductEntityMapper().map(item)
        return cartDB.add(entity: entity)
    }
    
    func addProductToFavourites(item: ProductItem) -> Completable {
        let entity = FavouritesEntityMapper().map(item)
        return favouriteDB.addToFavourite(entity: entity)
    }
    
    
    func addOrders(items: [ProductItem]) -> Completable {
        var entities = [OrderEntity]()
        items.forEach { item in
            entities.append(OrderEntityMapper().map(item))
        }
        return orderDB.save(entities: entities)
    }
    
    func deleteProduct(item: ProductItem) -> Completable {
        let entity = ProductEntityMapper().map(item)
        return cartDB.delete(entity: entity)
    }
    
    func deleteFavourite(item: ProductItem) -> Completable {
        let entity = FavouritesEntityMapper().map(item)
        return favouriteDB.delete(entity: entity)
    }
    
    func deleteOrder(item: ProductItem) -> Completable {
        let entity = OrderEntityMapper().map(item)
        return orderDB.delete(entity: entity)
    }
}
