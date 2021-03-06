import UIKit

protocol BusinessSearchViewControllerDelegate: class {
    func downloadCompleted(with businesses: [Business])
}

extension BusinessSearchViewControllerDelegate {
    func downloadCompleted(with businesses: [Business]? = nil) { }
}

final class BusinessSearchViewController: UIViewController, Storyboarded {
    weak var coordinator: SearchCoordinatorProtocol?
    weak var delegate: BusinessSearchViewControllerDelegate?
    private var latitude: Double?
    private var longitude: Double?
    private var model: BusinessSearchModelProtocol!
    private var searchView: BusinessSearchView { view as! BusinessSearchView } //swiftlint:disable:this force_cast

    override func viewDidLoad() {
        super.viewDidLoad()
        let decoder = DecoderWrapper(decoder: JSONDecoder())
        let serviceClient = BaseServiceClient(urlSession: URLSessionWrapper())
        let businessSearchClient = BusinessSearchClient(decoder: decoder, serviceClient: serviceClient)
        model = BusinessSearchModel(businessSearchClient: businessSearchClient, delegate: self, session: UserSession.shared)

		searchView.delegate = self

        let (radius, location) = model.loadDefaults()
        searchView.set(radius: radius, location: location)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

    }

    func configure(latitude: Double?, longitude: Double?) {
        if let latitude = latitude,
            let longitude = longitude {
            self.latitude = latitude
            self.longitude = longitude
            searchView.shouldHideLocationTextField(true)
        } else {
            searchView.shouldHideLocationTextField(false)
        }
    }

    func hideView() {
        searchView.isHidden = true
    }
}

extension BusinessSearchViewController: BusinessSearchModelDelegate {
    func downloadDidBegin() {
        searchView.downloadDidBegin()
    }

    func downloadDidEnd() {
        searchView.downloadDidEnd()
        coordinator?.dismiss()
        delegate?.downloadCompleted(with: model.businesses)
    }

    func present(_ viewControllerToPresent: UIViewController, animated: Bool) {
        present(viewControllerToPresent, animated: animated, completion: nil)
    }
}

extension BusinessSearchViewController: BusinessSearchViewDelegate {
    func deSelected(_ price: String) {
        model.deSelected(price)
    }

    func presentLocationError() {
        model.presentLocationError()
    }

    func search(for business: String,
                location: String?,
                openNow: Bool,
                prices: [String],
                radius: Int) {
        model.search(for: business,
                     latitude: latitude,
                     location: location,
                     longitude: longitude,
                     radius: radius,
                     prices: prices,
                     openNow: openNow)
    }

    func selected(_ price: String) {
        model.selected(price)
    }
}
