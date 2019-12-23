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
    private var latitude: Double!
    private var longitude: Double!
    private var model: BusinessSearchModelProtocol!
    private var searchView: BusinessSearchView { view as! BusinessSearchView } //swiftlint:disable:this force_cast

    override func viewDidLoad() {
        super.viewDidLoad()
        // TOOD: - Move BaseServiceClient's into an AppSession of some sort.
        let decoder = DecoderWrapper(decoder: JSONDecoder())
        let serviceClient = BaseServiceClient(urlSession: URLSessionWrapper())
        let businessSearchClient = BusinessSearchClient(decoder: decoder, serviceClient: serviceClient)
		model = BusinessSearchModel(businessSearchClient: businessSearchClient, delegate: self)

		searchView.delegate = self
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

    }

    func configure(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
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
}

extension BusinessSearchViewController: BusinessSearchViewDelegate {
    func deSelected(_ price: String) {
        model.deSelected(price)
    }

    func search(for business: String, radius: Int, prices: [String], openNow: Bool) {

        model.search(for: business, latitude: latitude, longitude: longitude, radius: radius, prices: prices, openNow: openNow)
    }

    func selected(_ price: String) {
        model.selected(price)
    }
}
