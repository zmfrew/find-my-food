import MapKit

protocol GeocoderInterface {
    func geocodeAddressString(_ addressString: String, completionHandler: @escaping CLGeocodeCompletionHandler)
}

extension CLGeocoder: GeocoderInterface { }
