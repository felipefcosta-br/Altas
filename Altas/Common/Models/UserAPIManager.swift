//
//  UserAPIManager.swift
//  Altas
//
//  Created by user198265 on 9/7/21.
//

import Foundation
import UIKit

class UserAPIManager {
    
    static let shared: UserAPIManager = {
        let instance = UserAPIManager()
        return instance
    }()
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    func fetchGetUser(by filter: String, completion: @escaping (Result<[UserItem], Error>) -> Void){
        let url = APIManager.userURL(with: filter)
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) {(data, response, error) in
        
        }
        task.resume()
    }
    
    func fetchPostUser(by user: UserItem, completion: @escaping (Result<[UserItem], Error>) -> Void){
        
        let url = APIManager.userURL()
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let data = prepareUserRequest(user: user)
        request.httpBody = data
        
        let task = session.dataTask(with: request){(data, response, error) in
            let result = self.processUserRequest(data: data, error: error)
            DispatchQueue.main.async {
                completion(result)
            }            
        }
        task.resume()
    }
    
    private func prepareUserRequest(user: UserItem) -> Data? {
        
        let encodeResult = APIManager.encodeUser(toJSON: user)
        
        switch encodeResult {
        case let .success(data):
            return data
            
        case let .failure(error):
            print("Encode fail \(error)")
            return nil
        }
    }
    
    private func processUserRequest(data: Data?, error: Error?) -> Result<[UserItem], Error> {
        guard let jsonData = data else {
            return .failure(error!)
        }
        
        return APIManager.user(fromJSON: jsonData)
    }
    
}
