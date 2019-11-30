import CoreData
import Quick
import Nimble

@testable import Find_My_Food

final class CDCategorySpec: QuickSpec {
    override func spec() {
        var testObject: CDCategory!
        var coreDataManager: CoreDataManagerProtocol!
        
        beforeEach {
            coreDataManager = globalInMemoryCoreDataManager
            testObject = CDCategory(context: coreDataManager.viewContext)
        }
        
        describe("NSManaged properties") {
            it("has the correct types") {
                testObject.alias = ""
                testObject.title = ""
                
                expect(testObject.alias).to(beAKindOf(String.self))
                expect(testObject.title).to(beAKindOf(String.self))
            }
        }
        
        describe("fetch request") {
            it("has the correct entityName") {
                let fetchRequest: NSFetchRequest<CDCategory> = CDCategory.fetchRequest()
            
                expect(fetchRequest.entityName).to(equal("CDCategory"))
            }
        }
        
        describe("CoreDataConvertible") {
            let expectedCategory = TestData.businessesFromJson().first!.categories.first!

            beforeEach {
                testObject = CDCategory(expectedCategory, context: coreDataManager.viewContext)
            }
            
            it("is initialized from a Category") {
                expect(testObject.alias).to(equal(expectedCategory.alias))
                expect(testObject.title).to(equal(expectedCategory.title))
            }
            
            it("can be converted to a Category") {
                let category = testObject.convert()
                
                expect(category).to(equal(expectedCategory))
            }
        }
    }
}
