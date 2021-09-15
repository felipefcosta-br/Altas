//
//  FavoriteSpotItem.swift
//  Altas
//
//  Created by user198265 on 9/15/21.
//

import UIKit

struct FavoriteSpotItem: Codable {
    var id: String!
    var spotId: String!
    var fireUserId: String!
    var spotName: String?
    var address: String?
    var city: String?
    var state: String?
    var country: String?
    var coords: Coordinate?
    
    enum CodingKeys: String, CodingKey {
        case id
        case spotId
        case fireUserId
        case spotName
        case address
        case city
        case state
        case country
        case coords
    }
}
