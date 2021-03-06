//
//  InitLoadViewController.swift
//  Altas
//
//  Created by user198265 on 8/27/21.
//

import UIKit
import FirebaseAuth

class InitLoadViewController: UIViewController {
    
    var handle: AuthStateDidChangeListenerHandle!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        handle = Auth.auth().addStateDidChangeListener{ auth, user in
            if user == nil{
                UserDefaults.standard.removeObject(forKey: Constants.currentUserId.rawValue)
                self.performSegue(withIdentifier: Segue.showLogin.rawValue, sender: self)
            }else{
                self.performSegue(withIdentifier: Segue.showFavoriteSpots.rawValue, sender: self)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
}
