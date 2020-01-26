//
//  MapManager.swift
//  Footprint
//
//  Created by Empower on 03/06/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import Foundation
import MapKit

protocol MapManager : CLLocationManagerDelegate {
    var locationManager: CLLocationManager { get }
    var visibleRegionSize : CGSize { get set }
}

extension MapManager {
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationAuthorization(mapView: MKMapView) -> Bool {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            // Do Map Stuff
            startTrackingUserLocation(mapView: mapView)
            return true
            
        case .denied:
            // Show alert to turn on permissions
            return false
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            return false
            
        case .restricted:
            //Show alert
            return false
            
        case .authorizedAlways:
            return true
            
        @unknown default:
            fatalError()
        }
    }
    
    func startTrackingUserLocation(mapView: MKMapView){
        mapView.showsUserLocation = true
        centerViewOnUserLocation(mapView: mapView)
    }
    
    func centerViewOnUserLocation(mapView: MKMapView) {
        if let userLocation = locationManager.location {
            centerViewOnLocation(mapView: mapView, location: userLocation)
        }
    }
    
    func centerViewOnLocation(mapView: MKMapView, location: CLLocation) {
        let locationCoordinate = location.coordinate
        let region = MKCoordinateRegion.init(center: locationCoordinate, latitudinalMeters: CLLocationDistance(visibleRegionSize.width), longitudinalMeters: CLLocationDistance(visibleRegionSize.height))
        mapView.setRegion(region, animated: true)
    }
    
    func checkLocationServices(mapView: MKMapView, success:(()->())? = nil, failure:(()->())? = nil ) {
        if CLLocationManager.locationServicesEnabled() {
            // setup location manager
            setupLocationManager()
            let isAuthorised = checkLocationAuthorization(mapView: mapView)
            if isAuthorised {
                success?()
            }else {
                failure?()
            }
            
        } else {
            //show alert
        }
    }
    
    func getCenterLocation(mapView: MKMapView) -> CLLocation{
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
}
