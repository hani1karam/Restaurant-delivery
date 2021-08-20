//
//  ShowDetilaModel.swift
//  Restaurant Demo
//
//  Created by hany karam on 8/17/21.
//

import Foundation
struct ShowDetilaModel: Codable {
    let status: Bool?
    let error: String?
    let data: ShowDetilaModelDataClass?
}

// MARK: - DataClass
struct ShowDetilaModelDataClass: Codable {
    let id: Int
    let code, status, date, day: String
    let dayTitle, hour, minute, format: String
    let phone, address, shippingPrice, subTotal: String
    let total: String
    let products: [ShowDetilaModelProduct]

    enum CodingKeys: String, CodingKey {
        case id, code, status, date, day
        case dayTitle = "day_title"
        case hour, minute, format, phone, address, shippingPrice, subTotal, total, products
    }
}

// MARK: - Product
struct ShowDetilaModelProduct: Codable {
    let productID, sizeID, extraID, productName: String
    let sizeName, extraName, price, quantity: String
    let total: String
    let image: String

    enum CodingKeys: String, CodingKey {
        case productID = "productId"
        case sizeID = "sizeId"
        case extraID = "extraId"
        case productName, sizeName, extraName, price, quantity, total, image
    }

}
