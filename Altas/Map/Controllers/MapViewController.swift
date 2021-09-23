//
//  MapViewController.swift
//  Altas
//
//  Created by user198265 on 9/16/21.
//

import UIKit
import MapKit
import CoreLocation
import FirebaseAuth

class MapViewController: UIViewController {
    
    @IBOutlet var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    let manager = MapDataManager()
    var selectedSpot: SpotForecastAnnotationItem?
    let distanceKM = 500

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case Segue.showSpotFromMap.rawValue:
            showSpotDetail(segue: segue)
        default:
            print("Segue não encontrado")
        }
    }
    


}
// MARK: - Private Extension
private extension MapViewController {
    func initialize(){
        setupBarButtons()
        checkLocationPermission { isGranted in
            if isGranted{
                //self.manager.fetch { self.addMapSpotAnnotations($0) }
                self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                self.locationManager.distanceFilter = kCLDistanceFilterNone
                self.locationManager.startUpdatingLocation()
                if let userCoord = self.mapView.userLocation.location?.coordinate{
                    self.mapView.setCenter(userCoord, animated: true)
                }
                
            }
        }
        
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
            UserDefaults.standard.removeObject(forKey: Constants.currentUserId.rawValue)
        } catch {
            print("Sign out error")
        }
    }
    
    func addMapSpotAnnotations(_ annotations: [SpotForecastAnnotationItem]) {
        mapView.addAnnotations(annotations)
    }
    
    func showSpotDetail(segue: UIStoryboardSegue) {
        if let viewController = segue.destination as? SpotForecastTableViewController,
           let spot = selectedSpot {
            viewController.spotId = spot.id
        }
    }
    
    func checkLocationPermission(completion: @escaping (_ isGranted: Bool) -> Void) {
        
        switch self.locationManager.authorizationStatus {
        case .denied:
            completion(false)
            break
        case .authorizedAlways, .authorizedWhenInUse:
            completion(true)
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()

        default:
        fatalError("Status não identificado")
        }
    }
    
    func startFetchSpots(latitude: Double, longitude: Double){
        
        var geoParam = "\(latitude)/"
        geoParam = geoParam.appending(String(longitude))
        geoParam = geoParam.appending("/")
        geoParam = geoParam.appending(String(distanceKM))
        manager.fetch(geoFilter: geoParam) { self.addMapSpotAnnotations($0)}
    }
}
// MARK: - MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView,
                 viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !annotation.isKind(of: MKUserLocation.self) else {
            return nil
        }
        
        let identifier = "spotPin"
        var annotationView: MKAnnotationView?
        
        if let customAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier){
            annotationView = customAnnotationView
            annotationView?.annotation = annotation
        }else {
            let newAnnotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            newAnnotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            annotationView = newAnnotationView
        }
        
        if let annotationView = annotationView {
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "spot-annotation")
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView,
                 annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = mapView.selectedAnnotations.first else {
            return
        }
        
        selectedSpot = annotation as? SpotForecastAnnotationItem
        self.performSegue(withIdentifier: Segue.showSpotFromMap.rawValue, sender: self)
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = mapView.center
        let centerCoord = mapView.convert(center, toCoordinateFrom: mapView)
        startFetchSpots(latitude: centerCoord.latitude, longitude: centerCoord.longitude)
        
        
    }
}
