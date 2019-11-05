import Foundation
//swiftlint:disable function_parameter_count

protocol BusinessSearchModelProtocol {
    var businesses: [Business] { get }
    func search(for business: String, latitude: Double, longitude: Double, radius: Int, price: String, openNow: Bool)
}

protocol BusinessSearchModelDelegate: class {
    func downloadDidBegin()
    func downloadDidEnd()
}

final class BusinessSearchModel: BusinessSearchModelProtocol {
    private(set) var businesses = [Business]()
    private let businessSearchClient: BusinessSearchClientProtocol
    private weak var delegate: BusinessSearchModelDelegate?
    
    init(businessSearchClient: BusinessSearchClientProtocol, delegate: BusinessSearchModelDelegate) {
        self.businessSearchClient = businessSearchClient
        self.delegate = delegate
    }
    
    func search(for business: String, latitude: Double, longitude: Double, radius: Int, price: String, openNow: Bool) {
        guard let price = price.priceToInt else { return }
        
        delegate?.downloadDidBegin()
        DispatchQueue.global(qos: .userInitiated).async {
            self.businessSearchClient.search(for: business, latitude: latitude, longitude: longitude, radius: radius.milesToMeters, price: price, openNow: openNow) { [weak self] businesses in
                guard let `self` = self else { return }
                
                DispatchQueue.main.async {
                    self.businesses = businesses
                    self.delegate?.downloadDidEnd()
                }
            }
        }
    }
}
