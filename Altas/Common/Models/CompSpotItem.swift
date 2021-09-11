//
//  CompSpotItem.swift
//  Altas
//
//  Created by user198265 on 9/9/21.
//

import Foundation
class CompSpotItem: NSObject, Codable {
    var id: String!
    var name: String?
    var address: String?
    var city: String?
    var state: String?
    var country: String?
    var coods: String?
    var waveSize: Float?
    var swellDirection: Float?
    var period: Float?
    var waterTemp: Float?
    var windSpeed: Float?
    var windDirection: Float?
    var highTide: Float?
    var lowTide: Float?   
}
