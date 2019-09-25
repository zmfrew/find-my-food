import UIKit
import CoreLocation
// TODO: - Use local cache if the search params are the same.
final class MapViewController: UIViewController, Storyboarded {
    private var model: MapModel!
    private var mapView: MapView { return view as! MapView } //swiftlint:disable:this force_cast
    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model = MapModel(delegate: self)
        mapView.delegate = self
        
        if let businessSearchVC = children.first(where: { $0 is BusinessSearchViewController}) as? BusinessSearchViewController {
            businessSearchVC.delegate = self
            businessSearchVC.view.layer.cornerRadius = 8
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        mapView.setRegion()
    }
}

extension MapViewController {
    private func presentLocationAlert(title: String, message: String, enableSettingsLink: Bool) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if enableSettingsLink {
            alert.addAction(UIAlertAction(title: "Go to Settings", style: .default) { (_) in
                if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
                }
            })
        }
    }
}

extension MapViewController: MapModelDelegate {
    func presentLocationDisabledAlert(title: String, message: String, enableSettingsLink: Bool) {
        presentLocationAlert(title: title, message: message, enableSettingsLink: enableSettingsLink)
    }
}

extension MapViewController: MapViewDelegate {
    var location: CLLocation? { return model.location }
    
    func locationServicesDisabled() {
        model.locationServicesDisabled()
    }
    
    func searchButtonTapped() {
        if let latitude = model.location?.coordinate.latitude,
            let longitude = model.location?.coordinate.longitude {
            coordinator?.searchButtonTapped(latitude: latitude, longitude: longitude)
        }
    }
}

extension MapViewController: BusinessSearchViewControllerDelegate {
    func downloadDidBegin() {
        mapView.downloadDidBegin()
    }
    
    func downloadCompleted(with businesses: [Business]) {
        mapView.downloadDidEnd()
        
        if businesses.isEmpty {
            presentNoBusinessesAlert()
        } else {
            coordinator?.downloadCompleted(with: businesses)
        }
    }
    
    private func presentNoBusinessesAlert() {
        let alert = UIAlertController(title: "Oh no!",
                                      message: "We couldn't find any results. Please try a different search.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
