//
//  ViewModifiers.swift
//  LeetBar
//
//  Created by Marwan Hawari on 7/28/22.
//

import SwiftUI

struct ThinBackground: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    
    let cornerRadius: Double
    let opacity: Double
    
    func body(content: Content) -> some View {
        content
            .background(colorScheme == .light ? .white.opacity(opacity) : .black.opacity(opacity))
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder(.gray.opacity(0.5), lineWidth: 0.75)
            )
    }
}

extension View {
    func thinBackground(cornerRadius: Double, opacity: Double) -> some View {
        modifier(ThinBackground(cornerRadius: cornerRadius, opacity: opacity))
    }
}
