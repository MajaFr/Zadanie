//
//  HTTPMethod.swift
//  Zadanie
//
//  Created by Maja Frąk on 14/05/2024.
//

import Foundation

enum HTTPMethod {
    case get
    
    var string: String {
        switch self {
        case .get: return "GET"
        }
    }
}
