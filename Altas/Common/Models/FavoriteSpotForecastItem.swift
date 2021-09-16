//
//  FavoriteSpotForecastItem.swift
//  Altas
//
//  Created by user198265 on 9/16/21.
//

import Foundation

struct FavoriteSpotForecastItem: Codable {
    var id: String!
    var fireUserId: String!
    var spotId: String!
    var spotName: String?
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
