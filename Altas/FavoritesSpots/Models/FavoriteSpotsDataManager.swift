//
//  FavoriteSpotsDataManager.swift
//  Altas
//
//  Created by user198265 on 9/16/21.
//

import Foundation

class FavoriteSpotsDataManager{  
    
    fileprivate var items: [FavoriteSpotForecastItem] = []
    
    func fetch(completion: @escaping (_ favoriteSpots:[FavoriteSpotForecastItem]) -> Void){
        
        let defaults = UserDefaults.standard
        if let fireUserId = defaults.string(forKey: Constants.currentUserId.rawValue){
            FavoriteSpotAPIManager.shared.fetchUserFavoriteSpots(by: fireUserId) {
                (favoriteSpotsResult) in
                
                switch favoriteSpotsResult {
                case let .success(favoriteSpots):
                    self.items = favoriteSpots
                case let .failure(error):
                    print("Erro ao buscar favoritos: \(error)")
                }
                DispatchQueue.main.async {
                    completion(self.items)
                }
            }
            
        }
        
    }
    func numberOfItems() -> Int {
        return items.count
    }
    func favoriteSpotsItem(at index: IndexPath) -> FavoriteSpotForecastItem {
        return items[index.item]
    }
}
