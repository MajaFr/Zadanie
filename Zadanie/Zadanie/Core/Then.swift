//
//  Then.swift
//  Zadanie
//
//  Created by Maja Frąk on 14/05/2024.
//

import Foundation

public protocol Then {}

extension Then where Self: Any {

    @inlinable
    public func with(_ block: (inout Self) throws -> Void) rethrows -> Self {
        var copy = self
        try block(&copy)
        return copy
    }
}

extension Then where Self: AnyObject {

    @inlinable
    public func then(_ block: (Self) throws -> Void) rethrows -> Self {
        try block(self)
        return self
    }
}

extension NSObject: Then {}
extension Array: Then {}
extension Dictionary: Then {}
extension Set: Then {}
