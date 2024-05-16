//
//  NetworkResponse.swift
//  Zadanie
//
//  Created by Maja Frąk on 14/05/2024.
//

import Foundation

struct NetworkResponse {
    
    var data: Data?
    var httpHeader: [AnyHashable: Any]?
    var statusCode: Int
    
    var isSuccess: Bool {
        return statusCode >= 200 && statusCode <= 299
    }
}
