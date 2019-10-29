import CoreLocation

@testable import Find_My_Food

final class MockLocationManager: LocationManagerInterface {
    final class Stub {
        var locationShouldReturn: CLLocation? = nil
        var requestWhenInUseAuthorizationCallCount = 0
        var startUpdatingLocationCallCount = 0
    }
    
    var stub = Stub()
    
    var location: CLLocation? {
        stub.locationShouldReturn
    }
    
    func requestWhenInUseAuthorization() {
        stub.requestWhenInUseAuthorizationCallCount += 1
    }
    
    func startUpdatingLocation() {
        stub.startUpdatingLocationCallCount += 1
    }
    
    
}

