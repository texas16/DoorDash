//
//  MapViewController.swift
//  DoorDash
//
//  Created by ilyas on 12/10/18.
//  Copyright © 2018 ilyas. All rights reserved.
//

import UIKit
import MapKit

protocol LocationViewControllerDelegate {
    func didChangeSelectedLocation(with location: Location)
}

class MapViewController: UIViewController,CLLocationManagerDelegate {
    
    @IBOutlet weak var addressField: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    var delegate: LocationViewControllerDelegate?
    var locationViewModel: LocationViewable = LocationViewModel()
    
    var annotation: Annotation? {
        didSet {
            self.addressField.text = nil
            self.addressField.isHidden = true
            guard let annotation = self.annotation else { return }
            mapView.removeAnnotations(mapView.annotations)
            mapView.addAnnotation(annotation)
            annotation.address.bind { [weak self] address in
                self?.addressField.text = address
                self?.addressField.isHidden = false
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let location = Location(lat: mapView.centerCoordinate.latitude, lng: mapView.centerCoordinate.longitude)
        mapView.removeAnnotations(mapView.annotations)
        annotation = Annotation(with: location)
        annotation?.address.bind { [weak self] address in
            self?.addressField.text = address
            self?.addressField.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationViewModel.currentLocation.bind { [weak self] location in
            guard self?.locationViewModel.selectedLocation.value == nil,
                let location = location else { return }
            self?.annotation = Annotation(with: location)
            self?.centerMapOnLocation(location.cllocation)
        }
        
        locationViewModel.selectedLocation.bind { [weak self] location in
            guard let location = location else { return }
            self?.centerMapOnLocation(location.cllocation)
            if let annotations = self?.mapView.annotations {
                self?.mapView.removeAnnotations(annotations)
            }
        }
    }
    
    @IBAction func confirmAddressBtnClicked(_ sender: Any) {

        if let location = self.annotation?.location {
            locationViewModel.selectedLocation.value = location
            delegate?.didChangeSelectedLocation(with: location)
        }
        
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "storeSegue", sender: self)
        }
    }
    
    func centerMapOnLocation(_ location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: locationViewModel.regionRadius * 2.0,
            longitudinalMeters: locationViewModel.regionRadius * 2.0
        )
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "storeSegue" {
            let barViewControllers = segue.destination as! UITabBarController
            let destinationViewController = barViewControllers.viewControllers?[0] as! ExploreTableViewController
            destinationViewController.annotation = annotation ?? nil
        }
    }
}

extension MapViewController { }

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let location = Location(lat: mapView.centerCoordinate.latitude, lng: mapView.centerCoordinate.longitude)
        mapView.removeAnnotations(mapView.annotations)
        annotation = Annotation(with: location)
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState)
    {
        switch newState {
        case .starting:
            view.dragState = .dragging
        case .ending, .canceling:
            view.dragState = .none
        default: break
        }
    }
}

