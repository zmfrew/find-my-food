import MapKit
import UIKit

protocol MapViewDelegate: class {
    var location: CLLocation? { get }

    func fitRegion(to: [MKPlacemark])
    func searchButtonTapped()
}

final class MapView: UIView {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var map: MKMapView!
    @IBOutlet private weak var searchButton: UIButton!
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    weak var delegate: MapViewDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.isHidden = true
        searchButton.layer.cornerRadius = searchButton.frame.width / 2
        map.showsUserLocation = true
        map.delegate = self
    }

    @IBAction private func searchButtonTapped(_ sender: Any) {
        delegate?.searchButtonTapped()
        containerView.isHidden = false
    }
}

extension MapView {
    func hideSearchButton() {
        searchButton.isHidden = true
    }

    func set(_ placemarks: [MKPlacemark]) {
        map.addAnnotations(placemarks)
        map.showAnnotations(placemarks, animated: true)

        delegate?.fitRegion(to: placemarks)
    }

    func set(_ region: MKCoordinateRegion) {
        let adjustRegion = map.regionThatFits(region)
        map.setRegion(adjustRegion, animated: true)
    }

    func setRegion() {
        if let location = delegate?.location?.coordinate {
            let viewRegion = MKCoordinateRegion(center: location, latitudinalMeters: 200, longitudinalMeters: 200)
            map.setRegion(viewRegion, animated: false)
        }
    }

    func toggleContainerView() {
        containerView.isHidden.toggle()
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

extension MapView: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let placemark = view.annotation as? MKPlacemark else { return }

        let mapItem = MKMapItem(placemark: placemark)

        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        mapItem.openInMaps(launchOptions: launchOptions)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? MKPlacemark else { return nil }

        let identifier = "marker"
        var view: MKMarkerAnnotationView

        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 50, height: 50)))
            mapsButton.setBackgroundImage(UIImage(named: "car"), for: UIControl.State())
            mapsButton.setTitle("Driving Directions", for: UIControl.State())
            view.rightCalloutAccessoryView = mapsButton
        }

        return view
    }
}
