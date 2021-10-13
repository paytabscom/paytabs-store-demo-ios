//
//  OrderDao.swift
//  PaytabsDemoStore
//
//  Created by PayTabs on 10/10/2021.
//

import Foundation
import RealmSwift
import RxSwift

public class OrderDao {
    private lazy var realm: RealmManager = { RealmManager() }()

    public func ordersHistory() -> Single<[OrderEntity]> {
        realm.objects()
    }

    public func save(entity: OrderEntity) -> Completable {
        realm.add(entity)
    }

    public func save(entities: [OrderEntity]) -> Completable {
        realm.add(entities)
    }
    
    public func delete(entity: OrderEntity) -> Completable {
        realm.delete(entity: entity, withId: entity.id)
    }

    public func entity(id: String) -> Single<OrderEntity> {
        realm.object(forPrimaryKey: id)
    }
}

