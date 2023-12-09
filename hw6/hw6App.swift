//
//  hw6App.swift
//  hw6
//
//  Created by Julian Hoffmann on 05.06.23.
//

import SwiftUI

@main
struct hw6App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            MapView()
        }
    }
}

