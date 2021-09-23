//
//  CardinalDirectionConverter.swift
//  Altas
//
//  Created by user198265 on 9/19/21.
//

import Foundation

struct CardinalDirectionConverter{
    
    static func convertDecimalDegreestoCardinalDirection(degrees: Double) -> String{
        if (degrees >= 337.5 && degrees <= 360) || (degrees >= 0 && degrees <= 22.4){
            return IntercardinalPoints.N.rawValue
        }else if degrees >= 22.5 && degrees <= 67.4{
            return IntercardinalPoints.NE.rawValue
        }else if degrees >= 67.5 && degrees <= 112.4{
            return IntercardinalPoints.L.rawValue
        }else if degrees >= 112.5 && degrees <= 157.4{
            return IntercardinalPoints.SE.rawValue
        }else if degrees >= 157.5 && degrees <= 202.4{
            return IntercardinalPoints.S.rawValue
        }else if degrees >= 202.5 && degrees <= 247.4{
            return IntercardinalPoints.SO.rawValue
        }else if degrees >= 247.5 && degrees <= 292.4{
            return IntercardinalPoints.O.rawValue
        }else if degrees >= 292.5 && degrees <= 337.4{
            return IntercardinalPoints.NO.rawValue
        }else{
            return "Invalid point"
        }
    }
}
