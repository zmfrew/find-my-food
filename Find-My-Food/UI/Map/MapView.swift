import UIKit
import MapKit

protocol MapViewDelegate: class {
    var location: CLLocation? { get }
    func locationServicesDisabled()
    func searchButtonTapped()
}

final class MapView: UIView {
    @IBOutlet private weak var map: MKMapView!
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var containerView: UIView!
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    weak var delegate: MapViewDelegate?
    
    override func awakeFromNib() {
        containerView.isHidden = true
        searchButton.layer.cornerRadius = searchButton.frame.width / 2
        map.showsUserLocation = true
    }
        
    @IBAction private func searchButtonTapped(_ sender: Any) {
        guard CLLocationManager.authorizationStatus() == .authorizedWhenInUse else {
            delegate?.locationServicesDisabled()
            return
        }
        
        delegate?.searchButtonTapped()
        containerView.isHidden = false
    }
}

extension MapView {
    func hideSearchButton() {
        searchButton.isHidden = true
    }
    
    func setRegion() {
        if let location = delegate?.location?.coordinate {
            let viewRegion = MKCoordinateRegion(center: location, latitudinalMeters: 200, longitudinalMeters: 200)
            map.setRegion(viewRegion, animated: false)
        }
    }
    
    func toggleContainerView() {
        containerView.isHidden = !containerView.isHidden
    }
}

extension MapView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if touch?.view == self {
            self.resignFirstResponder()
        }
    }
}
