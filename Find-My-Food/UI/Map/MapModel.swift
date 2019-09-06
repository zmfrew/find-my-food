import MapKit
import CoreLocation

protocol MapModelDelegate: class {
    func presentLocationDisabledAlert(title: String, message: String, enableSettingsLink: Bool)
}

final class MapModel {
    private let locationManager = CLLocationManager()
    private weak var delegate: MapModelDelegate?

    var location: CLLocation? { return locationManager.location }
    
    init(delegate: MapModelDelegate) {
        self.delegate = delegate
        
        configure()
    }
    
    private func configure() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationServicesDisabled() {
        delegate?.presentLocationDisabledAlert(title: "Your location services are disabled for this application.",
                             message: "Please go to settings and enable location services to better locate restaurants!",
                             enableSettingsLink: true)
    }
}
