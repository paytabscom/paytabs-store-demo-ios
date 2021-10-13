//
//  Single+Request.swift
//  PaytabsDemoStore
//
//  Created by PayTabs on 02/09/2021.
//

import Moya
import RxSwift

public extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    
    func mapItem<T: Decodable>() -> Single<T> {
        map(T.self, failsOnEmptyData: false)
    }
    
    func mapList<T: Decodable>() -> Single<[T]> {
        map([T].self, failsOnEmptyData: false)
    }
}
