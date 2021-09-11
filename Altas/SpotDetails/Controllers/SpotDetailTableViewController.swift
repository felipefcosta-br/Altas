//
//  SpotWaveForcastTableViewController.swift
//  Altas
//
//  Created by user198265 on 8/22/21.
//

import UIKit

class SpotDetailTableViewController: UITableViewController {

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
    
    var isComplete: Bool = false
    var isFavorite: Bool = false
    var spot: CompSpotItem?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    

}
