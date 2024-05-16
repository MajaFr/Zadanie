//
//  ServiceProvider.swift
//  Zadanie
//
//  Created by Maja Frąk on 14/05/2024.
//

import Foundation

protocol ServiceProviderProtocol {
    var urlComponents: RequestURLComponents { get }
    var http: HTTP { get }
    var stationsService: StationService { get }
}

class ServiceProvider: ServiceProviderProtocol {
    private let jsonParser: JSONParser
    let urlComponents: RequestURLComponents
    let http: HTTP
    let stationsService: StationService
    
    init() {
        self.jsonParser = JSONParser()
        self.urlComponents = RequestURLComponents(scheme: Constants.sheme, host: Constants.host)
        self.http = HTTP(jsonParser: jsonParser)
        self.stationsService = StationService(http: http, urlComponents: urlComponents)
    }
}
