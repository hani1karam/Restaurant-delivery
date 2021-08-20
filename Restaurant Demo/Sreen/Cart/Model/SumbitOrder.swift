//
//  SumbitOrder.swift
//  Restaurant Demo
//
//  Created by hany karam on 8/17/21.
//

import Foundation
struct SumbitOrder: Codable {
    let status: Bool?
    let error: String?
    let data: SumbitOrderDataClass?
}

// MARK: - DataClass
struct SumbitOrderDataClass: Codable {
    let message: String?
    let orderID: Int?
    
    enum CodingKeys: String, CodingKey {
        case message
        case orderID = "orderId"
    }
}
