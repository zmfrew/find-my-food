import UIKit

protocol BusinessModelInterface {
    func business(for row: Int) -> Business?
    func image(for business: Business)
    func randomBusiness() -> Business?
    var businessCount: Int { get }
}

protocol BusinessesModelDelegate: class {
    func dataDidUpdate()
}

final class BusinessesModel: BusinessModelInterface {
    private var businesses: [Business] {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.dataDidUpdate()
            }
        }
    }
    private let businessSearchClient: BusinessSearchClientInterface
    var businessCount: Int { return businesses.count }
    
    weak var delegate: BusinessesModelDelegate?
    
    init(businesses: [Business], businessSearchClient: BusinessSearchClientInterface, delegate: BusinessesModelDelegate) {
        self.businesses = businesses
        self.businessSearchClient = businessSearchClient
        self.delegate = delegate
        
        businesses.forEach { image(for: $0) }
    }
    
    func business(for row: Int) -> Business? {
        return businesses.element(at: row)
    }
    
    func randomBusiness() -> Business? {
        return businesses.randomElement()
    }
    // TODO: - Write tests
    func image(for business: Business) {
        DispatchQueue.global(qos: .userInitiated).async {
            self.businessSearchClient.image(at: business.imageUrlString) { [weak self] data in
                guard let `self` = self else { return }
                
                if let data = data,
                    let image = UIImage(data: data) {
                    let newBusiness = Business(id: business.id,
                                               alias: business.alias,
                                               name: business.name,
                                               imageUrlString: business.imageUrlString,
                                               image: image,
                                               isClosed: business.isClosed,
                                               urlString: business.urlString,
                                               reviewCount: business.reviewCount,
                                               categories: business.categories,
                                               rating: business.rating,
                                               coordinates: business.coordinates,
                                               transactions: business.transactions,
                                               priceLevel: business.priceLevel,
                                               location: business.location,
                                               phone: business.phone,
                                               displayPhone: business.displayPhone,
                                               distance: business.distance)
                    
                    let index = self.businesses.firstIndex(of: business)!
                    self.businesses.remove(at: index)
                    self.businesses.insert(newBusiness, at: index)
                }
            }
        }
    }
}
