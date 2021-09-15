//
//  FavoriteSpotResponseItem.swift
//  Altas
//
//  Created by user198265 on 9/15/21.
//

import Foundation

struct FavoriteSpotResponseItem: Codable {
    let status: String
    let message: String
    let data: FavoriteSpotItem
    
    enum CodingKeys: CodingKey {
        case status
        case message
        case data
    }
}

