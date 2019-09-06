import UIKit

protocol BusinessSearchViewControllerDelegate: class {
    func downloadCompleted(with businesses: [Business])
    func downloadDidBegin()
    func presentNoBusinessesAlert()
}

final class BusinessSearchViewController: UIViewController {
    private var model: BusinessSearchModelInterface!
	private var searchView: BusinessSearchView { return self.view as! BusinessSearchView } //swiftlint:disable:this force_cast
    private var latitude: Double!
    private var longitude: Double!
    
    weak var delegate: BusinessSearchViewControllerDelegate?
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // TOOD: - Move BaseServiceClient's into an AppSession of some sort.
        let serviceClient = BaseServiceClient(urlSession: URLSessionWrapper())
		let businessSearchClient = BusinessSearchClient(serviceClient: serviceClient, networkIndicator: UIApplication.shared)
		model = BusinessSearchModel(businessSearchClient: businessSearchClient, delegate: self)
		
		searchView.delegate = self
    }
    
    func configure(latitude: Double, longitude: Double) { 
        self.latitude = latitude
        self.longitude = longitude
    }
}

extension BusinessSearchViewController {
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard let businessesVC = segue.destination as? BusinessesViewController,
			!model.businesses.isEmpty else { return }
		
		let businessesModel = BusinessesModel(businesses: model.businesses)
		
		businessesVC.configure(with: businessesModel)
	}
}

extension BusinessSearchViewController: BusinessSearchModelDelegate {
    func downloadDidBegin() {
        delegate?.downloadDidBegin()
    }
    
    func downloadDidEnd() {
		guard model.businesses.isNotEmpty() else {
			delegate?.presentNoBusinessesAlert()
			return
		}
		
        delegate?.downloadCompleted(with: model.businesses)
    }
}

extension BusinessSearchViewController: BusinessSearchViewDelegate {
	func search(for business: String) {
		model.search(for: business, latitude: latitude, longitude: longitude)
	}
}
