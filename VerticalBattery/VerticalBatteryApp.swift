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
            // swiftlint:disable force_cast
            let bundleName = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
            // swiftlint:enable force_cast
            Button("About \(bundleName)") {
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
                let name = makeBatteryIconName(
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
}
