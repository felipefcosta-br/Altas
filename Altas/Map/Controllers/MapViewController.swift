//
//  MapViewController.swift
//  Altas
//
//  Created by user198265 on 9/16/21.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet var mapView: MKMapView!
    
    let manager = MapDataManager()
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    


}
// MARK: - Private Extension
private extension MapViewController {
    func initialize(){
        manager.fetch { self.addMapSpotAnnotations($0) }
    }
    func addMapSpotAnnotations(_ annotations: [SpotForecastAnnotationItem]) {
        mapView.addAnnotations(annotations)
        
    }
}
// MARK: - MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView,
                 viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        <#code#>
    }
    
    func mapView(_ mapView: MKMapView,
                 annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        <#code#>
    }
    
}
