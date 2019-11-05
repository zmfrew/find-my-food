import CoreLocation

protocol LocationManagerProtocol {
    var location: CLLocation? { get }
    func requestWhenInUseAuthorization()
    func startUpdatingLocation()
}

extension CLLocationManager: LocationManagerProtocol { }
