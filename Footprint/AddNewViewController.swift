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
    
    let MARKER_HEIGHT : CGFloat = 20.0
    
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
        setMarkerOnMapView()
        centerViewOnLocation(mapView: self.mapView, location: location)
    }
    
    private func setMarkerOnMapView(){
        let image = UIImage(named: "marker")
        let imgVMarker = UIImageView(image: image)
        let mapViewBounds = self.mapView.bounds
        let x = CGFloat(mapViewBounds.origin.x) + CGFloat(mapViewBounds.size.width/2) - MARKER_HEIGHT/2
        let y = CGFloat(mapViewBounds.origin.y) + CGFloat(mapViewBounds.size.height/2) - MARKER_HEIGHT/2
        imgVMarker.frame.origin = CGPoint(x:x , y: y)
        imgVMarker.frame.size = CGSize(width: MARKER_HEIGHT, height: MARKER_HEIGHT)
        self.mapView.addSubview(imgVMarker)
    }
    
    
}
