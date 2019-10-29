import MapKit

@testable import Find_My_Food

final class MockMapModelDelegate: MapModelDelegate {
    final class Stub {
        var presentLocationDisabledAlertCallCount: Int { return presentLocationDisabledAlertCalledWith.count }
        var presentLocationDisabledAlertCalledWith = [(title: String, message: String, enableSettingsLink: Bool)]()
        var setCallCount: Int { return setCalledWith.count }
        var setCalledWith = [[MKPlacemark]]()
    }

    var stub = Stub()

    func presentLocationDisabledAlert(title: String, message: String, enableSettingsLink: Bool) {
        stub.presentLocationDisabledAlertCalledWith.append((title, message, enableSettingsLink))
    }

    func set(_ placemarks: [MKPlacemark]) {
        stub.setCalledWith.append(placemarks)
    }
}

