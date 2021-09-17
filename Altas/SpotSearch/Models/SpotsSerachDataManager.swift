//
//  SpotsSerachDataManager.swift
//  Altas
//
//  Created by user198265 on 9/9/21.
//

import Foundation

class SpotsSerachDataManager {
    
    fileprivate var items: [SpotItem] = []
    
    func fetchSearchBySpotName(by searchText: String, completion: @escaping (_ item:[SpotItem]) -> Void){
        SpotAPIManager.shared.fetchSearchSpots(by: searchText) {
            (spotSearchResult) in
            switch spotSearchResult {
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
    
    func fetchSearchByCity(by searchText: String, completion: @escaping (_ item:[SpotItem]) -> Void){
        SpotAPIManager.shared.fetchSearchSpotsCity(by: searchText) {
            (spotSearchResult) in
            switch spotSearchResult {
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
    
    
    
    func numberOfItems() -> Int {
        return items.count
    }
    func spotsItem(at index: IndexPath) -> SpotItem {
        return items[index.item]
    }
}
