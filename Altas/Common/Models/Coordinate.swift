//
//  Coordinate.swift
//  Altas
//
//  Created by user198265 on 9/12/21.
//

import Foundation

struct Coordinate: Codable {
    var latitude: Double?
    var longitude: Double?
    
    enum CodingKeys: String, CodingKey {
        case latitude = "_latitude"
        case longitude = "_longitude"
    }
}
