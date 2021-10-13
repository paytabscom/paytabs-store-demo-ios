//
//  StoreAPI.swift
//  PaytabsDemoStore
//
//  Created by PayTabs on 02/09/2021.
//

import Moya

enum StoreAPI {
    case getProduct
    case getCategory
    case getWomenClothing
    case getMenClothing
    case getElectronics
    case getJewelery
    case getProductDetails(id: Int)
    case getCategoryDetails(Category: String)
}

extension StoreAPI: TargetType {
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getProduct:
            return "products"
        case .getCategory:
            return "products/categories"
        case .getMenClothing:
            return "products/category/men's clothing"
        case .getWomenClothing:
            return "products/category/women's clothing"
        case .getElectronics:
            return "products/category/electronics"
        case .getJewelery:
            return "products/category/women's clothing"
        case .getCategoryDetails(let Category):
            return "products/category/\(Category)"
        case .getProductDetails(let id):
            return "products/\(id)"
        }
    }
    
    var method: Method {
        switch self {
        case .getProduct, .getJewelery, .getElectronics, .getWomenClothing, .getMenClothing, .getCategory, .getProductDetails, .getCategoryDetails:
            return .get
            
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getProduct, .getCategory, .getJewelery, .getElectronics, .getWomenClothing, .getMenClothing, .getProductDetails, .getCategoryDetails:
            return .requestPlain

        }
    }
    
    var headers: [String : String]? {
        [:]
    }
}


