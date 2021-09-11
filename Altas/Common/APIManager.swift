//
//  APIManager.swift
//  Altas
//
//  Created by user198265 on 9/7/21.
//

import Foundation

struct APIManager {
    private static let baseURL: String = "https://us-central1-altas-50346.cloudfunctions.net"
    
    static func userURL(with filter: String? = nil) -> URL{
        return apiURL(endpoint: .user, parameter: filter)
    }
    
    static func spotURL(with filter: String) -> URL{
        return apiURL(endpoint: .spot, parameter: filter)
    }
    
    static func spotSearchURL(with filter: String) -> URL{
        return apiURL(endpoint: .spotSearch, parameter: filter)
    }
    
    static func favoritesURL(with filter: String) -> URL{
        return apiURL(endpoint: .favorites, parameter: filter)
    }
    
    static func user(fromJSON data: Data) -> Result<[UserItem], Error> {
        do {
            let decoder = JSONDecoder()
            let userResponse = try decoder.decode(ResponseItem.self, from: data)
            var userItems: [UserItem] = []
            userItems.append(userResponse.data)
            return .success(userItems)
        } catch {
            return .failure(error)
        }
    }
    
    static func encodeUser(toJSON user: UserItem) -> Result<Data, Error> {
        do {
            let encoder = JSONEncoder()
            let dataResponse = try encoder.encode(user)
            return .success(dataResponse)
        } catch {
            return .failure(error)
        }
    }
    
    static func spots(fromJSON data: Data) -> Result<[SpotItem], Error> {
        do {
            let decoder = JSONDecoder()
            let spotResponse = try decoder.decode([SpotItem].self, from: data)
            return .success(spotResponse)
        } catch {
            return .failure(error)
        }
    }
    
    private static func apiURL(endpoint: Endpoint, parameter: String? = nil) -> URL{
        
        var components = URLComponents(string: baseURL)!
        if let aditionalParameter = parameter {
            components.path = endpoint.rawValue + aditionalParameter
        }else {
            components.path = endpoint.rawValue
        }       
        
        print("URL teste \(components.url!)")
        return components.url!
        
    }
}
