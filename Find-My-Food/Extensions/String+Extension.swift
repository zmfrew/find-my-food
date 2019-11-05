import Foundation

extension String {
    var phoneURL: URL? {
        URL(string: "tel://\(self)")
    }
}
