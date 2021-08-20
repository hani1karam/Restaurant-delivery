//
//  ProductModel.swift
//  Restaurant Demo
//
//  Created by hany karam on 8/13/21.
//

import Foundation
struct ProductModel: Codable {
    let status: Bool?
    let error: String?
    let data: ProductModelDatum?
}
// MARK: - ProductModelDatum
struct ProductModelDatum: Codable {
    let id: Int?
    let name: String?
    let image: String?
    let products: [ProductModelDatumExtra]?
}
struct ProductModelDatumExtra: Codable {
    let id, categoryID: Int?
    let name, productDescription, discount: String?
    let size, extra: [ProductModelDatumExtraExtra]?
    let image: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case categoryID = "categoryId"
        case name
        case productDescription = "description"
        case discount, size, extra, image
    }
}
struct ProductModelDatumExtraExtra: Codable {
    let id: Int?
    let name, price: String?
}
