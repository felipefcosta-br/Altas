//
//  UserItem.swift
//  Altas
//
//  Created by user198265 on 9/7/21.
//

import UIKit

struct UserItem: Codable{
    let id: String?
    let name: String?
    let email: String?
    let city: String?
    let authUserId: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case city
        case authUserId
    }
}
