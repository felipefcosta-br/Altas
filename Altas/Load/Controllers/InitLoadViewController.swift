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
                self.performSegue(withIdentifier: Segue.showLogin.rawValue, sender: self)
            }else{
                self.performSegue(withIdentifier: Segue.showFavoritiesSpots.rawValue, sender: self)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
}
