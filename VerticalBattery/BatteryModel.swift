import Foundation
import SwiftUI

@MainActor
class BatteryModel: ObservableObject {
    @Published var currentCapacity: Int?
    @Published var isCharging: Bool?

    init() {
        guard BatteryService.enabled else {
            return
        }

        let seq = AsyncStream {
            try? await Task.sleep(for: .seconds(1))
        }

        Task {
            for await _ in seq {
                await self.update()
            }
        }
    }

    func update() async {
        guard BatteryService.enabled else {
            currentCapacity = nil
            isCharging = nil
            return
        }

        currentCapacity = BatteryService.currentCapacity
        isCharging = BatteryService.isCharging
    }
}
