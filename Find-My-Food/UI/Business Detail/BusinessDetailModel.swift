protocol BusinessDetailModelProtocol {
    var business: Business { get }

    func favorite()
}

protocol BusinessDetailModelDelegate: class {
    func saveDidFail()
    func saveDidSucceed()
}

final class BusinessDetailModel: BusinessDetailModelProtocol {
    private(set) var business: Business
    private let coreDataManager: CoreDataManagerProtocol
    private weak var delegate: BusinessDetailModelDelegate?

    init(business: Business, coreDataManager: CoreDataManagerProtocol, delegate: BusinessDetailModelDelegate) {
        self.business = business
        self.coreDataManager = coreDataManager
        self.delegate = delegate
    }

    func favorite() {
        coreDataManager.save([business]) { result in
            switch result {
            case .success:
                self.delegate?.saveDidSucceed()

            case .failure(let error):
                self.delegate?.saveDidFail()
                print("Error occurred saving data: \(error.localizedDescription)")
            }
        }
    }
}
