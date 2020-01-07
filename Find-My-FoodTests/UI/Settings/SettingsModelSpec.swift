import Quick
import Nimble

@testable import Find_My_Food

final class SettingsModelSpec: QuickSpec {
    override func spec() {
        var testObject: SettingsModel!
        var mockDelegate: MockSettingsModelDelegate!
        var mockUserDefaults: MockUserDefaults!
        
        beforeEach {
            mockDelegate = MockSettingsModelDelegate()
            mockUserDefaults = MockUserDefaults()
            testObject = SettingsModel(radiusData: Radius.range, delegate: mockDelegate, userDefaults: mockUserDefaults)
        }
        
        // MARK: - var radiusCount: Int
        describe("radiusCount: Int") {
            context("given radiusData is not empty") {
                it("returns the count of radiusData") {
                    expect(testObject.radiusCount).to(equal(Radius.range.count))
                }
            }
            
            context("given radiusData is empty") {
                it("returns 0") {
                    testObject = SettingsModel(radiusData: [], delegate: mockDelegate, userDefaults: mockUserDefaults)
                    
                    expect(testObject.radiusCount).to(equal(0))
                }
            }
        }
        
        // MARK: - func loadDefaults()
        describe("loadDefaults()") {
            context("given all keys exist in user defaults") {
                it("calls dataDidUpdate on the delegate with the loaded data") {
                    mockUserDefaults.stub.objectCalledWithDarkMode = true
                    mockUserDefaults.stub.objectCalledWithDefaultLocation = "test default location"
                    mockUserDefaults.stub.objectCalledWithRadiusIndex = 0
                    
                    testObject.loadDefaults()
                    
                    expect(mockDelegate.stub.dataDidUpdateCallCount).to(equal(1))
                    expect(mockDelegate.stub.dataDidUpdateCalledWith.first?.darkMode).to(beTrue())
                    expect(mockDelegate.stub.dataDidUpdateCalledWith.first?.location).to(equal("test default location"))
                    expect(mockDelegate.stub.dataDidUpdateCalledWith.first?.selectRadius).to(equal(0))
                }
            }
            
            context("given the keys do not exist in user defaults") {
                it("calls dataDidUpdate on the delegate with the nil coalesced values") {
                    mockUserDefaults.stub.objectCalledWithDarkMode = nil
                    mockUserDefaults.stub.objectCalledWithDefaultLocation = nil
                    mockUserDefaults.stub.objectCalledWithRadiusIndex = nil
                    
                    testObject.loadDefaults()
                    
                    expect(mockDelegate.stub.dataDidUpdateCallCount).to(equal(1))
                    expect(mockDelegate.stub.dataDidUpdateCalledWith.first?.darkMode).to(beFalse())
                    expect(mockDelegate.stub.dataDidUpdateCalledWith.first?.location).to(beNil())
                    expect(mockDelegate.stub.dataDidUpdateCalledWith.first?.selectRadius).to(equal(24))
                }
            }
        }
        
        // MARK: - func radius(at index: Int) -> Int
        describe("radius(at index: Int) -> Int") {
            context("given a valid index") {
                it("returns the element at the index") {
                    expect(testObject.radius(at: -0)).to(equal(0))
                    expect(testObject.radius(at: 0)).to(equal(0))
                    expect(testObject.radius(at: 16)).to(equal(16))
                    expect(testObject.radius(at: 24)).to(equal(24))
                }
            }
            
            context("given an invalid index") {
                it("returns 24") {
                    expect(testObject.radius(at: -1)).to(equal(Radius.rangeMax))
                    expect(testObject.radius(at: 25)).to(equal(Radius.rangeMax))
                    expect(testObject.radius(at: 100)).to(equal(Radius.rangeMax))
                }
            }
        }
        
        // MARK: - func selectedDefaults(darkMode: Bool, defaultLocation: String?, radiusIndex: Int)
        describe("selectedDefaults(darkMode: Bool, defaultLocation: String?, radiusIndex: Int)") {
            context("given defaultLocation is not nil") {
                it("sets defaults for all provided keys") {
                    testObject.selectedDefaults(darkMode: false, defaultLocation: "test default", radiusIndex: 0)
                    
                    expect(mockUserDefaults.stub.setCallCount).to(equal(3))
                    expect(mockDelegate.stub.saveDidEndCallCount).to(equal(1))
                    
                    expect(mockUserDefaults.stub.setCalledWith.first?.value as? Bool).to(beFalse())
                    expect(mockUserDefaults.stub.setCalledWith.first?.forKey).to(equal(UserDefaultKey.darkMode))
                    
                    expect(mockUserDefaults.stub.setCalledWith.element(at: 1)?.value as? String).to(equal("test default"))
                    expect(mockUserDefaults.stub.setCalledWith.element(at: 1)?.forKey).to(equal(UserDefaultKey.defaultLocation))
                    
                    expect(mockUserDefaults.stub.setCalledWith.last?.value as? Int).to(equal(0))
                    expect(mockUserDefaults.stub.setCalledWith.last?.forKey).to(equal(UserDefaultKey.radiusIndex))
                }
            }
            
            context("given location is nil") {
                it("sets defaults on all keys") {
                    testObject.selectedDefaults(darkMode: false, defaultLocation: nil, radiusIndex: 0)
                    
                    expect(mockUserDefaults.stub.setCallCount).to(equal(3))
                    expect(mockDelegate.stub.saveDidEndCallCount).to(equal(1))
                    
                    expect(mockUserDefaults.stub.setCalledWith.first?.value as? Bool).to(beFalse())
                    expect(mockUserDefaults.stub.setCalledWith.first?.forKey).to(equal(UserDefaultKey.darkMode))
                    
                    expect(mockUserDefaults.stub.setCalledWith.element(at: 1)?.value as? String).to(beNil())
                    expect(mockUserDefaults.stub.setCalledWith.element(at: 1)?.forKey).to(equal(UserDefaultKey.defaultLocation))
                    
                    expect(mockUserDefaults.stub.setCalledWith.last?.value as? Int).to(equal(0))
                    expect(mockUserDefaults.stub.setCalledWith.last?.forKey).to(equal(UserDefaultKey.radiusIndex))
                }
            }
        }
    }
}
