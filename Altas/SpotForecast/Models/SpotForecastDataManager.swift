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
    
    func fetchBySpotId(by spotId: String, fireUserId: String,
                       completion: @escaping (FavoriteSpotItem?, Error?) -> Void){
        FavoriteSpotAPIManager.shared.fetchFavoriteSpotBySpotId(
            by: spotId, fireUserId: fireUserId) {
                (favoriteSpotResult) in
            
            switch favoriteSpotResult {
            case let .success(favSpot):
                completion(favSpot.first, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
        
    }
    
    func addFavoriteSpot(spot: SpotForecastItem, userId: String,
                         completion: @escaping (FavoriteSpotItem?, Error?) -> Void){
        
        let favoriteSpot = FavoriteSpotItem(
            spotId: spot.id,
            fireUserId: userId,
            spotName: spot.name,
            address: spot.address,
            city: spot.city,
            state: spot.state,
            country: spot.country,
            coords: spot.coords)
        
        FavoriteSpotAPIManager.shared.fetchPostFavoriteSpot(by: favoriteSpot) {
            (favoriteSpotResult) in
            
            switch favoriteSpotResult {
            case let .success(favSpot):
                completion(favSpot.first, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }
    
    func deleteFavoriteSpot(userId: String, favoriteSpotId: String, completion: @escaping (MessageResponseItem?, Error?) -> Void){
        FavoriteSpotAPIManager.shared.fetchDeleteFavoriteSpot(by: favoriteSpotId, fireUserId: userId) {
            (deleteFavoriteSpotResult) in
            
            switch deleteFavoriteSpotResult {
            case let .success(message):
                completion(message, nil)
            case let .failure(error):
                completion(nil, error)
            }
            
        }
    }
    
    func spotItem() -> SpotForecastItem {
        return spot
    }
}
