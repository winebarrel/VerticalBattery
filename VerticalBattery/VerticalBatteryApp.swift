import SwiftUI

@main
struct VerticalBatteryApp: App {
    @StateObject private var battery = BatteryModel()
    @ObservedObject var menuBarState = MenuBarState()

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
            Button("About VerticalBattery") {
                let githubRepo = "github.com/winebarrel/VerticalBattery"
                NSApp.orderFrontStandardAboutPanel(options: [
                    NSApplication.AboutPanelOptionKey.applicationIcon: NSImage(named: "AppIcon")!,
                    NSApplication.AboutPanelOptionKey.credits: NSMutableAttributedString(
                        string: githubRepo,
                        attributes: [.link: "https://" + githubRepo]
                    )
                ])
            }
            Toggle(isOn: $menuBarState.launchAtLogin) {
                Text("Launch at login")
            }
            .toggleStyle(.checkbox)
            Divider()
            Button("Quit") {
                NSApplication.shared.terminate(self)
            }
        } label: {
            if BatteryService.enabled,
               let currentCapacity = battery.currentCapacity,
               let isCharging = battery.isCharging
            {
                let name = buildIcon(currentCapacity: currentCapacity, isCharging: isCharging)
                Image(name)
            } else {
                Image("vbtry.slash")
            }
        }
    }

    private func buildIcon(currentCapacity: Int, isCharging: Bool) -> String {
        let pct = Int(ceil(Double(currentCapacity) / 5) * 5)

        let color = if isCharging {
            ".yellow"
        } else if BatteryService.pluggedIn {
            ".green"
        } else if currentCapacity <= 20 {
            ".red"
        } else {
            ""
        }

        return "vbtry." + String(pct) + "pct" + color
    }
}
