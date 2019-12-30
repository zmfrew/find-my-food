import Quick
import Nimble

@testable import Find_My_Food

final class FavoritesModelSpec: QuickSpec {
    override func spec() {
        var testObject: FavoritesModel!
        var mockDelegate: MockFavoritesModelDelegate!
        var mockFRC: MockBusinessFetchedResultsController!
        
        beforeEach {
            mockDelegate = MockFavoritesModelDelegate()
            mockFRC = MockBusinessFetchedResultsController()
            testObject = FavoritesModel(delegate: mockDelegate, frc: mockFRC)
        }
        
        // MARK: - var businessCount: Int
        describe("businessCount") {
            it("returns the count from frc.numberOfObjects(in: 0)") {
                mockFRC.stub.numberOfObjectsShouldReturn = 0
                expect(testObject.businessCount).to(equal(0))
                
                mockFRC.stub.numberOfObjectsShouldReturn = 15
                expect(testObject.businessCount).to(equal(15))
            }
        }
        
        // MARK: - var delegate: FavoritesModelDelegate?
        describe("delegate") {
            it("sets the same delegate on the frc") {
                expect(testObject.delegate).to(be(mockFRC.delegate))
            }
        }
        
        // MARK: - func business(at indexPath: IndexPath) -> Business?
        describe("business(at indexPath: IndexPath) -> Business?") {
            context("given frc returns a business") {
                it("returns the business") {
                    let expectedBusiness = TestData.createBusiness()
                    mockFRC.stub.objectShouldReturn = expectedBusiness
                    
                    expect(testObject.business(at: IndexPath(row: 0, section: 0))).to(equal(expectedBusiness))
                    expect(mockFRC.stub.objectCallCount).to(equal(1))
                }
            }
            
            context("given frc returns nil") {
                it("returns nil") {
                    mockFRC.stub.objectShouldReturn = nil
                    
                    expect(testObject.business(at: IndexPath(row: 0, section: 0))).to(beNil())
                    expect(mockFRC.stub.objectCallCount).to(equal(1))
                }
            }
        }
        
        // MARK: - func delete(at indexPath: IndexPath)
        describe("delete(at indexPath: IndexPath)") {
            context("given frc.cdObject returns a business") {
                it("calls delete") {
                    mockFRC.stub.cdObjectShouldReturn = TestData.createCDBusiness()
                    
                    let expectedIndexPath = IndexPath(row: 0, section: 0)
                    
                    testObject.delete(at: expectedIndexPath)
                    
                    expect(mockFRC.stub.cdObjectCallCount).to(equal(1))
                    expect(mockFRC.stub.cdObjectCalledWith.first).to(equal(expectedIndexPath))                }
            }
            
            context("given frc.cdObject returns nil") {
                it("does not call delete") {
                    mockFRC.stub.cdObjectShouldReturn = nil
                    
                    let expectedIndexPath = IndexPath(row: 0, section: 0)
                    
                    testObject.delete(at: expectedIndexPath)
                    
                    expect(mockFRC.stub.cdObjectCallCount).to(equal(1))
                    expect(mockFRC.stub.cdObjectCalledWith.first).to(equal(expectedIndexPath))
                }
            }
        }
        
        // MARK: - func loadBusinesses()
        describe("loadBusinesses()") {
            it("calls performFetch on frc and downloadDidEnd on delegate") {
                testObject.loadBusinesses()
                
                expect(mockFRC.stub.performFetchCallCount).toEventually(equal(1))
                expect(mockDelegate.stub.downloadDidEndCallCount).toEventually(equal(1))
            }
        }
        // MARK: - func randomBusiness() -> Business?
        describe("randomBusiness() -> Business?") {
            context("given frc returns a business") {
                it("returns the business from frc") {
                    let expectedBusiness = TestData.createBusiness()
                    mockFRC.stub.randomElementShouldReturn = expectedBusiness
                    
                    expect(testObject.randomBusiness()).to(equal(TestData.createBusiness()))
                }
            }
            
            context("given frc returns nil") {
                it("returns nil") {
                    mockFRC.stub.randomElementShouldReturn = nil
                    
                    expect(testObject.randomBusiness()).to(beNil())
                }
            }
        }
    }
}
