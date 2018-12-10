//
//  Location.swift
//  DoorDash
//
//  Created by ilyas on 12/10/18.
//  Copyright © 2018 ilyas. All rights reserved.
//

import Foundation
import MapKit

struct Location {
    var lat: Double
    var lng: Double
    
    var cllocation: CLLocation {
        return CLLocation(latitude: lat, longitude: lng)
    }
}
