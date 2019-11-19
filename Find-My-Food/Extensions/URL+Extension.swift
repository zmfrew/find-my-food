import UIKit

extension URL {
    func call() {
        UIApplication.shared.open(self)
    }
}
