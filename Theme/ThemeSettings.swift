//
//  ThemeSettings.swift
//  Todo App
//
//  Created by Pusiewicz, M. (Mateusz) on 30/11/2022.
//

import SwiftUI


class ThemeSettings: ObservableObject {
    @Published public var themeSettings: Int = UserDefaults.standard.integer(forKey: "Theme") {
        didSet {
            UserDefaults.standard.set(self.themeSettings, forKey: "Theme")
        }
    }
    
    private init() {}
    public static let shared = ThemeSettings()
    
}
