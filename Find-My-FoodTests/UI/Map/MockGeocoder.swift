import Foundation
import CoreLocation

@testable import Find_My_Food

final class MockGeocoder: GeocoderProtocol {
    final class Stub {
        var geocodeAddressStringCallCount: Int { geocodeAddressStringCalledWith.count }
        var geocodeAddressStringCalledWith: [(addressString: String, completionHandler: CLGeocodeCompletionHandler)] = []
        var geocodeAddressStringShouldCompleteWith: (placemark: [CLPlacemark]?, error: Error?) = (nil, nil)
    }

    var stub = Stub()

    func parrotResetMock() {
        stub = Stub()
    }

    func geocodeAddressString(_ addressString: String, completionHandler: @escaping CLGeocodeCompletionHandler) {
        stub.geocodeAddressStringCalledWith.append((addressString, completionHandler))
        completionHandler(stub.geocodeAddressStringShouldCompleteWith.placemark, stub.geocodeAddressStringShouldCompleteWith.error)
    }
}
