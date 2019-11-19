import CoreLocation
import MapKit
import UIKit
// TODO: - Use local cache if the search params are the same.
final class MapViewController: UIViewController, Storyboarded {
    private var model: MapModel!
    private var mapView: MapView { view as! MapView } //swiftlint:disable:this force_cast
    weak var coordinator: BusinessCoordinatorProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        model = MapModel(delegate: self, geocoder: GeocoderWrapper(), locationManager: LocationManagerWrapper())
        mapView.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        mapView.setRegion()
    }
}

extension MapViewController {
    func hideSearchButton() {
        mapView.hideSearchButton()
    }

    func setBusinessLocation(_ address: String) {
        model.geocode(address)
    }
}

extension MapViewController {
    private func presentLocationAlert(title: String, message: String, enableSettingsLink: Bool) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .destructive))

        if enableSettingsLink {
            alert.addAction(UIAlertAction(title: "Go to Settings", style: .default) { _ in
                if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
                }
            })
        }

        present(alert, animated: true)
    }
}

extension MapViewController: MapModelDelegate {
    func presentLocationDisabledAlert(title: String, message: String, enableSettingsLink: Bool) {
        presentLocationAlert(title: title, message: message, enableSettingsLink: enableSettingsLink)
    }

    func set(_ placemarks: [MKPlacemark]) {
        mapView.set(placemarks)
    }

    func set(_ region: MKCoordinateRegion) {
        mapView.set(region)
    }
}

extension MapViewController: MapViewDelegate {
    var location: CLLocation? { model.location }

    func fitRegion(to placemarks: [MKPlacemark]) {
        model.fitRegion(to: placemarks)
    }

    func locationServicesDisabled() {
        model.locationServicesDisabled()
    }

    func searchButtonTapped() {
        if let latitude = model.location?.coordinate.latitude,
            let longitude = model.location?.coordinate.longitude {
            coordinator?.searchButtonTapped(latitude: latitude, longitude: longitude)
        } else {
            model.locationServicesDisabled()
        }
    }
}

extension MapViewController: BusinessSearchViewControllerDelegate {
    func downloadCompleted(with businesses: [Business]) {
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
