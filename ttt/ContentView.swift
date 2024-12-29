//
//  ContentView.swift
//  ttt
//
//  Created by Richard Lam on 12/28/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isPaused = true
    @State private var buttonText = "Start"
    
    @State private var minutes: String = "20"
    @State private var seconds: String = "00"
	
	let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    func toggleTimer() {
        isPaused.toggle()
		buttonText = isPaused ? "Start" : "Pause"
    }
	
	func updateTime() {
		var amt: Int = Int(minutes)! * 60 + Int(seconds)!
		if (amt == 0) {
			isPaused = true
			
			// poop
			
			minutes = "20"
			seconds = "00"
			return
		}
		
		amt -= 1
		minutes = String(format: "%02d", amt / 60)
		seconds = String(format: "%02d", amt % 60)
	}

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            HStack {
                TextField("20", text: $minutes)
					.frame(width:25)
					.disabled(!isPaused)
				
				Text(":").onReceive(timer) { firedDate in
					if (isPaused) {
						return
					}
					
					updateTime()
				}
					
                TextField("00", text: $seconds)
                    .frame(width:25)
					.disabled(!isPaused)
            }

            Button(action: toggleTimer) {
                Text(buttonText)
            }
        }
        .padding(20)
    }
}

#Preview {
    ContentView()
}
