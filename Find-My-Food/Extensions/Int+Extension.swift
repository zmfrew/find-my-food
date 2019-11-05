import Foundation

extension Int {
    var milesToMeters: Int {
        if self == 25 { return 40_000 } // Yelp's api supports up to 40,000 meters, so this must be rounded down.
        let miles = Measurement(value: Double(self), unit: UnitLength.miles)
        return Int(miles.converted(to: UnitLength.meters).value)
    }
}
