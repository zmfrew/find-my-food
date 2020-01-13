import UIKit

final class BusinessDetailViewController: UIViewController, Storyboarded {
    @IBOutlet private weak var locationButton: UIBarButtonItem!

    weak var coordinator: BusinessCoordinator?
    private var detailView: BusinessDetailView { view as! BusinessDetailView } //swiftlint:disable:this force_cast
    private var model: BusinessDetailModelProtocol!

    func configure(with model: BusinessDetailModelProtocol, isFavorite: Bool) {
        self.model = model
        detailView.configure(with: model.business, delegate: self, isFavorite: isFavorite)
        title = model.business.name
    }

    @IBAction private func locationButtonTapped(_ sender: UIBarButtonItem) {
        coordinator?.location(for: model.business)
    }
}

extension BusinessDetailViewController: BusinessDetailModelDelegate {
    func saveDidFail() {
        let alert = UIAlertController(title: "Save failed ❌", message: nil, preferredStyle: .alert)
        present(alert, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { self.dismiss(animated: true, completion: nil)
            }
        }
    }

    func saveDidSucceed() {
        let alert = UIAlertController(title: "Successfully saved ✅", message: nil, preferredStyle: .alert)
        present(alert, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { self.dismiss(animated: true, completion: nil)
                self.detailView.saveDidSucceed()
            }
        }
    }
}

extension BusinessDetailViewController: BusinessDetailViewDelegate {
    func call(_ phone: String?, display: String?) {
        guard let phone = phone?.phoneURL,
            let display = display else { return }

        let alert = UIAlertController(title: "Call \(display)", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Call", style: .default) { _ in
            phone.call()
        })

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        self.present(alert, animated: true)
    }

    func favorite() {
        model.favorite()
    }
}
