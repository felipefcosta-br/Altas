//
//  FavoriteSpotAPIManager.swift
//  Altas
//
//  Created by user198265 on 9/15/21.
//

import Foundation

class FavoriteSpotAPIManager {
    
    static let shared: FavoriteSpotAPIManager = {
        let instance = FavoriteSpotAPIManager()
        return instance
    }()
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    func fetchFavoriteSpotBySpotId(by spotId: String, fireUserId: String,
                                   completion: @escaping (Result<[FavoriteSpotItem], Error>) -> Void){
        let param = "\(fireUserId)/\(spotId)"
        let url = APIManager.favoriteSpotURL(with: param)
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            let result = self.processGetFavoriteSpotRequest(data: data, error: error)
            DispatchQueue.main.async {
                completion(result)
            }
        }
        task.resume()
    }
    
    func fetchPostFavoriteSpot(by favoriteSpotItem: FavoriteSpotItem,
                               completion: @escaping (Result<[FavoriteSpotItem], Error>) -> Void) {
        let url = APIManager.favoriteSpotURL()
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let data = prepareFavoriteSpotRequest(favoriteSpot: favoriteSpotItem)
        request.httpBody = data
        
        let task = session.dataTask(with: request) { (data, response, error) in
            let result = self.processPostFavoriteSpotRequest(data: data, error: error)
            DispatchQueue.main.async {
                completion(result)
            }
        }
        task.resume()
    
    }
    
    func fetchDeleteFavoriteSpot(by favoriteSpotId: String, fireUserId: String,
                                 comletion: @escaping (Result<MessageResponseItem, Error>) -> Void){
        let param = "\(fireUserId)/\(favoriteSpotId)"
        let url = APIManager.favoriteSpotURL(with: param)
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let task = session.dataTask(with: request){(data, response, error) in
            let result = self.processDeleteFavoriteSpotRequest(data: data, error: error)
            DispatchQueue.main.async {
                comletion(result)
            }
        }
        task.resume()
        
    }
    
    private func prepareFavoriteSpotRequest(favoriteSpot: FavoriteSpotItem) -> Data? {
        
        let encodeResult = APIManager.encodeFavoriteSpot(toJSON: favoriteSpot)
        
        switch encodeResult {
        case let .success(data):
            return data
            
        case let .failure(error):
            print("Encode fail \(error)")
            return nil
        }
    }
    
    private func processGetFavoriteSpotRequest(data: Data?, error: Error?) -> Result<[FavoriteSpotItem], Error> {
        guard let jsonData = data else {
            return .failure(error!)
        }
        return APIManager.favoriteSpots(fromJSON: jsonData)
    }
    
    private func processPostFavoriteSpotRequest(data: Data?, error: Error?) -> Result<[FavoriteSpotItem], Error> {
        guard let jsonData = data else {
            return .failure(error!)
        }
        return APIManager.postFavoriteSpots(fromJSON: jsonData)
    }
    
    private func processDeleteFavoriteSpotRequest(data: Data?, error: Error?) -> Result<MessageResponseItem, Error> {
        guard let jsonData = data else {
            return .failure(error!)
        }
        return APIManager.deleteFavoriteSpots(fromJSON: jsonData)
    }
    
    
}
