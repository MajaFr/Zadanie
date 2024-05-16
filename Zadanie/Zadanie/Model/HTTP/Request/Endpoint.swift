//
//  Endpoint.swift
//  Zadanie
//
//  Created by Maja Frąk on 14/05/2024.
//

import Foundation

public enum Endpoint {
    
    case stationInfo
    case stationStatus

    public var url: String {
        switch self {
        case .stationInfo: return "station_information.json"
        case .stationStatus: return "station_status.json"
        }
    }
}
