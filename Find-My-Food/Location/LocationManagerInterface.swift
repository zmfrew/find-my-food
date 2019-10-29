import CoreLocation

protocol LocationManagerInterface {
    var location: CLLocation? { get }
    func requestWhenInUseAuthorization()
    func startUpdatingLocation()
}

extension CLLocationManager: LocationManagerInterface { }
