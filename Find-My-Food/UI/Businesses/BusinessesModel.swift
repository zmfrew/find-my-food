import UIKit

protocol BusinessModelProtocol {
    var businessCount: Int { get }

    func business(for row: Int) -> Business?
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

    func randomBusiness() -> Business? {
        businesses.randomElement()
    }

    func image(for business: Business) {
        DispatchQueue.global(qos: .userInitiated).async {
            self.businessSearchClient.image(at: business.imageUrlString) { [weak self] data in
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
