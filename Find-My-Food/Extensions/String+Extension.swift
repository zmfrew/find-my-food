import Foundation

extension String {
    var phoneURL: URL? {
        return URL(string: "tel://\(self)")
    }
}
