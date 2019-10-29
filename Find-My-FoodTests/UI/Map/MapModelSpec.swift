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
        
        // MARK: - location: CLLocation?
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
        
        // MARK: - geocode(_ address: String)
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
                    
                    expect(mockDelegate.stub.setCallCount).toEventually(equal(1))
                    expect(mockDelegate.stub.setCalledWith.first?.first?.coordinate.latitude).toEventually(equal(expectedPlacemarks.first?.coordinate.latitude))
                    expect(mockDelegate.stub.setCalledWith.first?.first?.coordinate.longitude).toEventually(equal(expectedPlacemarks.first?.coordinate.longitude))
                    expect(mockDelegate.stub.setCalledWith.first?.last?.coordinate.latitude).toEventually(equal(expectedPlacemarks.last?.coordinate.latitude))
                    expect(mockDelegate.stub.setCalledWith.first?.last?.coordinate.longitude).toEventually(equal(expectedPlacemarks.last?.coordinate.longitude))
                }
            }
            
            context("given placemarks is empty") {
                it("does not call set on the delegate") {
                    mockGeocoder.stub.geocodeAddressStringShouldCompleteWith = ([], nil)
                    
                    testObject.geocode("test address")
                    
                    expect(mockDelegate.stub.setCallCount).toEventually(equal(0))
                    expect(mockDelegate.stub.setCalledWith.first).toEventually(beNil())
                }
            }
        }
        
        // MARK: - locationServicesDisabled()
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
