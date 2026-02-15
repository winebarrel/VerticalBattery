import Foundation

func makeBatteryIconName(currentCapacity: Int, isCharging: Bool, pluggedIn: Bool) -> String {
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
