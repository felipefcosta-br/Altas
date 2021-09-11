//
//  Validator.swift
//  Altas
//
//  Created by user198265 on 8/18/21.
//

import Foundation

struct Validator {
    
    static func isNotEmpty(_ value:String) ->Bool{
        
        return !value.isEmpty
    }
    
    static func isValidEmail(_ email:String) ->Bool{
        
        let emailRegex  = "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: email)
    }
    
    static func passwordMatch(password:String, passwordConfirmation:String) -> Bool {
        password == passwordConfirmation
        
    }
    
    static func isValidPassword(password:String) -> Bool{
    
        //let passwordRegex = "^.*(?=.{6,})(?=.*[A-Z])(?=.*[a-zA-Z])(?=.*\\d)|(?=.*[!#$%&?]).*$"
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{8,}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return predicate.evaluate(with: password)
    }
}
