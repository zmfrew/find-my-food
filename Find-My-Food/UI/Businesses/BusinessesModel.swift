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
                print("data updated")
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
    
    func image(for business: Business) {
        DispatchQueue.global(qos: .userInitiated).async {
            self.businessSearchClient.image(at: business.imageUrlString) { [weak self] data in
                guard let `self` = self else { return }
                
                if let data = data,
                    let image = UIImage(data: data) {
                    
                    let newBusiness = business.copy(image: image)
                    
                    let index = self.businesses.firstIndex(of: business)!
                    self.businesses[index] = newBusiness
                }
            }
        }
    }
}
