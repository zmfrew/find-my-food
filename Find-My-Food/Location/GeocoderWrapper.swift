import CoreLocation

typealias CLGeocodeCompletionHandler = ([CLPlacemark]?, Error?) -> Void

final class GeocoderWrapper: GeocoderProtocol {
    private let geocoder = CLGeocoder()

    func geocodeAddressString(_ addressString: String, completionHandler: @escaping CLGeocodeCompletionHandler) {
        geocoder.geocodeAddressString(addressString, completionHandler: completionHandler)
    }
}
