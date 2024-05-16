//
//  Adaptable.swift
//  Zadanie
//
//  Created by Maja Frąk on 14/05/2024.
//

import Foundation

protocol Adaptable {
    associatedtype Model
    
    func adapt(model: Model)
}
