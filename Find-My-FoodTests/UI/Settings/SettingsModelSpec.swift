import Quick
import Nimble

@testable import Find_My_Food

final class SettingsModelSpec: QuickSpec {
    override func spec() {
        var testObject: SettingsModel!
        var mockRadiusData: [Int]!
        var mockDelegate: MockSettingsModelDelegate!
        var mockUserDefaults: MockUserDefaults!
        
        beforeEach {
            mockRadiusData = Radius.range
            mockDelegate = MockSettingsModelDelegate()
            mockUserDefaults = MockUserDefaults()
            testObject = SettingsModel(radiusData: mockRadiusData, delegate: mockDelegate, userDefaults: mockUserDefaults)
        }
        
        // MARK: - var radiusCount: Int
        describe("radiusCount: Int") {
            context("given radiusData is not empty") {
                it("returns the count of radiusData") {
                    
                }
            }
            
            context("given radiusData is empty") {
                it("returns 0") {
                    
                }
            }
        }
        
        // MARK: - func loadDefaults()
        describe("loadDefaults()") {
            it("calls dataDidUpdate on the delegate with the loaded data") {
                
            }
        }
        
        // MARK: - func radius(at index: Int) -> Int
        describe("radius(at index: Int) -> Int") {
            context("given a valid index") {
                it("returns the element at the index") {
                    
                }
            }
            
            context("given an invalid index") {
                it("returns 24") {
                    
                }
            }
        }
        
        // MARK: - func selectedDefaults(darkMode: Bool, defaultLocation: String?, radiusIndex: Int)
        describe("selectedDefaults(darkMode: Bool, defaultLocation: String?, radiusIndex: Int)") {
            context("given defaultLocation is not nil") {
                it("sets defaults for all provided keys") {
                    
                }
            }
            
            context("given location is nil") {
                it("sets defaults on all provided keys except DefaultLocation") {
                    
                }
            }
        }
    }
}
