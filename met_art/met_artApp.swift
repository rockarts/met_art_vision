//
//  met_artApp.swift
//  met_art
//
//  Created by Steven Rockarts on 2024-03-22.
//

import SwiftUI

@main
struct met_artApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
