//
//  SpotForecastDataManager.swift
//  Altas
//
//  Created by user198265 on 9/12/21.
//

import Foundation

class SpotForecastDataManager{
    
    fileprivate var spot: SpotForecastItem!
    
    func fetch(by spotId: String, completion: @escaping (_ item: SpotForecastItem) -> Void){
        SpotAPIManager.shared.fetchSpot(by: spotId) {
            (spotResult) in
            switch spotResult {
            case let .success(spot):
                self.spot = spot.first
            case let .failure(error):
                print("Erro na pesquisa: \(error)")
            }
            DispatchQueue.main.async {
                completion(self.spot)
            }
        }
    }
    
    func spotItem() -> SpotForecastItem {
        return spot
    }
}
