import Testing

@testable import VerticalBattery

struct IconNameTests {
    // MARK: - Rounding

    @Test func roundsZeroToZero() {
        #expect(makeBatteryIconName(currentCapacity: 0, isCharging: false, pluggedIn: false) == "vbtry.0pct")
    }

    @Test func roundsOneToFive() {
        #expect(makeBatteryIconName(currentCapacity: 1, isCharging: false, pluggedIn: false) == "vbtry.5pct.red")
    }

    @Test func roundsThreeToFive() {
        #expect(makeBatteryIconName(currentCapacity: 3, isCharging: false, pluggedIn: false) == "vbtry.5pct.red")
    }

    @Test func roundsFiveToFive() {
        #expect(makeBatteryIconName(currentCapacity: 5, isCharging: false, pluggedIn: false) == "vbtry.5pct.red")
    }

    @Test func roundsSixToTen() {
        #expect(makeBatteryIconName(currentCapacity: 6, isCharging: false, pluggedIn: false) == "vbtry.10pct.red")
    }

    @Test func roundsFiftyToFifty() {
        #expect(makeBatteryIconName(currentCapacity: 50, isCharging: false, pluggedIn: false) == "vbtry.50pct")
    }

    @Test func roundsNinetyNineToHundred() {
        #expect(makeBatteryIconName(currentCapacity: 99, isCharging: false, pluggedIn: false) == "vbtry.100pct")
    }

    @Test func roundsHundredToHundred() {
        #expect(makeBatteryIconName(currentCapacity: 100, isCharging: false, pluggedIn: false) == "vbtry.100pct")
    }

    // MARK: - Charging (yellow)

    @Test func zeroPercentChargingShowsNormal() {
        #expect(makeBatteryIconName(currentCapacity: 0, isCharging: true, pluggedIn: false) == "vbtry.0pct")
    }

    @Test func chargingShowsYellow() {
        #expect(makeBatteryIconName(currentCapacity: 50, isCharging: true, pluggedIn: false) == "vbtry.50pct.yellow")
    }

    @Test func chargingAtHundredShowsYellow() {
        #expect(makeBatteryIconName(currentCapacity: 100, isCharging: true, pluggedIn: false) == "vbtry.100pct.yellow")
    }

    // MARK: - Plugged in (green)

    @Test func pluggedInNotChargingShowsGreen() {
        #expect(makeBatteryIconName(currentCapacity: 80, isCharging: false, pluggedIn: true) == "vbtry.80pct.green")
    }

    @Test func pluggedInAtHundredShowsGreen() {
        #expect(makeBatteryIconName(currentCapacity: 100, isCharging: false, pluggedIn: true) == "vbtry.100pct.green")
    }

    // MARK: - Low battery (red)

    @Test func lowBatteryShowsRed() {
        #expect(makeBatteryIconName(currentCapacity: 10, isCharging: false, pluggedIn: false) == "vbtry.10pct.red")
    }

    @Test func twentyPercentShowsRed() {
        #expect(makeBatteryIconName(currentCapacity: 20, isCharging: false, pluggedIn: false) == "vbtry.20pct.red")
    }

    // MARK: - Normal (no suffix)

    @Test func twentyOnePercentHasNoSuffix() {
        #expect(makeBatteryIconName(currentCapacity: 21, isCharging: false, pluggedIn: false) == "vbtry.25pct")
    }

    @Test func normalBatteryHasNoSuffix() {
        #expect(makeBatteryIconName(currentCapacity: 75, isCharging: false, pluggedIn: false) == "vbtry.75pct")
    }

    // MARK: - Priority: charging > pluggedIn > low battery

    @Test func chargingTakesPriorityOverPluggedIn() {
        #expect(makeBatteryIconName(currentCapacity: 50, isCharging: true, pluggedIn: true) == "vbtry.50pct.yellow")
    }

    @Test func chargingTakesPriorityOverLowBattery() {
        #expect(makeBatteryIconName(currentCapacity: 10, isCharging: true, pluggedIn: false) == "vbtry.10pct.yellow")
    }

    @Test func pluggedInTakesPriorityOverLowBattery() {
        #expect(makeBatteryIconName(currentCapacity: 10, isCharging: false, pluggedIn: true) == "vbtry.10pct.green")
    }

    // MARK: - Edge cases

    @Test func allFlagsSetChargingWins() {
        #expect(makeBatteryIconName(currentCapacity: 5, isCharging: true, pluggedIn: true) == "vbtry.5pct.yellow")
    }
}
