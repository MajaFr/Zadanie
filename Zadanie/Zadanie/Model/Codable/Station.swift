//
//  Station.swift
//  Zadanie
//
//  Created by Maja Frąk on 14/05/2024.
//

import Foundation

// MARK: - ResponseModel
struct ResponseModel<T>: Codable where T: Codable {
    let lastUpdated, ttl: Int
    let version: String
    let data: T
}

// MARK: - DataClass
struct DataStationsInfo: Codable {
    let stations: [StationInfo]
}

struct DataStationsStatus: Codable {
    let stations: [StationsStatus]
}

// MARK: - StationInfo
struct StationInfo: Codable {
    let stationId, name, address, crossStreet: String
    let lat, lon: Double
    let isVirtualStation: Bool
    let capacity: Int
}

// MARK: - StationDetails
struct StationsStatus: Codable {
    let stationId: String
    let isInstalled: Bool
    let isRenting: Bool
    let isReturning: Bool
    let lastReported: Int
    let numVehiclesAvailable: Int
    let numBikesAvailable: Int
    let numDocksAvailable: Int
}
