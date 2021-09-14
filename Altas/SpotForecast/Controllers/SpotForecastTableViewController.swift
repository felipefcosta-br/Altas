//
//  SpotWaveForcastTableViewController.swift
//  Altas
//
//  Created by user198265 on 8/22/21.
//

import UIKit

class SpotForecastTableViewController: UITableViewController {

    @IBOutlet var spotNameLabel: UILabel!
    @IBOutlet var spotCityLabel: UILabel!
    @IBOutlet var waveSizeLabel: UILabel!
    @IBOutlet var swellDirectionLabel: UILabel!
    @IBOutlet var periodLabel: UILabel!
    @IBOutlet var waterTemperatureLabel: UILabel!
    @IBOutlet var windSpeedLabel: UILabel!
    @IBOutlet var windDirectionLabel: UILabel!
    @IBOutlet var highTideLabel: UILabel!    
    @IBOutlet var lowTideLabel: UILabel!
    @IBOutlet var favoriteBarButton: UIBarButtonItem!
    @IBOutlet var highTideStackView: UIStackView!
    @IBOutlet var lowTideStackView: UIStackView!
    
    var isFavorite: Bool = false
    var spotId: String?
    var spot: SpotForecastItem?
    
    let manager = SpotForecastDataManager()
    
    let zeroDigitsFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 0
        return nf
    }()
    
    let oneDigitsFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    let twoDigitsFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 2
        return nf
    }()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupFavoriteBarButton()
        if spot == nil {
            loadSpotForecast()
        }else {
            setupSpotForecast()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
              
    }
    
    private func setupFavoriteBarButton () {
        if isFavorite {
            favoriteBarButton.image = UIImage(systemName: "star.fill")
        }else {
            favoriteBarButton.image = UIImage(systemName: "star")
        }
    }
    
    private func loadSpotForecast(){
        guard let spotId = self.spotId else {
            return
        }
        manager.fetch(by: spotId) {spotItem in
            self.spot = spotItem
            self.setupSpotForecast()
        }
    }
    
    private func setupSpotForecast() {
        guard let spot = self.spot else {
            return
        }
        spotNameLabel.text = spot.name
        spotCityLabel.text = spot.city
        
        let waveHeight = oneDigitsFormatter.string(from: NSNumber(value: spot.waveHeight?.noaa ?? 0.0))
        waveSizeLabel.text = "\(waveHeight!)"
        swellDirectionLabel.text =
            convertDecimalDegreestoCompassPoints(degrees: (spot.swellDirection?.noaa)!)
        
        let wavePeriod = oneDigitsFormatter.string(from: NSNumber(value: spot.wavePeriod?.noaa ?? 0.0))
        periodLabel.text = "\(wavePeriod!)"
        
        let waterTemp = zeroDigitsFormatter.string(from: NSNumber(value: spot.waterTemperature?.noaa ?? 0.0))
        waterTemperatureLabel.text = "\(waterTemp!)"
        
        let windSpeed = oneDigitsFormatter.string(from: NSNumber(value: spot.windSpeed?.noaa ?? 0.0))
        windSpeedLabel.text = "\(windSpeed!)"
        windDirectionLabel.text = convertDecimalDegreestoCompassPoints(degrees: (spot.windDirection?.noaa)!)
        
        spot.highTide?.forEach({ tideItem in
            
            let tide = formatSpotTide(tideItem: tideItem)
            
            let label = UILabel()
            label.textColor = UIColor(named: "darkGray-altas")
            label.numberOfLines = 2
            label.text = tide
            highTideStackView.addArrangedSubview(label)
        })
        
        spot.lowTide?.forEach({ tideItem in
            
            let tide = formatSpotTide(tideItem: tideItem)
            print(tide)
            
            let label = UILabel()
            label.textColor = UIColor(named: "darkGray-altas")
            label.numberOfLines = 2
            label.text = tide
            lowTideStackView.addArrangedSubview(label)
        })
        
        

    }
    
    private func formatSpotTide(tideItem: Tide) -> String{
        guard let tideHeightOpt = tideItem.height,
              let tideTimeOpt = tideItem.time else {
            return ""
        }
        
        let tideHeightDec = twoDigitsFormatter.string(from: NSNumber(value: tideHeightOpt))
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        let dateTide = timeFormatter.date(from: tideTimeOpt)
        
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: dateTide!)
        let minutes = calendar.component(.minute, from: dateTide!)
        
        guard let tideHeight =  Double(tideHeightDec!) else {
            return ""
        }
        
        return "\(tideHeight)m - \(hour):\(minutes)"
        
    }
    
    private func convertDecimalDegreestoCompassPoints(degrees: Double) -> String{
        if degrees >= 337.5 && degrees <= 360 && degrees >= 0 && degrees <= 22.4{
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

    // MARK: - Table view data source
    

}
