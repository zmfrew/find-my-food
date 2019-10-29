import MapKit
import CoreLocation

protocol MapModelDelegate: class {
    func presentLocationDisabledAlert(title: String, message: String, enableSettingsLink: Bool)
    func set(_ placemarks: [MKPlacemark])
}

final class MapModel {
    private let geocoder = GeocoderWrapper()
    private let locationManager = LocationManagerWrapper()
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
    
    func geocode(_ address: String) {
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            guard let placemarks = placemarks?.compactMap(MKPlacemark.init) else {
                print("Error occurred geocoding: \(error!.localizedDescription)")
                return
            }
            
            self.delegate?.set(placemarks)
        }
    }
    
    func locationServicesDisabled() {
        delegate?.presentLocationDisabledAlert(title: "Your location services are disabled for this application.",
                             message: "Please go to settings and enable location services to better locate restaurants!",
                             enableSettingsLink: true)
    }
}
