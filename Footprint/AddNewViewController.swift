//
//  AddViewController.swift
//  Footprint
//
//  Created by Empower on 01/06/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import UIKit
import MapKit


typealias UserDidSelectLocationClosure = (CLLocation) -> ()

class AddNewViewController: UIViewController, MapManager {
    var locationManager: CLLocationManager = CLLocationManager()
    
    var visibleRegionSize: CGSize = CGSize(width: 100, height: 100)
    
    @IBOutlet weak var tf_title: UITextField!
    @IBOutlet weak var tf_description: UITextField!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var userDidSelectLocationClosure : UserDidSelectLocationClosure?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.isHidden = true
        
        userDidSelectLocationClosure = { (location: CLLocation) in
            self.mapView.isHidden = false
            self.setMapViewLocation(location: location)
        }
    }
    
    
    @IBAction func chooseLocation(_ sender: Any) {
        
        var chooseLocVC : ChooseLocationOnMapViewController!
        if #available(iOS 13.0, *) {
            chooseLocVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ChooseLocationOnMapViewController")
        } else {
            chooseLocVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChooseLocationOnMapViewController") as? ChooseLocationOnMapViewController
        }
        chooseLocVC!.userDidSelectLocationClosure = self.userDidSelectLocationClosure
        chooseLocVC?.modalPresentationStyle = .fullScreen
        self.present(chooseLocVC!, animated: true, completion: nil)
    }
    
    
    func setMapViewLocation(location: CLLocation) {
        centerViewOnLocation(mapView: self.mapView, location: location)
    }
    
    
}
