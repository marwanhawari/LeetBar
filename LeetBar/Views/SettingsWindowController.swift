//
//  SettingsWindowController.swift
//  LeetBar
//
//  Created by Marwan Hawari on 4/2/24.
//

import SwiftUI

class SettingsWindowController: ObservableObject {
    @Published var isPresented = false
    
    func open() {
        isPresented = true
    }
    
    func close() {
        isPresented = false
    }
}
