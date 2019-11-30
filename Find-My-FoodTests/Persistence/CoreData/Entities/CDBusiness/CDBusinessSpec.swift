import CoreData
import Quick
import Nimble

@testable import Find_My_Food

final class CDBusinessSpec: QuickSpec {
    override func spec() {
        var testObject: CDBusiness!
        var coreDataManager: CoreDataManagerProtocol!
        
        beforeEach {
            coreDataManager = globalInMemoryCoreDataManager
            testObject = CDBusiness(context: coreDataManager.viewContext)
        }
        
        describe("NSManaged properties") {
            it("has the correct types") {
                testObject.alias = ""
                testObject.categories = Set<CDCategory>()
                testObject.coordinate = CDCoordinate(context: coreDataManager.viewContext)
                testObject.displayPhone = ""
                testObject.distance = 0.0
                testObject.id = ""
                testObject.image = nil
                testObject.imageURLString = ""
                testObject.isClosed = false
                testObject.location = CDLocation(context: coreDataManager.viewContext)
                testObject.name = ""
                testObject.phone = ""
                testObject.priceLevel = ""
                testObject.rating = 0.0
                testObject.reviewCount = 0
                testObject.transactions = [String]()
                testObject.urlString = ""
                
                expect(testObject.alias).to(beAKindOf(String.self))
                expect(testObject.categories).to(beAKindOf(Set<CDCategory>.self))
                expect(testObject.coordinate).to(beAKindOf(CDCoordinate.self))
                expect(testObject.displayPhone).to(beAKindOf(String.self))
                expect(testObject.distance).to(beAKindOf(Double.self))
                expect(testObject.id).to(beAKindOf(String.self))
                expect(testObject.image).to(beNil())
                expect(testObject.imageURLString).to(beAKindOf(String.self))
                expect(testObject.isClosed).to(beAKindOf(Bool.self))
                expect(testObject.location).to(beAKindOf(CDLocation.self))
                expect(testObject.name).to(beAKindOf(String.self))
                expect(testObject.phone).to(beAKindOf(String.self))
                expect(testObject.priceLevel).to(beAKindOf(String?.self))
                expect(testObject.rating).to(beAKindOf(Double.self))
                expect(testObject.reviewCount).to(beAKindOf(Int16.self))
                expect(testObject.transactions).to(beAKindOf([String].self))
                expect(testObject.urlString).to(beAKindOf(String.self))
            }
        }
        
        describe("fetch request") {
            it("has the correct entityName") {
                let fetchRequest: NSFetchRequest<CDBusiness> = CDBusiness.fetchRequest()
                
                expect(fetchRequest.entityName).to(equal("CDBusiness"))
            }
        }
        
        describe("CoreDataConvertible") {
            let expectedBusiness = TestData.businessesFromJson().first!

            beforeEach {
                testObject = CDBusiness(expectedBusiness, context: coreDataManager.viewContext)
            }
            
            it("is initialized from a Business") {
                expect(testObject.alias).to(equal(expectedBusiness.alias))
                expect(testObject.categories.compactMap { $0.convert() }.sorted(by: {$0.alias > $1.alias})).to(equal(expectedBusiness.categories.sorted(by: { $0.alias > $1.alias })))
                expect(testObject.coordinate.convert()).to(equal(expectedBusiness.coordinate))
                expect(testObject.displayPhone).to(equal(expectedBusiness.displayPhone))
                expect(testObject.distance).to(equal(expectedBusiness.distance))
                expect(testObject.id).to(equal(expectedBusiness.id))
                expect(testObject.image).to(beNil())
                expect(testObject.imageURLString).to(equal(expectedBusiness.imageURLString))
                expect(testObject.isClosed).to(equal(expectedBusiness.isClosed))
                expect(testObject.location.convert()).to(equal(expectedBusiness.location))
                expect(testObject.name).to(equal(expectedBusiness.name))
                expect(testObject.phone).to(equal(expectedBusiness.phone))
                expect(testObject.priceLevel).to(equal(expectedBusiness.priceLevel))
                expect(testObject.rating).to(equal(expectedBusiness.rating))
                expect(testObject.reviewCount).to(equal(Int16(expectedBusiness.reviewCount)))
                expect(testObject.transactions).to(equal(expectedBusiness.transactions))
                expect(testObject.urlString).to(equal(expectedBusiness.urlString))
            }
            
            it("can be converted to a Business") {
                let business = testObject.convert()!
                
                expect(business.alias).to(equal(expectedBusiness.alias))
                expect(business.categories.sorted(by: {$0.alias > $1.alias})).to(equal(expectedBusiness.categories.sorted(by: { $0.alias > $1.alias })))
                expect(business.coordinate).to(equal(expectedBusiness.coordinate))
                expect(business.displayPhone).to(equal(expectedBusiness.displayPhone))
                expect(business.distance).to(equal(expectedBusiness.distance))
                expect(business.id).to(equal(expectedBusiness.id))
                expect(business.image).to(beNil())
                expect(business.imageURLString).to(equal(expectedBusiness.imageURLString))
                expect(business.isClosed).to(equal(expectedBusiness.isClosed))
                expect(business.location).to(equal(expectedBusiness.location))
                expect(business.name).to(equal(expectedBusiness.name))
                expect(business.phone).to(equal(expectedBusiness.phone))
                expect(business.priceLevel).to(equal(expectedBusiness.priceLevel))
                expect(business.rating).to(equal(expectedBusiness.rating))
                expect(business.reviewCount).to(equal(expectedBusiness.reviewCount))
                expect(business.transactions).to(equal(expectedBusiness.transactions))
                expect(business.urlString).to(equal(expectedBusiness.urlString))
            }
        }
    }
}
