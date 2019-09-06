import Quick
import Nimble

@testable import Find_My_Food

final class MapModelSpec: QuickSpec {
    override func spec() {
        var testObject: MapModel!
        var mockDelegate: MockMapModelDelegate!
        
        beforeEach {
            mockDelegate = MockMapModelDelegate()
            testObject = MapModel(delegate: mockDelegate)
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
