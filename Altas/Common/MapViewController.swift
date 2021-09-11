//
//  MapViewController.swift
//  Altas
//
//  Created by user198265 on 8/22/21.
//

import UIKit
import FirebaseAuth

class MapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBarButtons()

        // Do any additional setup after loading the view.
    }

}
//MARK: - Private Extension
private extension MapViewController{
    func setupBarButtons(){
        let mainMenu = UIMenu(title: "", children: [
            UIAction(title: "Sign Out", image: UIImage(named: "logout")){ action in
                self.signOut()
            }
        ])
        
        let leftNavButton = UIBarButtonItem(image: UIImage(named: "menu"), menu: mainMenu)
        navigationItem.leftBarButtonItem = leftNavButton
    }
    
    func signOut(){
        do {
            try Auth.auth().signOut()
        } catch {
            print("Sign out error")
        }
    }
}
