//
//  StationDetailsViewModelProtocol.swift
//  Zadanie
//
//  Created by Maja Frąk on 16/05/2024.
//

import Foundation
import CoreLocation

protocol StationDetailsViewModelProtocol {
    var item: DisplayableStation { get }
    var currentLocation: CLLocation? { get }
}
