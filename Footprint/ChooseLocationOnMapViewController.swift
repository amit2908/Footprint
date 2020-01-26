//
//  ChooseLocationOnMapViewController.swift
//  Footprint
//
//  Created by Empower on 03/06/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import UIKit
import MapKit

class ChooseLocationOnMapViewController: UIViewController, MapManager {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tf_search: UITextField!
    
    var locationManager: CLLocationManager = CLLocationManager()
    
    var visibleRegionSize: CGSize = CGSize(width: 100, height: 100)
    var previousLocation : CLLocation = CLLocation()
    
    var userDidSelectLocationClosure: UserDidSelectLocationClosure?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkLocationServices(mapView: mapView) {  //success
            self.centerViewOnUserLocation(mapView: self.mapView)
            self.dismiss(animated: true)
        }
    }
    
    @IBAction func close(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneBtnAction(_ sender: UIButton) {
//        let location = mapView.convert(self.view.center, toCoordinateFrom: mapView)
        
        let location = getCenterLocation(mapView: mapView)
        print("Lat:  ",location.coordinate.latitude)
        print("Long:  ",location.coordinate.longitude)
        self.userDidSelectLocationClosure?(location)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print(location)
        }
    }
    
}

extension ChooseLocationOnMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = getCenterLocation(mapView: mapView)
        let geoCoder = CLGeocoder()
        
        guard center.distance(from: previousLocation) > 50 else { return }
        
        geoCoder.reverseGeocodeLocation(center) { (placemarks, error) in
            if let error = error {
                print(error)
            }
            
            if let placemark = placemarks?.first {
                DispatchQueue.main.async {
                    let address = String(format: "%@, %@, %@, %@",  placemark.name ?? "", placemark.subLocality ?? "", placemark.locality ?? "", placemark.country ?? "")
                    self.tf_search.text = address
                }
            }
        }
    }
}
