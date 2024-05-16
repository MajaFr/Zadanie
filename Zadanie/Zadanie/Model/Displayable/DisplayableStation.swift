//
//  DisplayableStation.swift
//  Zadanie
//
//  Created by Maja Frąk on 14/05/2024.
//

import Foundation
import CoreLocation

struct DisplayableStation {
    let name: String
    let distance: Double
    let address: String
    let bikesAvailable: Int
    let placesAvailable: Int
    let lat: Double
    let long: Double
    
    var location: CLLocation {
        CLLocation(latitude: lat, longitude: long)
    }
}
