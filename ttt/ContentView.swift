//
//  ContentView.swift
//  ttt
//
//  Created by Richard Lam on 12/28/24.
//

import SwiftUI

class AppState: ObservableObject {
	@Published var showOverlay = false
}

struct ContentView: View {
	@State private var overlayWindow: NSWindow? = nil
	
    @State private var isPaused = true
    @State private var buttonText = "Start"

	@State private var minutes: String = "20"
	@State private var seconds: String = "00"
	@State private var waitTime: Int = 0
	
	@EnvironmentObject var appState: AppState
	
	let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
	
	// Function to create the overlay window dynamically
	private func createOverlayWindow() {
		guard overlayWindow == nil else { return } // Prevent duplicate windows
		
		if let screen = NSScreen.main {
			let screenRect = screen.frame

			let window = NSWindow(
				contentRect: screenRect,
				styleMask: [.borderless],
				backing: .buffered,
				defer: false
			)
			window.isReleasedWhenClosed = false
			window.level = .floating
			window.isOpaque = false
			window.backgroundColor = .clear // Ensures transparent background
			window.ignoresMouseEvents = false

			// Add a visual effect view for the blur
			let visualEffectView = NSVisualEffectView()
			visualEffectView.frame = screenRect
			visualEffectView.blendingMode = .behindWindow
			visualEffectView.state = .active
			visualEffectView.material = .hudWindow // Change to `.fullScreenUI`, `.dark`, or others for different styles

			// Add the visual effect view as the window's subview
			let hostingView = NSHostingView(rootView: OverlayView().environmentObject(appState))
			hostingView.frame = screenRect

			let containerView = NSView(frame: screenRect)
			containerView.addSubview(visualEffectView)
			containerView.addSubview(hostingView)

			window.contentView = containerView

			// Display the window
			window.makeKeyAndOrderFront(nil)
			overlayWindow = window
		}
	}
	
	// Function to close the overlay window
	private func closeOverlayWindow() {
		print("test")
		overlayWindow?.close()
		overlayWindow = nil
	}
	
    func toggleTimer() {
        isPaused.toggle()
		buttonText = isPaused ? "Start" : "Pause"
    }

	func updateTime() {
		var amt: Int = Int(minutes)! * 60 + Int(seconds)!
		
		if (amt == 0) {
			buttonText = "Start"
			
			if (waitTime == 0) {
				createOverlayWindow()
			} else if (waitTime == 20) {
				waitTime = 0
				isPaused = true
				closeOverlayWindow()
				return
			}
			
			waitTime += 1
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

struct OverlayView: View {
	@EnvironmentObject var appState: AppState

	@State private var seconds: Int = 20
	
	let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
	
	func closeWindow() {
		appState.showOverlay = false
	}
	
	var body: some View {
		VStack {
			Text("Time to look away!")
			Text(String(seconds)).onReceive(timer) { firedDate in
				if (seconds <= 0) {
					closeWindow()
				}
				seconds -= 1
			}
			
			Button(action: closeWindow) {
				Label("Close", systemImage: "arrow.up")
			}
		}
	}
}
