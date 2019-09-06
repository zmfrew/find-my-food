import Foundation

protocol BusinessSearchModelInterface {
    var businesses: [Business] { get }
    func search(for business: String, latitude: Double, longitude: Double)
}

protocol BusinessSearchModelDelegate: class {
    func downloadDidBegin()
    func downloadDidEnd()
}

final class BusinessSearchModel: BusinessSearchModelInterface {
    private(set) var businesses: [Business] = []
    private let businessSearchClient: BusinessSearchClientInterface
    private weak var delegate: BusinessSearchModelDelegate?
    
	init(businessSearchClient: BusinessSearchClientInterface, delegate: BusinessSearchModelDelegate) {
        self.businessSearchClient = businessSearchClient
		self.delegate = delegate
    }
    
    func search(for business: String, latitude: Double, longitude: Double) {
        delegate?.downloadDidBegin()
        DispatchQueue.global(qos: .userInitiated).async {
            self.businessSearchClient.search(for: business, latitude: latitude, longitude: longitude) { [weak self] businesses in
                guard let `self` = self else { return }
             
                DispatchQueue.main.async {
                    self.businesses = businesses
                    self.delegate?.downloadDidEnd()
                }
            }
        }
    }
}
