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
        // FIXME: - Make this work!
        
        describe("NSManaged properties") {
            it("has the correct types") {
                testObject.alias = ""
                testObject.title = ""
                
                expect(testObject.alias).to(beAKindOf(String.self))
                expect(testObject.title).to(beAKindOf(String.self))
            }
        }
        
        describe("fetch request") {
            let fetchRequest: NSFetchRequest<CDCategory> = CDCategory.fetchRequest()
            
            expect(fetchRequest.entityName).to(equal("CDCategory"))
        }
        
        describe("CoreDataConvertible") {
            it("is initialized from a Category") {
                
            }
            
            it("can be converted to a Category") {
                
            }
        }
    }
}
