//
//  RegisterModel.swift
//  Restaurant Demo
//
//  Created by hany karam on 8/13/21.
//

import Foundation
// MARK: - RegisterModel
struct RegisterModel: Codable {
    let status: Bool?
    let error: String?
    let data: RegisterModelDataClass?
}

// MARK: - DataClass
struct RegisterModelDataClass: Codable {
    let email, name, phone, address: String?
    let updatedAt, createdAt: String?
    let id: Int?
    
    enum CodingKeys: String, CodingKey {
        case email, name, phone, address
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id
    }
}
