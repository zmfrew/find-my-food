import UIKit

extension UINavigationController {
    func statusBar(backgroundColor: UIColor) {
        let frame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
        let statusBarView = UIView(frame: frame)
        statusBarView.backgroundColor = backgroundColor
        view.addSubview(statusBarView)
    }
}
