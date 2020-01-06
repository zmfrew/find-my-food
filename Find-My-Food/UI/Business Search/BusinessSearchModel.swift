import UIKit
//swiftlint:disable function_parameter_count

protocol BusinessSearchModelProtocol {
    var businesses: [Business] { get }
    var selectedPrices: [String] { get }

    func deSelected(_ price: String)
    func presentLocationError()
    func search(for business: String,
                latitude: Double?,
                location: String?,
                longitude: Double?,
                radius: Int,
                prices: [String],
                openNow: Bool)
    func selected(_ price: String)
}

protocol BusinessSearchModelDelegate: class {
    func downloadDidBegin()
    func downloadDidEnd()
    func present(_ viewControllerToPresent: UIViewController, animated: Bool)
}

final class BusinessSearchModel: BusinessSearchModelProtocol {
    private(set) var businesses = [Business]()
    private weak var delegate: BusinessSearchModelDelegate?
    private let businessSearchClient: BusinessSearchClientProtocol
    private(set) var selectedPrices = [String]()

    init(businessSearchClient: BusinessSearchClientProtocol, delegate: BusinessSearchModelDelegate) {
        self.businessSearchClient = businessSearchClient
        self.delegate = delegate
    }

    func deSelected(_ price: String) {
        guard selectedPrices.contains(price),
            let index = selectedPrices.firstIndex(of: price) else { return }

        selectedPrices.remove(at: index)
    }

    func presentLocationError() {
        let alert = UIAlertController(title: "Oh no!", message: "Please activate location services or enter a location to search for restaurants!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        delegate?.present(alert, animated: true)
    }

    func search(for business: String,
                latitude: Double?,
                location: String?,
                longitude: Double?,
                radius: Int,
                prices: [String],
                openNow: Bool) {
        let intPrices = prices.compactMap { $0.priceToInt }.sorted()
        let prices = intPrices.isNotEmpty ? intPrices : Price.values

        delegate?.downloadDidBegin()
        DispatchQueue.global(qos: .userInitiated).async {
            self.businessSearchClient.search(for: business,
                                             latitude: latitude,
                                             location: location,
                                             longitude: longitude,
                                             radius: radius.milesToMeters,
                                             prices: prices, openNow: openNow) { [weak self] businesses in
                guard let self = self else { return }

                DispatchQueue.main.async {
                    self.businesses = businesses
                    self.delegate?.downloadDidEnd()
                }
            }
        }
    }

    func selected(_ price: String) {
        guard !selectedPrices.contains(price) else { return }

        selectedPrices.append(price)
    }
}
