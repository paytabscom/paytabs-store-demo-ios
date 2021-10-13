//
//  RealmManager.swift
//  PaytabsDemoStore
//
//  Created by PayTabs on 17/09/2021.
//
import Foundation
import RealmSwift
import Realm
import RxSwift

public var realmQueue: DispatchQueue = {
    DispatchQueue.main
}()

public class RealmManager {
    public init() {}

    func add(_ obj: Object) -> Completable {
        Completable.create { completable in
            autoreleasepool {
                realmQueue.async {
                    do {
                        let realm = try! Realm()
                        try realm.write {
                            // detach to keep the original object unmanaged to use it
                            // in any thread
                            let object = obj.detached()
                            realm.add(object, update: .all)
                            completable(.completed)
                        }
                    } catch {
                        completable(.error(error))
                    }
                }
            }
            return Disposables.create()
        }
    }

    func add(_ objects: [Object]) -> Completable {
        Completable.create { completable in
            autoreleasepool {
                realmQueue.async {
                    do {
                        let realm = try! Realm()
                        try realm.write {
                            // detach to keep the original object unmanaged to use it
                            // in any thread

                            for obj in objects {
                                let object = obj.detached()
                                realm.add(object, update: .all)
                            }

                            completable(.completed)
                        }
                    } catch {
                        completable(.error(error))
                    }
                }
            }
            return Disposables.create()
        }
    }
    
    func update(_ objects: [Object]) -> Completable {
        
        Completable.create { completable in
            autoreleasepool {
                realmQueue.async {
                    do {
                        let realm = try! Realm()
                        try realm.write {
                            for obj in objects {
                                let object = obj.detached()
                                realm.add(object, update: .modified)
                            }

                            completable(.completed)
                        }
                    } catch {
                        completable(.error(error))
                    }
                }
            }
            return Disposables.create()
        }
    }

    func delete<T: Object, ID>(entity: T, withId id: ID) -> Completable {
        Completable.create { completable in
            realmQueue.async {
                autoreleasepool {
                    do {
                        let realm = try Realm()
                        let obj = realm.objects(T.self).filter("id == \(id)").first
                        guard let object: T = obj else {
                            let error = NSError(
                                    domain: "Internal client error",
                                    code: 100,
                                    userInfo: [NSLocalizedDescriptionKey: "oops something went wrong"]
                            )
                            completable(.error(error))
                            return
                        }
                        print("User is existed, it's being deleted.")
                        try realm.write {
                            realm.delete(object)
                            completable(.completed)
                        }
                        
                    } catch {
                        completable(.error(error))
                    }
                }
            }
            return Disposables.create()
        }
    }
    
    func object<T: Object, KeyType>(forPrimaryKey key: KeyType) -> Single<T> {
        Single<T>.create { single in
            realmQueue.async {
                autoreleasepool {
                    let realm = try! Realm()
                    let obj = realm.object(ofType: T.self, forPrimaryKey: key)
                    guard let object: T = obj else {
                        let error = NSError(
                                domain: "Internal client error",
                                code: 100,
                                userInfo: [NSLocalizedDescriptionKey: "oops something went wrong"]
                        )
                        single(.error(error))
                        return
                    }
                    // detach to keep the object unmanaged to use it
                    // in any thread
                    let detached = object.detached()
                    single(.success(detached))
                }
            }
            return Disposables.create()
        }
    }

    func objects<T: Object>(predicate: String? = nil) -> Single<[T]> {
        Single<[T]>.create { single in
            realmQueue.async {
                autoreleasepool {
                    let realm = try! Realm()
                    let list = realm.objects(T.self)
                    
                    guard let predicate = predicate, !predicate.isEmpty else{
                        let detached = list.detached
                        single(.success(detached))
                        return
                    }
                    let detached = list.filter(predicate).detached
                    single(.success(detached))
                }
            }
            return Disposables.create()
        }
    }

    public func deleteAll() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
}

