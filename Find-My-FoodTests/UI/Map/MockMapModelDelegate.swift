import MapKit

@testable import Find_My_Food

final class MockMapModelDelegate: MapModelDelegate {
    final class Stub {
        var presentLocationDisabledAlertCallCount: Int { return presentLocationDisabledAlertCalledWith.count }
        var presentLocationDisabledAlertCalledWith = [(title: String, message: String, enableSettingsLink: Bool)]()
        var setPlacemarksCallCount: Int { return setPlacemarksCalledWith.count }
        var setPlacemarksCalledWith = [[MKPlacemark]]()
        var setRegionCallCount: Int { setRegionCalledWith.count }
        var setRegionCalledWith = [MKCoordinateRegion]()
    }

    var stub = Stub()

    func presentLocationDisabledAlert(title: String, message: String, enableSettingsLink: Bool) {
        stub.presentLocationDisabledAlertCalledWith.append((title, message, enableSettingsLink))
    }

    func set(_ placemarks: [MKPlacemark]) {
        stub.setPlacemarksCalledWith.append(placemarks)
    }
    
    func set(_ region: MKCoordinateRegion) {
        
    }
}

