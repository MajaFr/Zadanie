//
//  Collection.swift
//  Zadanie
//
//  Created by Maja Frąk on 14/05/2024.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
