import math_h

func makeBatteryIconName(currentCapacity: Int, isCharging: Bool, pluggedIn: Bool) -> String {
    let clampedCapacity = min(max(currentCapacity, 0), 100)
    let pct = Int(ceil(Double(clampedCapacity) / 5) * 5)

    let color = if isCharging {
        ".yellow"
    } else if pluggedIn {
        ".green"
    } else if clampedCapacity <= 20 {
        ".red"
    } else {
        ""
    }

    return "vbtry." + String(pct) + "pct" + color
}
