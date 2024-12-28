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
    
    @State private var minutes: String = "20"
    @State private var seconds: String = "00"


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
            
            HStack {
                TextField("20", text: $minutes)
                    .frame(width:25)
                Text(":")
                TextField("00", text: $seconds)
                    .frame(width:25)
            }
            
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
