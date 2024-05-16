//
//  StationDetailsViewModel.swift
//  Zadanie
//
//  Created by Maja Frąk on 16/05/2024.
//

import Foundation
import CoreLocation

class StationDetailsViewModel: StationDetailsViewModelProtocol {
    
    let item: DisplayableStation
    let currentLocation: CLLocation?
    
    init(item: DisplayableStation, currentLocation: CLLocation?) {
        self.item = item
        self.currentLocation = currentLocation
    }
}
