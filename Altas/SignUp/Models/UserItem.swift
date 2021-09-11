//
//  UserItem.swift
//  Altas
//
//  Created by user198265 on 9/7/21.
//

import UIKit

struct UserItem: Codable{
    let name: String?
    let email: String?
    let city: String?
    let userId: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case email
        case city
        case userId
    }
}
