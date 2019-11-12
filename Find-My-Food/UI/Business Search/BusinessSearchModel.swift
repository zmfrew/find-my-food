import Foundation
//swiftlint:disable function_parameter_count

protocol BusinessSearchModelProtocol {
    var businesses: [Business] { get }
    var selectedPrices: [String] { get }

    func deSelected(_ price: String)
    func search(for business: String, latitude: Double, longitude: Double, radius: Int, prices: [String], openNow: Bool)
    func selected(_ price: String)
}

protocol BusinessSearchModelDelegate: class {
    func downloadDidBegin()
    func downloadDidEnd()
}

final class BusinessSearchModel: BusinessSearchModelProtocol {
    private(set) var businesses = [Business]()
    private let businessSearchClient: BusinessSearchClientProtocol
    private(set) var selectedPrices = [String]()
    private weak var delegate: BusinessSearchModelDelegate?

    init(businessSearchClient: BusinessSearchClientProtocol, delegate: BusinessSearchModelDelegate) {
        self.businessSearchClient = businessSearchClient
        self.delegate = delegate
    }

    func deSelected(_ price: String) {
        guard selectedPrices.contains(price) else { return }

        if let index = selectedPrices.firstIndex(of: price) {
            selectedPrices.remove(at: index)
        }
    }

    func search(for business: String, latitude: Double, longitude: Double, radius: Int, prices: [String], openNow: Bool) {
        let intPrices = prices.compactMap { $0.priceToInt }.sorted()
        let prices = intPrices.isNotEmpty ? intPrices : Price.values

        delegate?.downloadDidBegin()
        DispatchQueue.global(qos: .userInitiated).async {
            self.businessSearchClient.search(for: business,
                                             latitude: latitude,
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
