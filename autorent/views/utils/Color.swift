//
//  Color.swift
//  autorent
//
//  Created by Semyon Kravchenko on 30.11.2021.
//

import Foundation
import SwiftUI

extension UIColor {
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var hexInt: UInt32 = 0
        Scanner(string: hex).scanHexInt32(&hexInt)
        let mask = 0x00000000FF
        let red = CGFloat(Int(hexInt >> 16) & mask) / 255.0
        let green = CGFloat(Int(hexInt >> 8) & mask) / 255.0
        let blue = CGFloat(Int(hexInt) & mask) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
}

extension Color {
    static var primary: Color = Color(UIColor.init(hex: "2A3F54"))
    static var primaryDark: Color = Color(UIColor.init(hex: "172D44"))
    static var primaryLight: Color = Color(UIColor.init(hex: "E7E7E7"))
    static var secondary: Color = Color(UIColor.init(hex: "FFA500"))
    static var textLight: Color = Color(UIColor.init(hex: "E7E7E7"))
    static var textDark: Color = Color(UIColor.init(hex: "495057"))
}
