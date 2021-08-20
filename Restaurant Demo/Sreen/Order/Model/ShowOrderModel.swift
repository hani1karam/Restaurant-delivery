//
//  ShowOrderModel.swift
//  Restaurant Demo
//
//  Created by hany karam on 8/17/21.
//

import Foundation
struct ShowOrderModel: Codable {
    let status: Bool?
    let error: String?
    let data: [ShowOrderModelDatum]?
}

// MARK: - Datum
struct ShowOrderModelDatum: Codable {
    let id: Int?
    let code, status, date, day: String?
    let dayTitle, hour, minute, format: String?
    let phone, address, shippingPrice, subTotal: String?
    let total: String

    enum CodingKeys: String, CodingKey {
        case id, code, status, date, day
        case dayTitle = "day_title"
        case hour, minute, format, phone, address, shippingPrice, subTotal, total
    }

}

