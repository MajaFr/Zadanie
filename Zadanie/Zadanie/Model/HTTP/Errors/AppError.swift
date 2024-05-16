//
//  AppError.swift
//  Zadanie
//
//  Created by Maja Frąk on 14/05/2024.
//

import Foundation

enum AppError: LocalizedError {
    case networkError
    case parsing
    case connectionError
    
    var errorDescription: String? {
        switch self {
        case .networkError:
            return "network error"
        case .parsing:
            return "parsing"
        case .connectionError:
            return "connection error"
        }
    }
}
