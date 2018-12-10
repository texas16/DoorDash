//
//  LocationViewModel.swift
//  DoorDash
//
//  Created by ilyas on 12/10/18.
//  Copyright © 2018 ilyas. All rights reserved.
//

import Foundation
import MapKit

protocol LocationViewModelDelegate {
    
}

protocol LocationViewable {
    var currentLocation: Observer<Location?> { get }
    var selectedLocation: Observer<Location?> { get }
    var regionRadius: Double { get }
}

class LocationViewModel: NSObject, LocationViewable {
    
    var delegate: LocationViewModelDelegate?
    var locationManager = CLLocationManager()
    let regionRadius: Double = 100
    let currentLocation: Observer<Location?> = Observer(nil)
    let selectedLocation: Observer<Location?> = Observer(nil)
    
    override init() {
        super.init()
        setupLocationServices()
    }
    
    deinit {
        locationManager.stopUpdatingLocation()
    }
}

extension LocationViewModel: CLLocationManagerDelegate {
    
    func setupLocationServices() {
        guard CLLocationManager.locationServicesEnabled() else {
            locationManager.requestWhenInUseAuthorization()
            return
        }
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = locations.last?.coordinate  else { return }
        currentLocation.value = Location(lat: coordinate.latitude, lng: coordinate.longitude)
    }
}
