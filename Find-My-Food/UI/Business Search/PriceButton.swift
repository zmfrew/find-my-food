import UIKit

protocol PriceButtonDelegate: class {
    func selected(_ price: String)
    func deSelected(_ price: String)
}

final class PriceButton: UIButton {
    weak var delegate: PriceButtonDelegate?

    var isActive: Bool = false {
        didSet {
            toggle()
        }
    }

    private func toggle() {
        guard let text = titleLabel?.text else { return }

        if isActive {
            tintColor = .white
            backgroundColor = .systemBlue
            delegate?.selected(text)
        } else {
            tintColor = .systemBlue
            backgroundColor = .clear
            delegate?.deSelected(text)
        }
    }
}
