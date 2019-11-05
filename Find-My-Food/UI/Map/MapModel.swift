import MapKit
import CoreLocation

protocol MapModelDelegate: class {
    func presentLocationDisabledAlert(title: String, message: String, enableSettingsLink: Bool)
    func set(_ placemarks: [MKPlacemark])
    func set(_ region: MKCoordinateRegion)
}

final class MapModel {
    private let geocoder: GeocoderProtocol!
    private let locationManager: LocationManagerProtocol!
    private weak var delegate: MapModelDelegate?

    var location: CLLocation? { locationManager.location }
    
    init(delegate: MapModelDelegate, geocoder: GeocoderProtocol, locationManager: LocationManagerProtocol) {
        self.delegate = delegate
        self.geocoder = geocoder
        self.locationManager = locationManager
        
        configure()
    }
    
    private func configure() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func fitRegion(to placemarks: [MKPlacemark]) {
        guard let location = location,
            let maxLatitude = placemarks.max(by: { $0.coordinate.latitude > $1.coordinate.latitude })?.coordinate.latitude,
            let maxLongitude = placemarks.max(by: { $0.coordinate.longitude > $1.coordinate.longitude })?.coordinate.longitude
        else { return }
        
        let newDistance = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude).distance(from: CLLocation(latitude: maxLatitude, longitude: maxLongitude)) //swiftlint:disable:this line_length
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 2.2 * newDistance, longitudinalMeters: 2.2 * newDistance)
        
        delegate?.set(region)
    }
    
    func geocode(_ address: String) {
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            guard let placemarks = placemarks?.compactMap(MKPlacemark.init),
                placemarks.isNotEmpty,
                error == nil else { return }
            
            self.delegate?.set(placemarks)
        }
    }
    
    func locationServicesDisabled() {
        delegate?.presentLocationDisabledAlert(title: "Your location services are disabled for this application.",
                             message: "Please go to settings and enable location services to better locate restaurants!",
                             enableSettingsLink: true)
    }
}
