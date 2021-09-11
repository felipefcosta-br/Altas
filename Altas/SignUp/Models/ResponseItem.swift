//
//  ResponseItem.swift
//  Altas
//
//  Created by user198265 on 9/8/21.
//

import Foundation

struct ResponseItem: Codable {
    let status: String
    let message: String
    let data: UserItem
    
    enum CodingKeys: CodingKey {
        case status
        case message
        case data
    }
}
