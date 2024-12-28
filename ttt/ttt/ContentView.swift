//
//  ContentView.swift
//  ttt
//
//  Created by Richard Lam on 12/28/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isPressed = false
    @State private var buttonText = "Start"

    func toggleTimer() {
        isPressed.toggle()
        
        if (isPressed) {
            buttonText = "Pause"
        } else {
            buttonText = "Start"
        }
    }
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            Text("Hello")
            
            Button(action: toggleTimer) {
                Text(buttonText)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
