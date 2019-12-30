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
    func saveDidFail()
    func saveDidSucceed(at index: Int)
}

final class BusinessesModel: BusinessModelProtocol {
    private var businesses: [Business] {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.dataDidUpdate()
            }
        }
    }
    var businessCount: Int { businesses.count }
    private let businessSearchClient: BusinessSearchClientProtocol
    private let coreDataManager: CoreDataManagerProtocol

    weak var delegate: BusinessesModelDelegate?

    init(businesses: [Business],
         businessSearchClient: BusinessSearchClientProtocol,
         coreDataManager: CoreDataManagerProtocol,
         delegate: BusinessesModelDelegate) {
        self.businesses = businesses
        self.businessSearchClient = businessSearchClient
        self.coreDataManager = coreDataManager
        self.delegate = delegate

        businesses.forEach { image(for: $0) }
    }

    func business(for row: Int) -> Business? {
        businesses.element(at: row)
    }

    func favorite(at index: Int) {
        guard let business = business(for: index) else {
            delegate?.saveDidFail()
            return
        }

        coreDataManager.save([business]) { result in
            switch result {
            case .success:

                self.businesses[index] = business.copy(isFavorite: true)
                self.delegate?.saveDidSucceed(at: index)

            case .failure(let error):
                self.delegate?.saveDidFail()
                print("Error occurred saving data: \(error.localizedDescription)")
            }
        }
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
