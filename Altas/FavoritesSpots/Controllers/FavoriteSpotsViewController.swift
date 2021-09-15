//
//  FavoritesSpotsViewController.swift
//  Altas
//
//  Created by user198265 on 9/2/21.
//

import UIKit
import FirebaseAuth

class FavoriteSpotsViewController: UIViewController {

    @IBOutlet var favoritesSpotsTableView: UITableView!
    var handle: AuthStateDidChangeListenerHandle!
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
        let currentUser = Auth.auth().currentUser
        currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
            if error != nil {
                self.signOut()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}
// MARK: - Private Extension
private extension FavoriteSpotsViewController{
    func initialize(){
        setupBarButtons()
        loadFavoritesSpots()
    }
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
    func loadFavoritesSpots(){
        let view = NoDataView(frame: CGRect(x: 0,
                                            y: 0,
                                            width: self.favoritesSpotsTableView.frame.width,
                                            height: self.favoritesSpotsTableView.frame.height))
        
        view.set(message: "Your favorities spots will be show here. After search add a spot as favorite.")
        
        self.favoritesSpotsTableView.tableFooterView = UIView()
        
        self.favoritesSpotsTableView.backgroundView = view
    }
}

// MARK: - UITableViewDataSource
extension FavoriteSpotsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "spotCell", for: indexPath)
        
        return cell
    }
    
    
    
    
}
