import CoreData
import Quick
import Nimble

@testable import Find_My_Food

final class CDCoordinateSpec: QuickSpec {
    override func spec() {
        var testObject: CDCoordinate!
        var coreDataManager: CoreDataManagerProtocol!
        
        beforeEach {
            coreDataManager = globalInMemoryCoreDataManager
            testObject = CDCoordinate(context: coreDataManager.viewContext)
        }
        
        describe("NSManaged properties") {
            it("has the correct types") {
                testObject.business = nil
                testObject.latitude = 0.0
                testObject.longitude = 0.0
                
                expect(testObject.business).to(beAKindOf(CDBusiness?.self))
                expect(testObject.latitude).to(beAKindOf(Double.self))
                expect(testObject.longitude).to(beAKindOf(Double.self))
            }
        }
        
        describe("fetch request") {
            it("has the correct entityName") {
                let fetchRequest: NSFetchRequest<CDCoordinate> = CDCoordinate.fetchRequest()
            
                expect(fetchRequest.entityName).to(equal("CDCoordinate"))
            }
        }
        
        describe("CoreDataConvertible") {
            let expectedCoordinate = TestData.businessesFromJson().first!.coordinate

            beforeEach {
                testObject = CDCoordinate(expectedCoordinate, context: coreDataManager.viewContext)
            }
            
            it("is initialized from a Coordinate") {
                expect(testObject.latitude).to(equal(expectedCoordinate.latitude))
                expect(testObject.longitude).to(equal(expectedCoordinate.longitude))
            }
            
            it("can be converted to a Coordinate") {
                let coordinate = testObject.convert()
                
                expect(coordinate).to(equal(expectedCoordinate))
            }
        }
    }
}
