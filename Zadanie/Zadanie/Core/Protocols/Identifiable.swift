//
//  Identifiable.swift
//  Zadanie
//
//  Created by Maja Frąk on 14/05/2024.
//

import Foundation

protocol Identifiable: AnyObject {
    
    static var identifier: String { get }
}

extension Identifiable {
    
    static var identifier: String {
        return String(describing: self)
    }
}
