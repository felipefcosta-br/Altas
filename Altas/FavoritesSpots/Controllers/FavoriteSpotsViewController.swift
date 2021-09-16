//
//  FavoritesSpotsViewController.swift
//  Altas
//
//  Created by user198265 on 9/2/21.
//

import UIKit
import FirebaseAuth

class FavoriteSpotsViewController: UIViewController {
    
    let manager = FavoriteSpotsDataManager()
    
    let oneDigitsFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()

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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Segue.showFavoriteSpotDetail.rawValue:
            if let indexPath = favoritesSpotsTableView.indexPathForSelectedRow {
                let favoriteSpot = manager.favoriteSpotsItem(at: indexPath)
                let spotForecast = segue.destination as! SpotForecastTableViewController
                spotForecast.isFavorite = true
                spotForecast.favoriteId = favoriteSpot.id
                spotForecast.spot = convertFavoriteToSpot(favorite: favoriteSpot)
                
            }
        default:
            preconditionFailure("Segue identifier is not valid")
        }
    }
    
    func convertFavoriteToSpot(favorite: FavoriteSpotForecastItem) -> SpotForecastItem{
        var spot = SpotForecastItem()
        spot.id = favorite.spotId
        spot.name = favorite.spotName
        spot.address = favorite.address
        spot.city = favorite.city
        spot.state = favorite.state
        spot.country = favorite.country
        spot.coords = favorite.coords
        spot.waveHeight = favorite.waveHeight
        spot.swellDirection = favorite.swellDirection
        spot.wavePeriod = favorite.wavePeriod
        spot.waterTemperature = favorite.waterTemperature
        spot.windSpeed = favorite.windSpeed
        spot.windDirection = favorite.windDirection
        spot.highTide = favorite.highTide
        spot.lowTide = favorite.lowTide
        return spot
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
        manager.fetch { _ in
            if self.manager.numberOfItems() > 0 {
                self.favoritesSpotsTableView.backgroundView = nil
            }else {
                self.showNoFavoriteSpotsXib()
            }
            self.favoritesSpotsTableView.reloadData()
        }

    }
    
    private func showNoFavoriteSpotsXib(){
        let view = NoDataView(frame: CGRect(x: 0,
                                            y: 0,
                                            width: self.favoritesSpotsTableView.frame.width,
                                            height: self.favoritesSpotsTableView.frame.height))
        
        view.set(message: "Your favorities spots will be show here. After search add a spot as favorite.")
        
        self.favoritesSpotsTableView.tableFooterView = UIView()
        
        self.favoritesSpotsTableView.backgroundView = view
    }
    
    private func convertDecimalDegreestoCompassPoints(degrees: Double) -> String{
        if (degrees >= 337.5 && degrees <= 360) || (degrees >= 0 && degrees <= 22.4){
            return IntercardinalPoints.N.rawValue
        }else if degrees >= 22.5 && degrees <= 67.4{
            return IntercardinalPoints.NE.rawValue
        }else if degrees >= 67.5 && degrees <= 112.4{
            return IntercardinalPoints.L.rawValue
        }else if degrees >= 112.5 && degrees <= 157.4{
            return IntercardinalPoints.SE.rawValue
        }else if degrees >= 157.5 && degrees <= 202.4{
            return IntercardinalPoints.S.rawValue
        }else if degrees >= 202.5 && degrees <= 247.4{
            return IntercardinalPoints.SO.rawValue
        }else if degrees >= 247.5 && degrees <= 292.4{
            return IntercardinalPoints.O.rawValue
        }else if degrees >= 292.5 && degrees <= 337.4{
            return IntercardinalPoints.NO.rawValue
        }else{
            return "Invalid point"
        }
    }
}

// MARK: - UITableViewDataSource
extension FavoriteSpotsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "favoriteSpotCell"
        let item = manager.favoriteSpotsItem(at: indexPath)
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: identifier, for: indexPath) as! FavoriteSpotTableViewCell
        cell.spotNameLabel.text = item.spotName
        let waveHeight = oneDigitsFormatter.string(from: NSNumber(value: item.waveHeight?.noaa ?? 0.0))
        cell.waveSizeLabel.text = "\(waveHeight!)m"
        
        cell.swellDirectionLabel.text =
            self.convertDecimalDegreestoCompassPoints(degrees: item.swellDirection?.noaa ?? 180)
        cell.windDirectionLabel.text =
            self.convertDecimalDegreestoCompassPoints(degrees: item.windDirection?.noaa ?? 180)        
        
        return cell
    }
    
    
    
    
}
