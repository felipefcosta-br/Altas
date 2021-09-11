//
//  SignupManager.swift
//  Altas
//
//  Created by user198265 on 8/19/21.
//

import Foundation
import FirebaseAuth

class SignupManager {
    
    func createAppuser(name: String, email: String, city: String, password: String, completion: @escaping (UserItem?, Error?) -> Void) {
        
        Auth.auth().createUser(withEmail: email , password: password ) { authResult, error in
            if let error = error {
                completion(nil, error)
            }else{
                guard let userId = authResult?.user.uid else { return }
                let user = UserItem(name: name, email: email, city: city, userId: userId)
                
                UserAPIManager.shared.fetchPostUser(by: user) {
                    (userResult) in
                    
                    switch userResult {
                    case let .success(user):
                        completion(user.first, nil)
                    case let .failure(error):
                        completion(nil, error)
                    }
                    
                }
                
            }
        }
    }
}
