import CoreLocation

typealias Location = CLLocation

final class LocationManagerWrapper: LocationManagerInterface {
    private let locationManager = CLLocationManager()

    var location: CLLocation? {
        locationManager.location
    }

    func requestWhenInUseAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }

    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
}
