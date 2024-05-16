//
//  StationService.swift
//  Zadanie
//
//  Created by Maja Frąk on 14/05/2024.
//

import Foundation

class StationService {
    typealias StationsInfoResponse = (Result<ResponseModel<DataStationsInfo>, Error>) -> ()
    typealias StationsStatusResponse = (Result<ResponseModel<DataStationsStatus>, Error>) -> ()
    
    var http: HTTP
    var urlComponents: RequestURLComponents
    
    private var requestForInfo: Request {
        var request = Request(urlComponents: urlComponents)
        request.endpoint = .stationInfo
        return request
    }
    
    private var requestForStatus: Request {
        var request = Request(urlComponents: urlComponents)
        request.endpoint = .stationStatus
        return request
    }
    
    init(http: HTTP, urlComponents: RequestURLComponents) {
        self.http = http
        self.urlComponents = urlComponents
    }
    
    func getStationsInfo(completion: @escaping StationsInfoResponse) {
        http.makeRequestAndParse(requestForInfo, completion: completion)
    }
    
    func getStationsStatus(completion: @escaping StationsStatusResponse) {
        http.makeRequestAndParse(requestForStatus, completion: completion)
    }
}

