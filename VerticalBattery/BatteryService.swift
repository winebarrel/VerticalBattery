import IOKit

enum BatteryService {
    private static let service = IOServiceGetMatchingService(kIOMainPortDefault, IOServiceNameMatching("AppleSmartBattery"))

    static var currentCapacity: Int? {
        let prop = IORegistryEntryCreateCFProperty(service, "CurrentCapacity" as CFString, nil, 0)
        return prop?.takeUnretainedValue() as? Int
    }

    static var isCharging: Bool? {
        let prop = IORegistryEntryCreateCFProperty(service, "IsCharging" as CFString, nil, 0)
        return prop?.takeUnretainedValue() as? Bool
    }

    static var deviceName: String? {
        let prop = IORegistryEntryCreateCFProperty(service, "DeviceName" as CFString, nil, 0)
        return prop?.takeUnretainedValue() as? String
    }
}
