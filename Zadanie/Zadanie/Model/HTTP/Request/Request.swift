//
//  Request.swift
//  Zadanie
//
//  Created by Maja Frąk on 14/05/2024.
//

import Foundation

public struct RequestURLComponents {
    
    var scheme: String
    var host: String
    
    public init(
        scheme: String,
        host: String) {
        self.scheme = scheme
        self.host = host
    }
}

public struct Request {
    
    var urlComponents: RequestURLComponents
    var endpoint: Endpoint?
    var method: HTTPMethod = .get
    
    var url: URL? {
        guard let requestEndpoint = endpoint?.url else { return nil }
        let url = urlComponents.scheme + urlComponents.host + requestEndpoint
        guard let endpoint = URL(string: url) else { return nil }
        
        return URL(string: endpoint.absoluteString)
    }
    
    public init(urlComponents: RequestURLComponents) {
        self.urlComponents = urlComponents
    }
}
