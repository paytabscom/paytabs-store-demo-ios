//
//  ProductEntity.swift
//  PaytabsDemoStore
//
//  Created by PayTabs on 17/09/2021.
//

import Foundation
import RxSwift
import RealmSwift
import ModelsMapper

@objcMembers
public class ProductEntity: Object {
    @objc dynamic var id = 0
    @objc dynamic var title = ""
    @objc dynamic var descreption = ""
    @objc dynamic var price:Double = 0
    @objc dynamic var image = ""
    @objc dynamic var created = Date()
    @objc dynamic var quantity = 1
    @objc dynamic var category: String = ""

    public override static func primaryKey() -> String? { "id" }
}

class ProductEntityMapper: Mapper {
    typealias I = ProductItem
    typealias O = ProductEntity
    
    func map(_ input: ProductItem) -> ProductEntity {
        let entity = ProductEntity()
        entity.id = input.id
        entity.descreption = input.welcomeDescription
        entity.created = Date()
        entity.image = input.image
        entity.price = input.itemPrice
        entity.title = input.title
        entity.quantity = input.quantity
        entity.category = input.category
        return entity
    }
}

class ProductItemMapper: Mapper {
    typealias I = ProductEntity
    typealias O = ProductItem
    
    func map(_ input: ProductEntity) -> ProductItem {
        ProductItem(
            id: input.id,
            title: input.title,
            price: input.price,
            welcomeDescription: input.descreption,
            category: input.category,
            image: input.image,
            quantity: input.quantity
        )
    }
}
