//
//  Fonts.swift
//  Zadanie
//
//  Created by Maja Frąk on 14/05/2024.
//

import UIKit

enum AppFonts {
    case Manrope_Bold(size: CGFloat)
    case Manrope_SemiBold(size: CGFloat)
    case Manrope_Medium(size: CGFloat)
    
    var font: UIFont {
        switch self {
        case .Manrope_Bold(let size):
            return UIFont(name: "Manrope-Bold", size: size)!
        case .Manrope_SemiBold(let size):
            return UIFont(name: "Manrope-SemiBold", size: size)!
        case .Manrope_Medium(let size):
            return UIFont(name: "Manrope-Medium", size: size)!
        }
    }
}
