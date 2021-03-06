import CoreData
import Quick
import Foundation

@testable import Find_My_Food

final class Setup: QuickConfiguration {
    override class func configure(_ configuration: Configuration!) {
        let mom = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
        let container = NSPersistentContainer(name: "Find-My-Food", managedObjectModel: mom)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false

        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            precondition( description.type == NSInMemoryStoreType )

            if let error = error {
                fatalError("Creating in memory core data manager failed: \(error.localizedDescription)")
            }
        }

        globalInMemoryCoreDataManager = CoreDataManager(persistentContainer: container)
    }
}

private(set) var globalInMemoryCoreDataManager: CoreDataManager!

enum TestData {
    static func businessData() -> Data {
        let path = Bundle(identifier: "com.zachfrew.Find-My-FoodTests")!.path(forResource: "businesses", ofType: "json")!
        return try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
    }
    
    static func businessesFromJson() -> [Business] {
        let path = Bundle(identifier: "com.zachfrew.Find-My-FoodTests")!.path(forResource: "businesses", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let response = try! JSONDecoder().decode(Response.self, from: data)
        return response.businesses
    }
    
    static func businessesFromMockBusinessesFile() -> [Business] {
        let path = Bundle(identifier: "com.zachfrew.Find-My-FoodTests")!.path(forResource: "MockBusinesses", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        return try! JSONDecoder().decode([Business].self, from: data)
    }
    
    static func createBusiness() -> Business {
        Business(alias: "test alias",
                 categories: [],
                 coordinate: Coordinate(latitude: 1.0, longitude: 1.0),
                 displayPhone: "test displayPhone",
                 distance: 1.0,
                 id: "test id",
                 image: nil,
                 imageURLString: "test imageURLString",
                 isClosed: false,
                 location: Business.Location(address1: "test address1",
                                             address2: "test address2",
                                             address3: "test address3",
                                             city: "test city",
                                             country: "test country",
                                             displayAddress: [],
                                             state: "test state", zipCode: "test zipCode"),
                 name: "test name",
                 phone: "test phone",
                 priceLevel: "test priceLevel",
                 rating: 1.0,
                 reviewCount: 0,
                 transactions: [],
                 urlString: "test urlString")
    }
    
    static func createCDBusiness() -> CDBusiness {
        CDBusiness(TestData.createBusiness(), context: globalInMemoryCoreDataManager.viewContext)
    }
    
    static func responseFromJson() -> Response {
        let path = Bundle(identifier: "com.zachfrew.Find-My-FoodTests")!.path(forResource: "businesses", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        return try! JSONDecoder().decode(Response.self, from: data)
    }
}
