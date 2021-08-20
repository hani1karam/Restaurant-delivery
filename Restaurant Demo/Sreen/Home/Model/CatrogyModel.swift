//
//  CatrogyModel.swift
//  Restaurant Demo
//
//  Created by hany karam on 8/13/21.
//

import Foundation
struct CatrogyModel: Codable {
    let status: Bool?
    let error: String?
    let data: [Datum]?

}

// MARK: - Datum
struct Datum: Codable {
    let id, categoryID: Int?
    let name: String?
    let datumDescription, discount: String?
    let size, extra: [Extra]?
    let image: String??

    enum CodingKeys: String, CodingKey {
        case id
        case categoryID = "categoryId"
        case name
        case datumDescription = "description"
        case discount, size, extra, image
    }
}
struct Extra: Codable {
    let id: Int?
    let name: String?
    let price: String?
}
