import math_h

func makeBatteryIconName(currentCapacity: Int, isCharging: Bool, pluggedIn: Bool) -> String {
    let clampedCapacity = min(max(currentCapacity, 0), 100)
    let pct = Int(ceil(Double(clampedCapacity) / 5) * 5)

    let color: String
    if pct == 0 {
        // 0% only has an uncolored asset (vbtry.0pct), so don't append a color suffix.
        color = ""
    } else if isCharging {
        color = ".yellow"
    } else if pluggedIn {
        color = ".green"
    } else if currentCapacity <= 20 {
        color = ".red"
    } else {
        color = ""
    }

    return "vbtry." + String(pct) + "pct" + color
}
