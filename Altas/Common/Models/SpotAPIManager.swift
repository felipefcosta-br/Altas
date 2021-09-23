//
//  SpotAPIManager.swift
//  Altas
//
//  Created by user198265 on 9/9/21.
//

import Foundation
import UIKit

class SpotAPIManager {
    
    static let shared: SpotAPIManager = {
        let instance =  SpotAPIManager()
        return instance
    }()
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    func fetchLocalSpots(geoFilter: String, completion: @escaping (Result<[SpotForecastAnnotationItem], Error>) -> Void){
        let url = APIManager.spotsURL(with: geoFilter)
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            let result = self.processSpotForecastAnnotationRequest(data: data, error: error)
            print("teste spots \(result)")
            completion(result)
        }
        task.resume()
    }
    
    func fetchSearchSpots(by searchText: String, completion: @escaping (Result<[SpotItem], Error>) -> Void){
        let url = APIManager.spotSearchURL(with: searchText)
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            let result = self.processSpotRequest(data: data, error: error)
            completion(result)
        }
        task.resume()
    }
    
    func fetchSearchSpotsCity(by searchText: String, completion: @escaping (Result<[SpotItem], Error>) -> Void){
        let url = APIManager.spotCitySearchURL(with: searchText)
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            let result = self.processSpotRequest(data: data, error: error)
            completion(result)
        }
        task.resume()
    }
    
    func fetchSpot(by spotId: String, completion: @escaping (Result<[SpotForecastItem], Error>) -> Void){
        let url = APIManager.spotURL(with: spotId)
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            let result = self.processSpotForecastRequest(data: data, error: error)
            completion(result)
        }
        task.resume()
    }
    
    private func processSpotRequest(data: Data?, error: Error?) -> Result<[SpotItem], Error> {
        guard let jsonData = data else {
            return .failure(error!)
        }
        return APIManager.spots(fromJSON: jsonData)
    }
    
    private func processSpotForecastRequest(data: Data?, error: Error?) -> Result<[SpotForecastItem], Error>{
        guard let jsonData = data else {
            return . failure(error!)
        }
        return APIManager.spotsForecast(fromJSON: jsonData)
    }
    
    private func processSpotForecastAnnotationRequest(
        data: Data?, error: Error?) -> Result<[SpotForecastAnnotationItem], Error>{
        guard let jsonData = data else {
            return . failure(error!)
        }
        return APIManager.spotsForecastAnnotation(fromJSON: jsonData)
    }
    
}
