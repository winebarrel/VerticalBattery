import Combine
import ServiceManagement

class MenuBarState: ObservableObject {
    @Published var launchAtLogin = SMAppService.mainApp.status == .enabled
    var cancelable: AnyCancellable?

    init() {
        cancelable = $launchAtLogin.sink { newValue in
            do {
                if newValue {
                    try SMAppService.mainApp.register()
                } else {
                    try SMAppService.mainApp.unregister()
                }
            } catch {
                Logger.shared.error("failed to change launchAtLogin: \(error)")
            }
        }
    }
}
