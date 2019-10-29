import CoreLocation

typealias Location = CLLocation

final class LocationManagerWrapper: LocationManagerInterface {
    private let locationManager = CLLocationManager()

    var location: CLLocation? {
        return locationManager.location
    }

    func requestWhenInUseAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }

    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
}
