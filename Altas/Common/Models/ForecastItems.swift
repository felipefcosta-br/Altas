//
//  ForecastItems.swift
//  Altas
//
//  Created by user198265 on 9/16/21.
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
struct BaseForecast: Codable {
    var dwd: Double?
    var fcoo: Double?
    var icon: Double?
    var meteo: Double?
    var noaa: Double?
    var sg: Double?
}

struct Tide: Codable {
    var height: Double?
    var time: String?
    var type: String?
}
