import SwiftUI

@main
struct VerticalBatteryApp: App {
    var body: some Scene {
        MenuBarExtra {
            Button("Quit") {
                NSApplication.shared.terminate(self)
            }
        } label: {
            Image(systemName: "leaf")
        }
    }
}
