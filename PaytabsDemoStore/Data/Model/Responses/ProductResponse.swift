//
//  ProductResponse.swift
//  PaytabsDemoStore
//
//  Created by PayTabs on 02/09/2021.
//

import Foundation

// MARK: - WelcomeElement
struct ProductItem: Codable {
    let id: Int
    let title: String
    let itemPrice: Double
    let welcomeDescription: String
    let category: String
    let image: String
    var quantity = 1
    lazy var price: Double = {
        return itemPrice.rounded(toPlaces: 2)
    }()


    enum CodingKeys: String, CodingKey {
        case id, title
        case welcomeDescription = "description"
        case category, image
        case itemPrice = "price"
    }
    
    init(id: Int, title: String, price: Double, welcomeDescription: String, category: String, image: String, quantity: Int = 1) {
        self.id = id
        self.title = title
        self.itemPrice = price
        self.welcomeDescription = welcomeDescription
        self.category = category
        self.image = image
        self.quantity = quantity
    }
}

// MARK: - Rating
struct Rating: Codable {
    let rate: Double
    let count: Count
}

enum Count: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Count.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Count"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

