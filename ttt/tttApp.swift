//
//  tttApp.swift
//  ttt
//
//  Created by Richard Lam on 12/28/24.
//

import SwiftUI

@main
struct tttApp: App {
    var body: some Scene {
        MenuBarExtra("App") {
            ContentView().frame(width: 400, height: 600)
        }
        .menuBarExtraStyle(.window)
    }
}
