import UIKit

protocol BusinessModelProtocol {
    var businessCount: Int { get }

    func business(for row: Int) -> Business?
    func favorite(at index: Int)
    func image(for business: Business)
    func randomBusiness() -> Business?
}

protocol BusinessesModelDelegate: class {
    func dataDidUpdate()
}

final class BusinessesModel: BusinessModelProtocol {
    private var businesses: [Business] {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.dataDidUpdate()
            }
        }
    }
    private let businessSearchClient: BusinessSearchClientProtocol
    var businessCount: Int { businesses.count }

    weak var delegate: BusinessesModelDelegate?

    init(businesses: [Business], businessSearchClient: BusinessSearchClientProtocol, delegate: BusinessesModelDelegate) {
        self.businesses = businesses
        self.businessSearchClient = businessSearchClient
        self.delegate = delegate

        businesses.forEach { image(for: $0) }
    }

    func business(for row: Int) -> Business? {
        businesses.element(at: row)
    }

    func favorite(at index: Int) {
        guard let business = business(for: index) else { return }
        
        // TODO: - Save to CoreData
        // if successful, change the star to be filled in.
    }

    func randomBusiness() -> Business? {
        businesses.randomElement()
    }

    func image(for business: Business) {
        DispatchQueue.global(qos: .userInitiated).async {
            self.businessSearchClient.image(at: business.imageURLString) { [weak self] data in
                guard let self = self else { return }

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
