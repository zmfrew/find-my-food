import Quick
import Nimble

@testable import Find_My_Food

final class BusinessFetchedResultsControllerSpec: QuickSpec {
    override func spec() {
        var testObject: BusinessFetchedResultsController!
        var mockCoreDataManager: CoreDataManager!
        
        beforeEach {
            mockCoreDataManager = globalInMemoryCoreDataManager
            testObject = BusinessFetchedResultsController(managedObjectContext: mockCoreDataManager.viewContext)
        }
        
        describe("initialization") {
            it("has no delegate") {
                expect(testObject.delegate).to(beNil())
            }
        }
        
        context("fetched result controller") {
            it("uses the managed object context from init") {
                expect(testObject.fetchedResultsController.managedObjectContext).to(beIdenticalTo(mockCoreDataManager.viewContext))
            }
            
            it("does not set a section name key path") {
                expect(testObject.fetchedResultsController.sectionNameKeyPath).to(beNil())
            }
            
            it("has no cache") {
                expect(testObject.fetchedResultsController.cacheName).to(beNil())
            }
            
            context("fetch request") {
                it("does not have a predicate") {
                    expect(testObject.fetchedResultsController.fetchRequest.predicate).to(beNil())
                }
                
                it("has one sort descriptor on name ascending") {
                    expect(testObject.fetchedResultsController.fetchRequest.sortDescriptors?.count).to(equal(1))
                    expect(testObject.fetchedResultsController.fetchRequest.sortDescriptors?.first?.key).to(equal("name"))
                    expect(testObject.fetchedResultsController.fetchRequest.sortDescriptors?.first?.ascending).to(beTrue())
                }
            }
        }
    }
}
