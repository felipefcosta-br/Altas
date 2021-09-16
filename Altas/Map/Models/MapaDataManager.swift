//
//  MapaDataManager.swift
//  Altas
//
//  Created by user198265 on 9/16/21.
//

import Foundation

class MapDataManager {
    
    fileprivate var items: [SpotForecastAnnotationItem] = []
    
    var annotations: [SpotForecastAnnotationItem] {
        return items
    }
    
    func fetch(completion: @escaping (_ item: [SpotForecastAnnotationItem]) -> Void){
        SpotAPIManager.shared.fetchAllSpots() {
            (spotResult) in
            switch spotResult {
            case let .success(spots):
                self.items = spots
            case let .failure(error):
                print("Erro na pesquisa: \(error)")
            }
            DispatchQueue.main.async {
                completion(self.items)
            }
        }
    }
}
