//
//  Colors.swift
//  LeetBar
//
//  Created by Marwan Hawari on 8/5/22.
//

import Foundation
import SwiftUI

extension Color {
    static let easyColor = Color(hue: 113/360, saturation: 1, brightness: 0.7 - 0.015)
    static let mediumColor = Color(hue: 36/360, saturation: 1, brightness: 0.90 - 0.015)
    static let hardColor = Color(hue: 0/360, saturation: 1, brightness: 0.9 - 0.015)
    static let grayCircleColor = Color.gray.opacity(0.65)
}

extension ShapeStyle where Self == Color {
    static var easyColor: Color { Color(hue: 113/360, saturation: 1, brightness: 0.7 - 0.015) }
    static var mediumColor: Color { Color(hue: 36/360, saturation: 1, brightness: 0.90 - 0.015) }
    static var hardColor: Color { Color(hue: 0/360, saturation: 1, brightness: 0.9 - 0.015) }
    static var grayCircleColor: Color { Color.gray.opacity(0.65) }
}
