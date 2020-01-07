import Quick
import Nimble

@testable import Find_My_Food

final class BusinessSearchModelSpec: QuickSpec {
    override func spec() {
        var testObject: BusinessSearchModel!
        var mockBusinessSearchClient: MockBusinessSearchClient!
        var mockDelegate: MockBusinessSearchModelDelegate!
        var mockSession: MockUserSession!
        
        beforeEach {
            mockBusinessSearchClient = MockBusinessSearchClient()
            mockDelegate = MockBusinessSearchModelDelegate()
            mockSession = MockUserSession()
            testObject = BusinessSearchModel(businessSearchClient: mockBusinessSearchClient, delegate: mockDelegate, session: mockSession)
        }
        
        // MARK: - func deSelected(_ price: String)
        describe("deSelected(_ price: String)") {
            context("given price is in selectedPrices") {
                it("removes the price") {
                    testObject.selected("$$")
                    testObject.selected("$$$$")
                    testObject.selected("$")
                    
                    testObject.deSelected("$$")
                    testObject.deSelected("$$$$")
                    testObject.deSelected("$")
                    
                    expect(testObject.selectedPrices).to(equal([]))
                }
            }
            
            context("given price is not in selectedPrices") {
                it("does nothing") {
                    let expectedPrices = ["$$", "$$$$", "$"]
                    testObject.selected("$$")
                    testObject.selected("$$$$")
                    testObject.selected("$")
                    
                    testObject.deSelected("$$$")
                    testObject.deSelected("$$$")
                    testObject.deSelected("$$$")
                    
                    expect(testObject.selectedPrices).to(equal(expectedPrices))
                }
            }
        }
        
        // MARK: - func loadDefaults() -> (radius: Int, location: String?)
        describe("loadDefaults() -> (radius: Int, location: String?)") {
            context("given session.userDefaults.object(forkey:) returns a radius and location") {
                it("returns a radius and location") {
                    mockSession.stub.userDefaultsShouldReturn.stub.objectCalledWithRadiusIndex = 8
                    mockSession.stub.userDefaultsShouldReturn.stub.objectCalledWithDefaultLocation = "Breckenridge, CO"
                    
                    let (radius, location) = testObject.loadDefaults()
                    expect(radius).to(equal(8))
                    expect(location).to(equal("Breckenridge, CO"))
                }
            }
            
            context("given session.userDefaults.object(forkey:) returns a nil for radius and location") {
                it("returns Radius.max and nil for location") {
                    mockSession.stub.userDefaultsShouldReturn.stub.objectCalledWithRadiusIndex = nil
                    mockSession.stub.userDefaultsShouldReturn.stub.objectCalledWithDefaultLocation = nil
                    
                    let (radius, location) = testObject.loadDefaults()
                    expect(radius).to(equal(24))
                    expect(location).to(beNil())
                }
            }
        }
        
        // MARK: - func presentLocationError()
        describe("presentLocationError()") {
            it("calls present with an alert on the delegate") {
                let expectedAlert = UIAlertController(title: "Oh no!",
                                              message: "Please activate location services or enter a location to search for restaurants!",
                                              preferredStyle: .alert)
                expectedAlert.addAction(UIAlertAction(title: "Ok", style: .default))
                
                testObject.presentLocationError()
               
                expect(mockDelegate.stub.presentCallCount).to(equal(1))
                expect((mockDelegate.stub.presentCalledWith.first?.viewControllerToPresent as? UIAlertController)?.message).to(equal(expectedAlert.message))
                expect((mockDelegate.stub.presentCalledWith.first?.viewControllerToPresent as? UIAlertController)?.title).to(equal(expectedAlert.title))
                expect((mockDelegate.stub.presentCalledWith.first?.viewControllerToPresent as? UIAlertController)?.preferredStyle).to(equal(expectedAlert.preferredStyle))
            }
        }
        
        // MARK: - func search(for business: String)
        describe("search(for business:)") {
            context("given businessSearchClient returns businesses") {
                it("sets businesses") {
                    let expectedBusinesses = [
                        TestData.createBusiness(),
                        TestData.createBusiness()
                    ]
                    
                    mockBusinessSearchClient.stub.searchShouldCompleteWith = expectedBusinesses
                    
                    testObject.search(for: "Peel", latitude: 38.752209, location: nil, longitude: -89.986610, radius: 0, prices: ["$"], openNow: false)
                   
                    expect(mockDelegate.stub.downloadDidBeginCallCount).toEventually(equal(1))
                    expect(mockDelegate.stub.downloadDidEndCallCount).toEventually(equal(1))
                    expect(testObject.businesses).toEventually(equal(expectedBusinesses))
                }
            }
            
            context("given businessSearchClient returns an empty array") {
                it("sets businesses as an empty array") {
                    let expectedBusinesses = [Business]()
                    
                    mockBusinessSearchClient.stub.searchShouldCompleteWith = expectedBusinesses
                    
                    testObject.search(for: "Chophouse", latitude: 38.752209, location: nil, longitude: -89.986610, radius: 0, prices: ["$$"], openNow: false)
                    
                    expect(mockDelegate.stub.downloadDidBeginCallCount).toEventually(equal(1))
                    expect(mockDelegate.stub.downloadDidEndCallCount).toEventually(equal(1))
                    expect(testObject.businesses).toEventually(equal(expectedBusinesses))
                }
            }
        }
        
        // MARK: - func selected(_ price: String)
        describe("selected(_ price: String)") {
            context("given price is not in selectedPrices") {
                it("adds the price") {
                    let expectedPrices = ["$$", "$$$$", "$"]
                    
                    testObject.selected("$$")
                    testObject.selected("$$$$")
                    testObject.selected("$")
                    
                    expect(testObject.selectedPrices).to(equal(expectedPrices))
                }
            }
            
            context("given price is in selectedPrices") {
                it("does nothing") {
                    let expectedPrices = ["$$$"]
                    
                    testObject.selected("$$$")
                    testObject.selected("$$$")
                    testObject.selected("$$$")
                    
                    expect(testObject.selectedPrices).to(equal(expectedPrices))
                }
            }
        }
    }
}
