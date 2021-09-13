//
//  CompSpotItem.swift
//  Altas
//
//  Created by user198265 on 9/9/21.
//

import Foundation
struct SpotForecastItem: Codable {
    var id: String!
    var name: String?
    var address: String?
    var city: String?
    var state: String?
    var country: String?
    var coords: Coordinate?
    var waveHeight: BaseForecast?
    var swellDirection: BaseForecast?
    var wavePeriod: BaseForecast?
    var waterTemperature: BaseForecast?
    var windSpeed: BaseForecast?
    var windDirection: BaseForecast?
    var highTide: [Tide]?
    var lowTide: [Tide]?    
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
