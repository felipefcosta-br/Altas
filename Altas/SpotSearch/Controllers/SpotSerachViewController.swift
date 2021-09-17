//
//  SpotSerachViewController.swift
//  Altas
//
//  Created by Felipe F. da Costa on 8/17/21.
//

import UIKit
import FirebaseAuth

class SpotSerachViewController: UIViewController {

    @IBOutlet var resultTableView: UITableView!
    @IBOutlet var spotSearchBar: UISearchBar!
    @IBOutlet var searchOpSegmentedControl: UISegmentedControl!
    
    let manager = SpotsSerachDataManager()
    // let searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.spotSearchBar.delegate = self
        setupBarButtons()
        setupSearchBar()
        setSearchSpotXIB(message: "Find your spots")
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //searchController.searchResultsUpdater = self
        //navigationItem.searchController = searchController
        let titleSegementeAtt = [NSAttributedString.Key.foregroundColor: UIColor(named: "light-gray-altas")]
        searchOpSegmentedControl.setTitleTextAttributes(titleSegementeAtt as [NSAttributedString.Key : Any], for: .selected)
        searchOpSegmentedControl.setTitleTextAttributes(titleSegementeAtt as [NSAttributedString.Key : Any], for: .normal)
    }
    
    @IBAction func searchOpChange(_ sender: UISegmentedControl) {
        guard let searchText = spotSearchBar.searchTextField.text,
              !searchText.isEmpty else {
            return
        }
        switch sender.selectedSegmentIndex.self {
        case 0:
            loadSpotNameSearch(searchText: searchText)
        case 1:
            loadCitySearch(searchText: searchText)
        default:
            print("Erro na opção \(sender.selectedSegmentIndex.self)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Segue.showSpotFromSearch.rawValue:
            if let indexPath = resultTableView.indexPathForSelectedRow {
                let spot = manager.spotsItem(at: indexPath)
                let spotForecast = segue.destination as! SpotForecastTableViewController
                spotForecast.spotId = spot.id
            }
        default:
            preconditionFailure("Segue identifier is not valid")
        }
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
}

// MARK: - Private Extansion
private extension SpotSerachViewController {
    func setupBarButtons(){
        let mainMenu = UIMenu(title: "", children: [
            UIAction(title: "Sign Out", image: UIImage(named: "logout")){ action in
                self.signOut()
            }
        ])
        
        let leftNavButton = UIBarButtonItem(image: UIImage(named: "menu"), menu: mainMenu)
        navigationItem.leftBarButtonItem = leftNavButton
    }
    
    func setupSearchBar(){
        let glassIconView = spotSearchBar.searchTextField.leftView as! UIImageView
        glassIconView.tintColor = UIColor(named: "darkBlue-altas")
        
        let searchTextField = spotSearchBar.searchTextField
        searchTextField.textColor = UIColor(named: "light-gray-altas")
        searchTextField.backgroundColor = UIColor(named: "blue-altas")
        searchTextField.clearButtonMode = .never
        
        //spotSearchBar.showsCancel
    }
    
    func signOut(){
        do {
            try Auth.auth().signOut()
            UserDefaults.standard.removeObject(forKey: Constants.currentUserId.rawValue)
        } catch {
            print("Sign out error")
        }
    }
    
    func loadSpotNameSearch(searchText: String){
        manager.fetchSearchBySpotName(by: searchText) { _ in
            
            if self.manager.numberOfItems() > 0 {
                self.resultTableView.backgroundView = nil
            }else{
                self.setSearchSpotXIB(message: "Your search did not match any Spot!")
            }
            
            self.resultTableView.reloadData()
        }
    }
    
    func loadCitySearch(searchText: String){
        manager.fetchSearchByCity(by: searchText) { _ in
            
            if self.manager.numberOfItems() > 0 {
                self.resultTableView.backgroundView = nil
            }else{
                self.setSearchSpotXIB(message: "Your search did not match any Spot!")
            }
            
            self.resultTableView.reloadData()
        }
    }
    
    func setSearchSpotXIB(message: String){
        let view = NoDataView(frame: CGRect(x: 0,
                                            y: 0,
                                            width: self.resultTableView.frame.width,
                                            height: self.resultTableView.frame.height))
        view.set(message: message)
        self.resultTableView.tableFooterView = UIView()
        self.resultTableView.backgroundView = view
    }
}

// MARK: - UITableViewDataSource
extension SpotSerachViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "searchResultCell"
        let item = manager.spotsItem(at: indexPath)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! SpotSearchedCell
        
        cell.spotNameLabel.text = item.name
        cell.spotCityLabel.text = item.city
        
        return cell
    }
    
    
}

// MARK: - UISearchBarDelegate, UISearchResultsUpdating
extension SpotSerachViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchText = searchBar.text,
              !searchText.isEmpty else {
            return
        }
        
        if searchOpSegmentedControl.selectedSegmentIndex.self == 0 {
            self.loadSpotNameSearch(searchText: searchText)
        }else {
            self.loadCitySearch(searchText: searchText)
        }
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
    }
}
