//
//  tttApp.swift
//  ttt
//
//  Created by Richard Lam on 12/28/24.
//

struct LolView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Text("Hello, SwiftUI on macOS!")
        Button("Close Window") {
                        dismiss()
                    }
        
    }
}

import SwiftUI
@main
struct tttApp: App {
    var body: some Scene {
        MenuBarExtra("App") {
            ContentView().frame(width: 150, height: 125)
        }
        .menuBarExtraStyle(.window)
        
        WindowGroup("What's New", id: "newWindow") {
            LolView()
                        .onAppear {
                            if let window = NSApplication.shared.windows.last {
                                window.toggleFullScreen(nil)
                            }
                        }
                }
    }
}
