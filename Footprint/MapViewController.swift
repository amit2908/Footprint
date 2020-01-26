//
//  ViewController.swift
//  Footprint
//
//  Created by Empower on 31/05/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MapManager {
    
    var visibleRegionSize: CGSize = CGSize(width: 500, height: 500)
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.checkLocationServices(mapView: mapView)
    }
    
    //IBActions
    @IBAction func showCurrentLocation(_ sender: Any) {
        centerViewOnUserLocation(mapView: mapView)
    }
    
    @IBAction func addItem(_ sender: UIButton) {
        var addNewViewController : UIViewController!
        if #available(iOS 13.0, *) {
            addNewViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "AddNewViewController", creator: nil)
        } else {
            // Fallback on earlier versions
            addNewViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddNewViewController")
        }
        self.navigationController?.pushViewController(addNewViewController, animated: true)
    }


}

extension MapViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
}

extension MapViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        return nil
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("Clicked Annotation Title", view.annotation?.title)
    }
}
