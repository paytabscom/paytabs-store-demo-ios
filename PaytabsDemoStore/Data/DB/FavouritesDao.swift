//
//  FavouritesDao.swift
//  PaytabsDemoStore
//
//  Created by PayTabs on 10/10/2021.
//

import Foundation
import RealmSwift
import RxSwift

public class FavouritesDao {
    private lazy var realm: RealmManager = { RealmManager() }()

    public func favouritesList() -> Single<[FavouriteEntity]> {
        realm.objects()
    }

    public func addToFavourite(entity: FavouriteEntity) -> Completable {
        realm.add(entity)
    }
    
    public func delete(entity: FavouriteEntity) -> Completable {
        realm.delete(entity: entity, withId: entity.id)
    }

    public func entity(id: String) -> Single<FavouriteEntity> {
        realm.object(forPrimaryKey: id)
    }
}
