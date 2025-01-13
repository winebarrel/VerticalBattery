import SwiftUI

@main
struct VerticalBatteryApp: App {
    @StateObject private var battery = BatteryModel()

    var body: some Scene {
        MenuBarExtra {
            if let currentCapacity = battery.currentCapacity {
                let label = String(format: "%d%%", currentCapacity)
                Button(label) {
                    let url = URL(string: "x-apple.systempreferences:com.apple.preference.battery")!
                    NSWorkspace.shared.open(url)
                }
            } else {
                Text("N/A")
            }
            Divider()
            Button("Quit") {
                NSApplication.shared.terminate(self)
            }
        } label: {
            Image(systemName: "leaf")
        }
    }
}
