import IOKit

enum BatteryService {
    private static let service = IOServiceGetMatchingService(kIOMainPortDefault, IOServiceNameMatching("AppleSmartBattery"))

    static var currentCapacity: Int? {
        getProperty("CurrentCapacity") as? Int
    }

    static var isCharging: Bool? {
        getProperty("IsCharging") as? Bool
    }

    static var deviceName: String? {
        getProperty("DeviceName") as? String
    }

    private static func getProperty(_ key: String) -> CFTypeRef? {
        let prop = IORegistryEntryCreateCFProperty(service, key as CFString, nil, 0)
        return prop?.takeUnretainedValue()
    }
}
