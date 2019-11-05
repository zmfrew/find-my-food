import Foundation

extension String {
    var phoneURL: URL? {
        URL(string: "tel://\(self)")
    }
    
    var priceToInt: Int? {
        switch self {
        case "$":
            return 1
        case "$$":
            return 2
        case "$$$":
            return 3
        case "$$$$":
            return 4
        default:
            return nil
        }
    }
}
