//
//  SpotForecastAnnotationItem.swift
//  Altas
//
//  Created by user198265 on 9/16/21.
//

import Foundation
import MapKit

class SpotForecastAnnotationItem: NSObject, Codable, MKAnnotation {
    
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
    
    var coordinate: CLLocationCoordinate2D {
        guard let lat = coords?.latitude,
              let long = coords?.longitude else {
            return CLLocationCoordinate2D()
        }
        
        return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
    
    var title: String? {
        return name
    }
    
    var subtitle: String? {
        let oneDigitsFormatter: NumberFormatter = {
            let nf = NumberFormatter()
            nf.numberStyle = .decimal
            nf.minimumFractionDigits = 0
            nf.maximumFractionDigits = 1
            return nf
        }()
        let waveH =  "\(oneDigitsFormatter.string(from: NSNumber(value: waveHeight?.noaa ?? 0.0))!)m"
        return waveH
    }
    
}
