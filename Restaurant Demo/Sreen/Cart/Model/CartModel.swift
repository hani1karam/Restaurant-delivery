//
//  CartModel.swift
//  Restaurant Demo
//
//  Created by hany karam on 8/16/21.
//

import Foundation
struct ShowCartModel: Codable {
    let status: Bool?
    let error: String?
    let data: ShowCartDataClass?
}

// MARK: - ShowCartDataClass
struct ShowCartDataClass: Codable {
    let totalPrice: String?
    let items: [Item]?
}

// MARK: - Item
struct Item: Codable {
    let productID, sizeID, extraID: Int?
    let productName, sizeName, extraName, price: String?
    let discountPrice, discount, quantity, total: String?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case productID = "productId"
        case sizeID = "sizeId"
        case extraID = "extraId"
        case productName, sizeName, extraName, price, discountPrice, discount, quantity, total, image
    }

}
