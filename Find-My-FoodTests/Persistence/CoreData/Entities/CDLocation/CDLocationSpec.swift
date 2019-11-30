import CoreData
import Quick
import Nimble

@testable import Find_My_Food

final class CDLocationSpec: QuickSpec {
    override func spec() {
        var testObject: CDLocation!
        var coreDataManager: CoreDataManagerProtocol!
        
        beforeEach {
            coreDataManager = globalInMemoryCoreDataManager
            testObject = CDLocation(context: coreDataManager.viewContext)
        }
        
        describe("NSManaged properties") {
            it("has the correct types") {
                testObject.address1 = ""
                testObject.address2 = ""
                testObject.address3 = ""
                testObject.city = ""
                testObject.country = ""
                testObject.displayAddress = [String]()
                testObject.state = ""
                testObject.zipCode = ""
                
                expect(testObject.address1).to(beAKindOf(String.self))
                expect(testObject.address2).to(beAKindOf(String?.self))
                expect(testObject.address3).to(beAKindOf(String?.self))
                expect(testObject.city).to(beAKindOf(String.self))
                expect(testObject.country).to(beAKindOf(String.self))
                expect(testObject.displayAddress).to(beAKindOf([String].self))
                expect(testObject.state).to(beAKindOf(String.self))
                expect(testObject.zipCode).to(beAKindOf(String.self))
            }
        }
        
        describe("fetch request") {
            it("has the correct entityName") {
                let fetchRequest: NSFetchRequest<CDLocation> = CDLocation.fetchRequest()
            
                expect(fetchRequest.entityName).to(equal("CDLocation"))
            }
        }
        
        describe("CoreDataConvertible") {
            let expectedLocation = TestData.businessesFromJson().first!.location

            beforeEach {
                testObject = CDLocation(expectedLocation, context: coreDataManager.viewContext)
            }
            
            it("is initialized from a Location") {
                expect(testObject.address1).to(equal(expectedLocation.address1))
                expect(testObject.address2).to(equal(expectedLocation.address2))
                expect(testObject.address3).to(equal(expectedLocation.address3))
                expect(testObject.city).to(equal(expectedLocation.city))
                expect(testObject.country).to(equal(expectedLocation.country))
                expect(testObject.displayAddress).to(equal(expectedLocation.displayAddress))
                expect(testObject.state).to(equal(expectedLocation.state))
                expect(testObject.zipCode).to(equal(expectedLocation.zipCode))
            }
            
            it("can be converted to a Location") {
                let location = testObject.convert()
                
                expect(location).to(equal(expectedLocation))
            }
        }
    }
}
