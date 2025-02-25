import SwiftUI

@main
struct VerticalBatteryApp: App {
    @StateObject private var battery = BatteryModel()
    @ObservedObject private var menuBarState = MenuBarState()

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
            Button("About \(Bundle.main.infoDictionary![kCFBundleNameKey as String]!)") {
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
               let isCharging = battery.isCharging,
               let pluggedIn = battery.pluggedIn
            {
                let name = buildIcon(
                    currentCapacity: currentCapacity,
                    isCharging: isCharging,
                    pluggedIn: pluggedIn
                )
                Image(name)
            } else {
                Image("vbtry.slash")
            }
        }
    }

    private func buildIcon(currentCapacity: Int, isCharging: Bool, pluggedIn: Bool) -> String {
        let pct = Int(ceil(Double(currentCapacity) / 5) * 5)

        let color = if isCharging {
            ".yellow"
        } else if pluggedIn {
            ".green"
        } else if currentCapacity <= 20 {
            ".red"
        } else {
            ""
        }

        return "vbtry." + String(pct) + "pct" + color
    }
}
