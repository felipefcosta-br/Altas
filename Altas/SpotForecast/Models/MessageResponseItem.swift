//
//  MessageItem.swift
//  Altas
//
//  Created by user198265 on 9/15/21.
//

import Foundation
struct MessageResponseItem: Codable {
    let status: String
    let message: String
    
    enum CodingKeys: CodingKey {
        case status
        case message
    }
}
