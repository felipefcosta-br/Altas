//
//  LoginManager.swift
//  Altas
//
//  Created by user198265 on 8/23/21.
//

import Foundation
import FirebaseAuth

class LoginManager {
    
    func getUserData(){
        let currentUser = Auth.auth().currentUser
        if let currentUserId = currentUser?.uid{
            
            Altas.UserAPIManager.shared.fetchGetUser(by: currentUserId, completion: { (userResult) in
                switch userResult {
                case let .success(userItem):
                    if let fireUserId = userItem.first?.id{
                        self.saveFireStoreUserId(userId: fireUserId)
                    }
                case let .failure(error):
                   print("Erro - \(error)")
                }                
            })
            
        } else {
            return
        }
        
    }
    
    private func saveFireStoreUserId(userId: String){
        let defaults = UserDefaults.standard
        defaults.set(userId, forKey: Constants.currentUserId.rawValue)
    }
}
