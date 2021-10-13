//
//  CartDao.swift
//  PaytabsDemoStore
//
//  Created by PayTabs on 17/09/2021.
//

import Foundation
import RealmSwift
import RxSwift

public class CartDao {
    private lazy var realm: RealmManager = { RealmManager() }()

    public func cartProducts() -> Single<[ProductEntity]> {
        realm.objects()
    }

    public func add(entity: ProductEntity) -> Completable {
        realm.add(entity)
    }

    public func add(entities: [ProductEntity]) -> Completable {
        realm.add(entities)
    }
    
    public func delete(entity: ProductEntity) -> Completable {
        realm.delete(entity: entity, withId: entity.id)
    }

    public func entity(id: String) -> Single<ProductEntity> {
        realm.object(forPrimaryKey: id)
    }
}
