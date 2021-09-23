//
//  APIManager.swift
//  Altas
//
//  Created by user198265 on 9/7/21.
//

import Foundation

struct APIManager {
    
    static func userURL(with filter: String? = nil) -> URL{
        return apiURL(endpoint: .user, parameter: filter)
    }
    
    static func spotURL(with filter: String) -> URL{
        return apiURL(endpoint: .spot, parameter: filter)
    }
    
    static func spotsURL(with filter: String? = nil) -> URL{
        return apiURL(endpoint: .spots, parameter: filter)
    }
    
    static func spotSearchURL(with filter: String) -> URL{
        return apiURL(endpoint: .spotSearch, parameter: filter)
    }
    
    static func spotCitySearchURL(with filter: String) -> URL{
        return apiURL(endpoint: .spotCitySearch, parameter: filter)
    }
    
    static func favoriteSpotsURL(with filter: String) -> URL{
        return apiURL(endpoint: .favoriteSpots, parameter: filter)
    }
    
    static func favoriteSpotURL(with filter: String? = nil) -> URL{
        return apiURL(endpoint: .favoriteSpot, parameter: filter)
    }
    
    static func postUser(fromJSON data: Data) -> Result<[UserItem], Error> {
        do {
            let decoder = JSONDecoder()
            let userResponse = try decoder.decode(UserResponseItem.self, from: data)
            
            var userItems: [UserItem] = []
            userItems.append(userResponse.data)
            return .success(userItems)
        } catch {
            return .failure(error)
        }
    }
    
    static func getUser(fromJSON data: Data) -> Result<[UserItem], Error> {
            do {
                let decoder = JSONDecoder()
                let userResponse = try decoder.decode([UserItem].self, from: data)
                return .success(userResponse)
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
    
    static func spotsForecast(fromJSON data: Data) -> Result<[SpotForecastItem], Error> {
        do {
            let decoder = JSONDecoder()
            
            let spotResponse = try decoder.decode([SpotForecastItem].self, from: data)
            return .success(spotResponse)
        } catch {
            return .failure(error)
        }
    }
    
    static func spotsForecastAnnotation(
        fromJSON data: Data) -> Result<[SpotForecastAnnotationItem], Error> {
        do {
            let decoder = JSONDecoder()
            
            let spotResponse = try decoder.decode([SpotForecastAnnotationItem].self, from: data)
            print(spotResponse.first)
            return .success(spotResponse)
        } catch {
            return .failure(error)
        }
    }

    
    static func postFavoriteSpots(fromJSON data: Data) -> Result<[FavoriteSpotItem], Error> {
        do {
            let decoder = JSONDecoder()
            let favoriteSpotsResponse = try decoder.decode(FavoriteSpotResponseItem.self, from: data)
            
            var favoriteSpotItem: [FavoriteSpotItem] = []
            favoriteSpotItem.append(favoriteSpotsResponse.data)
            return .success(favoriteSpotItem)
        }catch {
            return .failure(error)
        }
    }
    
    static func favoriteSpots(fromJSON data: Data) -> Result<[FavoriteSpotItem], Error> {
        do {
            let decoder = JSONDecoder()
            let favoriteSpotsResponse = try decoder.decode([FavoriteSpotItem].self, from: data)
            return .success(favoriteSpotsResponse)
        }catch {
            return .failure(error)
        }
    }
    
    static func favoriteSpotsForecast(fromJSON data: Data) -> Result<[FavoriteSpotForecastItem], Error> {
        do {
            let decoder = JSONDecoder()
            let favoriteSpotsResponse = try decoder.decode([FavoriteSpotForecastItem].self, from: data)
            return .success(favoriteSpotsResponse)
        }catch {
            return .failure(error)
        }
    }
    
    static func deleteFavoriteSpots(fromJSON data: Data) -> Result<MessageResponseItem, Error> {
        do {
            let decoder = JSONDecoder()
            
            if let JSONString = String(data: data, encoding: String.Encoding.utf8) {
               print(JSONString)
            }
            let deletefavoriteSpotsResponse = try decoder.decode(MessageResponseItem.self, from: data)
            return .success(deletefavoriteSpotsResponse)
        }catch {
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
    
    static func encodeFavoriteSpot(toJSON favoriteSpot: FavoriteSpotItem) -> Result<Data, Error> {
        do {
            let encoder = JSONEncoder()
            let dataResponse = try encoder.encode(favoriteSpot)
            return .success(dataResponse)
        }catch {
            return .failure(error)
        }
    }
    
    private static func apiURL(endpoint: Endpoint, parameter: String? = nil) -> URL{
        
        var components = URLComponents(string: Constants.baseURL.rawValue)!
        if let aditionalParameter = parameter {
            components.path = endpoint.rawValue + aditionalParameter
        }else {
            components.path = endpoint.rawValue
        }       
        
        print("URL teste \(components.url!)")
        return components.url!
        
    }
}
