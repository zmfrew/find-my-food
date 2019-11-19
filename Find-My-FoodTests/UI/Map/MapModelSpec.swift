import Quick
import Nimble
import CoreLocation
import MapKit
import Contacts

@testable import Find_My_Food

final class MapModelSpec: QuickSpec {
    override func spec() {
        var testObject: MapModel!
        var mockDelegate: MockMapModelDelegate!
        var mockGeocoder: MockGeocoder!
        var mockLocationManager: MockLocationManager!
        
        beforeEach {
            mockDelegate = MockMapModelDelegate()
            mockGeocoder = MockGeocoder()
            mockLocationManager = MockLocationManager()
            
            testObject = MapModel(delegate: mockDelegate, geocoder: mockGeocoder, locationManager: mockLocationManager)
        }
        
        // MARK: - var location: CLLocation?
        describe("location: CLLocation?") {
            context("given location manager returns a CLLocation") {
                it("returns the same CLLocation") {
                    let expectedLocation = CLLocation(latitude: 100, longitude: 100)
                    mockLocationManager.stub.locationShouldReturn = expectedLocation
                    
                    expect(testObject.location).to(equal(expectedLocation))
                }
            }
            
            context("given location manager returns nil") {
                it("returns nil") {
                    mockLocationManager.stub.locationShouldReturn = nil
                    
                    expect(testObject.location).to(beNil())
                }
            }
        }
        
        //MARK: - func fitRegion(to placemarks: [MKPlacemark])
        describe("fitRegion(to placemarks: [MKPlacemark])") {
            context("given a valid location, maxLatitude, and maxLongitude") {
                it("calls set with a region on the delegate") {
                    let expectedLocation = CLLocation(latitude: 10.0, longitude: 10.0)
                    mockLocationManager.stub.locationShouldReturn = expectedLocation
                    let expectedPlacemarks = [
                        MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 100, longitude: 100)),
                        MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 300, longitude: 300))
                    ]
                    
                    testObject.fitRegion(to: expectedPlacemarks)
                    
                    let distance = CLLocation(latitude: expectedLocation.coordinate.latitude, longitude: expectedLocation.coordinate.longitude).distance(from: CLLocation(latitude: expectedPlacemarks.max(by: { $0.coordinate.latitude > $1.coordinate.latitude })!.coordinate.latitude, longitude: expectedPlacemarks.max(by: { $0.coordinate.longitude > $1.coordinate.longitude })!.coordinate.longitude))
                    let region = MKCoordinateRegion(center: expectedLocation.coordinate, latitudinalMeters: 2.2 * distance, longitudinalMeters: 2.2 * distance)
                    expect(mockDelegate.stub.setRegionCallCount).to(equal(1))
                    expect(mockDelegate.stub.setRegionCalledWith.first?.center.latitude).to(equal(region.center.latitude))
                    expect(mockDelegate.stub.setRegionCalledWith.first?.center.longitude).to(equal(region.center.longitude))
                    expect(mockDelegate.stub.setRegionCalledWith.first?.span.latitudeDelta).to(equal(region.span.latitudeDelta))
                    expect(mockDelegate.stub.setRegionCalledWith.first?.span.longitudeDelta).to(equal(region.span.longitudeDelta))
                }
            }
            
            context("given an invalid location") {
                it("does not call set(region) on the delegate") {
                    mockLocationManager.stub.locationShouldReturn = nil
                    let expectedPlacemarks = [
                        MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 100, longitude: 100)),
                        MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 300, longitude: 300))
                    ]
                    
                    testObject.fitRegion(to: expectedPlacemarks)
                    
                    expect(mockDelegate.stub.setRegionCallCount).to(equal(0))
                    expect(mockDelegate.stub.setRegionCalledWith).to(beEmpty())
                }
            }
            
            context("given an invalid maxLatitude and maxLongitude") {
                it("does not call set(region) on the delegate") {
                    mockLocationManager.stub.locationShouldReturn = CLLocation(latitude: 10.0, longitude: 10.0)
                    let expectedPlacemarks = [MKPlacemark]()
                    
                    testObject.fitRegion(to: expectedPlacemarks)
                    
                    expect(mockDelegate.stub.setRegionCallCount).to(equal(0))
                    expect(mockDelegate.stub.setRegionCalledWith).to(beEmpty())
                }
            }
        }
        
        // MARK: - func geocode(_ address: String)
        describe("geocode(_ address: String") {
            context("given placemarks that init to MKPlacemark") {
                it("calls set on the delegate") {
                    let expectedPlacemarks = [
                        MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 100, longitude: 100)),
                        MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 300, longitude: 300))
                    ]
                    let clPlacemarks = expectedPlacemarks.map { $0 as CLPlacemark }
                    mockGeocoder.stub.geocodeAddressStringShouldCompleteWith = (clPlacemarks, nil)
                    
                    testObject.geocode("test address")
                    
                    expect(mockDelegate.stub.setPlacemarksCallCount).toEventually(equal(1))
                    expect(mockDelegate.stub.setPlacemarksCalledWith.first?.first?.coordinate.latitude).toEventually(equal(expectedPlacemarks.first?.coordinate.latitude))
                    expect(mockDelegate.stub.setPlacemarksCalledWith.first?.first?.coordinate.longitude).toEventually(equal(expectedPlacemarks.first?.coordinate.longitude))
                    expect(mockDelegate.stub.setPlacemarksCalledWith.first?.last?.coordinate.latitude).toEventually(equal(expectedPlacemarks.last?.coordinate.latitude))
                    expect(mockDelegate.stub.setPlacemarksCalledWith.first?.last?.coordinate.longitude).toEventually(equal(expectedPlacemarks.last?.coordinate.longitude))
                }
            }
            
            context("given placemarks is empty") {
                it("does not call set on the delegate") {
                    mockGeocoder.stub.geocodeAddressStringShouldCompleteWith = ([], nil)
                    
                    testObject.geocode("test address")
                    
                    expect(mockDelegate.stub.setPlacemarksCallCount).toEventually(equal(0))
                    expect(mockDelegate.stub.setPlacemarksCalledWith.first).toEventually(beNil())
                }
            }
        }
        
        // MARK: - func locationServicesDisabled()
        describe("locationServicesDisabled()") {
            it("calls presentLocationDisabledAlert on the delegate") {
                testObject.locationServicesDisabled()
                
                expect(mockDelegate.stub.presentLocationDisabledAlertCallCount).to(equal(1))
                expect(mockDelegate.stub.presentLocationDisabledAlertCalledWith.first?.title).to(equal("Your location services are disabled for this application."))
                expect(mockDelegate.stub.presentLocationDisabledAlertCalledWith.first?.message).to(equal("Please go to settings and enable location services to better locate restaurants!"))
                expect(mockDelegate.stub.presentLocationDisabledAlertCalledWith.first?.enableSettingsLink).to(beTrue())
            }
        }
    }
}
